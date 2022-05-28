module WSRoute
using HTTP
using HTTP.WebSockets
using HTTP.WebSockets: WebSocket, WebSocketError
using ...Events
using ...Protocol
using ...Protocol.Messages: @msg_str, messageid
using ...Server
using ...Server: iApplication, SessionContext
using ...Tokens

function route(io::HTTP.Stream, 𝐴::Server.iApplication)
    WebSockets.upgrade(io) do ws::WebSocket
        waittime = Server.CONFIG.wssleepperiod
        session  = nothing
        try
            session = onopen(ws, 𝐴)
            if !isnothing(session)
                while isopen(ws)
                    if iszero(Base.bytesavailable(ws.io))
                        (waittime ≤ 0) || sleep(waittime)
                    else
                        onmessage(ws, 𝐴, session)
                    end
                    yield()
                end
            end
        catch exc
            if !(exc isa EmptyMessageError)
                @error "Server ws error" exception = (exc, Base.catch_backtrace())
                if exc isa WebSocketError || exc isa Base.IOError
                    wserror(exc)
                else
                    rethrow()
                end
            end
        finally
            onclose(ws, 𝐴, session)
            close(ws)
        end
    end
end

macro wsassert(test, msg::String)
    esc(quote
        if !($test)
            wsclose(ω, 𝐴)
            Server.httperror($msg, 1000)
        end
    end)
end

macro safely(code)
    esc(:(if isopen(ω)
        $code
    else
        onclose(ω, 𝐴, σ)
        return nothing
    end))
end

function onopen(ω::WebSocket, 𝐴::iApplication)
    req                  = ω.request
    (subprotocol, token) = Tokens.subprotocol(HTTP.headers(req))

    @wsassert subprotocol == "bokeh" "Subprotocol header is not 'bokeh'"
    @wsassert !isnothing(token) "No token received in subprotocol header"

    payload = Server.Tokens.payload(token)
    @wsassert ("session_expiry" ∈ keys(payload)) "Session expiry has not been provided"
    @wsassert (time() < payload["session_expiry"]) "Token is expired"
    @wsassert Server.checktokensignature(𝐴, token) "Invalid token signature"

    σ = get!(𝐴, Server.SessionKey(Tokens.sessionid(token), token, req))
    push!(σ.clients, ω)
    @safely Protocol.send(ω, msg"ACK")
    σ
end

function onmessage(ω::WebSocket, 𝐴::iApplication, σ::SessionContext)
    @safely msg = Protocol.receive(ω, Server.CONFIG.wstimeout, Server.CONFIG.wssleepperiod)
    yield()
    try
        answer = handle(msg, 𝐴, σ)
        @safely Protocol.send(ω, answer...)
    catch exc
        @safely Protocol.send(ω, msg"ERROR", messageid(msg), sprint(showerror, exc))
        rethrow(exc)
    end
end

onclose(ω::WebSocket, ::iApplication, ::Nothing) = nothing
function onclose(ω::WebSocket, ::iApplication, σ::SessionContext)
    pop!(σ.clients, ω, nothing)
    nothing
end

struct EmptyMessageError <: Exception end
handle(msg::msg"EMPTY", _...) = throw(EmptyMessageError())

function handle(msg::msg"SERVER-INFO-REQ", ::iApplication, ::SessionContext)
    return (msg"SERVER-INFO-REPLY", messageid(msg))
end

function handle(msg::msg"PULL-DOC-REQ", ::iApplication, σ::SessionContext)
    return (msg"PULL-DOC-REPLY", messageid(msg), Protocol.pushdoc(σ.doc))
end

function handle(μ::msg"PUSH-DOC,PATCH-DOC", 𝐴::iApplication, σ::SessionContext)
    Protocol.onreceive!(μ, σ.doc, Server.eventlist(𝐴), σ.clients...)
    return (msg"OK", messageid(μ))
end

wsclose(ω::WebSockets.WebSocket, ::iApplication) = close(ω)

function wserror(::iApplication, ::SessionContext, exc::Exception)
    @info "Websocket error" exception = exc
end
end
using .WSRoute

@route GET ws WSRoute

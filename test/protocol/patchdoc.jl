@testset "send" begin
    doc  = BokehJL.Document()
    mdl  = ProtocolX(; id = 1)
    E    = BokehJL.Events
    json(x) = BokehJL.Protocol.Messages.JSON.json(BokehJL.Protocol.serialize(x))

    val   = json(E.ModelChangedEvent(mdl, :a, 10, 20))
    truth = """{"attr":"a","hint":null,"kind":"ModelChanged","model":{"id":"1"},"new":20}"""
    @test val == truth

    val   = json(E.RootAddedEvent(doc, mdl, 1))
    truth = """{"kind":"RootAdded","model":{"id":"1"}}"""
    @test val == truth

    val   = json(E.RootRemovedEvent(doc, mdl, 1))
    truth = """{"kind":"RootRemoved","model":{"id":"1"}}"""
    @test val == truth

    E.eventlist!() do
        push!(doc, mdl)
        # next change should not be sent to the client as the model is brand new
        mdl.a = 100
        val   = BokehJL.Protocol.Messages.JSON.json(BokehJL.Protocol.patchdoc(E.task_eventlist().events, doc, Set{Int64}()))
        truth = """{"events":[{"kind":"RootAdded","model":{"id":"1"}}],"""*
            """"references":[{"attributes":{"a":100},"id":"1","type":"$(nameof(ProtocolX))"}]}"""
        @test val == truth
    end

    E.eventlist!() do
        mdl.a = 10
        val   = BokehJL.Protocol.Messages.JSON.json(BokehJL.Protocol.patchdoc(E.task_eventlist().events, doc, Set{Int64}([mdl.id])))
        truth = """{"events":[{"attr":"a","hint":null,"kind":"ModelChanged","model":{"id":"1"},"new":10}],"references":[]}"""
        @test val == truth
    end
end

@testset "dereference!" begin
    cds = ProtocolX(; id = 14001)
    𝐶 = Dict{String, Any}(
        "events" => Any[Dict{String, Any}(
            "column_source" => Dict{String, Any}("id" => "14001"),
            "kind" => "ColumnDataChanged",
            "new" => Dict{String, Any}(
                "a" => Dict{String, Any}("dtype" => "float64", "shape" => Any[1], "__ndarray__" => "AAAAAAAAAEA=", "order" => "little")
            ),
            "cols" => Any["a"]
        )],
        "references" => Any[]
    )
    truth = Dict{String, Any}(
        "events" => Any[Dict{String, Any}(
            "column_source" => cds,
            "kind" => "ColumnDataChanged",
            "new" => Dict{String, Any}("a" => Float64[2.]),
            "cols" => Any["a"]
        )],
        "references" => Any[]
    )
    BokehJL.Protocol.PatchDocReceive._dereference!(𝐶, Dict{Int, BokehJL.iHasProps}(14001 => cds), BokehJL.Protocol.Buffers())

    @test 𝐶 == truth
end

@testset "receive" begin
    doc  = BokehJL.Document()
    mdl  = ProtocolX(; id = 100,a  = 10)
    E    = BokehJL.Events
    buf  = BokehJL.Protocol.Buffers()
    JSON = BokehJL.Protocol.Messages.JSON
    json1(x) = JSON.json(BokehJL.Protocol.serialize(x))
    json2(x) = JSON.json(BokehJL.Protocol.Serialize.serialref(x, BokehJL.Protocol.Serialize.Rules()))
    jsref(x) = JSON.parse(json1(x))
    js(x)    = JSON.parse(json2(x))
    @testset "add first root" begin
        E.eventlist!() do
            cnt = Dict(
                "references" => [jsref(mdl)],
                "events" =>  [js(E.RootAddedEvent(doc, mdl, 1))],
            )

            @test isempty(doc)
            BokehJL.Protocol.patchdoc!(doc, cnt, buf)
            @test length(doc) == 1
            @test BokehJL.bokehid(doc[1]) == 100
            @test doc[1].a == 10
            @test doc[1] ≢ mdl
        end
    end

    @testset "add root again" begin
        E.eventlist!() do
            cnt = Dict(
                "references" => [],
                "events" =>  [js(E.RootAddedEvent(doc, mdl, 1))],
            )

            @test length(doc) == 1
            @test_throws ErrorException BokehJL.Protocol.patchdoc!(doc, cnt, buf)
            @test length(doc) == 1
        end
    end

    @testset "remove root" begin
        E.eventlist!() do
            cnt = Dict(
                "references" => [],
                "events" =>  [js(E.RootRemovedEvent(doc, mdl, 1))],
            )

            @test length(doc) == 1
            BokehJL.Protocol.patchdoc!(doc, cnt, buf)
            @test isempty(doc)
        end
    end

    @testset "change title" begin
        E.eventlist!() do
            cnt = Dict(
                "references" => [],
                "events" =>  [js(E.TitleChangedEvent(doc, "A"))],
            )

            setfield!(doc, :title, "----")
            BokehJL.Protocol.patchdoc!(doc, cnt, buf)
            @test doc.title == "A"
        end
    end

    ymdl  = ProtocolY()
    @testset "add y root" begin
        E.eventlist!() do
            cnt = Dict(
                "references" => [jsref(ymdl), jsref(ymdl.a), jsref(mdl)],
                "events" =>  [
                    js(E.RootAddedEvent(doc, mdl, 1)),
                    js(E.RootAddedEvent(doc, ymdl, 1))
                ],
            )

            @test isempty(doc)
            BokehJL.Protocol.patchdoc!(doc, cnt, buf)
            @test length(doc) == 2
            @test doc[1].id ≡ mdl.id
            @test doc[2].id ≡ ymdl.id
            @test doc[2].a.id ≡ ymdl.a.id
        end
    end

    @testset "change attribute" begin
        E.eventlist!() do
            other = ProtocolX()
            cnt = Dict(
                "references" => [jsref(other)],
                "events" =>  [js(E.ModelChangedEvent(ymdl, :a, nothing, other))],
            )

            @test length(doc) == 2
            @test last(doc).a.id ≢ other.id
            BokehJL.Protocol.patchdoc!(doc, cnt, buf)
            @test length(doc) == 2
            @test last(doc).a.id ≡ other.id
        end
    end

    @testset "action attribute" begin
        btn = BokehJL.Models.Button()
        E.eventlist!() do
            push!(getfield(doc, :roots), btn)

            called = Ref(false)
            BokehJL.onchange(btn) do x
                called[] = true
            end
                
            cnt = Dict(
                "references" => [],
                "events" =>  [js(BokehJL.Models.Actions.ButtonClick(; model = btn))],
            )
            BokehJL.Protocol.patchdoc!(doc, cnt, buf)
            @test called[]
        end
    end
end

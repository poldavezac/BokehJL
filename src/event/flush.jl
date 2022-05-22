eventcallbacks(key::iDocumentEvent)    = key.doc.callbacks
eventcallbacks(key::ModelChangedEvent) = getfield(key.model, :callbacks)

flushevents!()                = flushevents!(task_eventlist())
flushevents!(::NullEventList) = iEvent[]

function flushevents!(λ::iEventList)
    lst = iEvent[]
    while !isempty(λ)
        evt = popfirst!(λ)
        for cb ∈ eventcallbacks(evt)
            cb(evt)
        end
        push!(lst, evt)
    end
    lst
end

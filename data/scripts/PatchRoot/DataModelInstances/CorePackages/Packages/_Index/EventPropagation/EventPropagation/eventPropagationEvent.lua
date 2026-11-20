-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T03:41:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}
module.__index = module

function module.new(targetInstance, currentInstance, eventName: string, phase: string, synthetic: boolean?, eventData)
    local tbl1 = {
        cancelled = false,
        phase = phase,
        currentInstance = currentInstance,
        targetInstance = targetInstance,
        eventName = eventName,
        synthetic = synthetic or false,
        eventData = 0
    }

    if type(eventData) == "table" and not table.isfrozen(eventData) then
        eventData = table.freeze(eventData)
    end

    tbl1.eventData = eventData

    setmetatable(tbl1, module)
    return tbl1
end

function module:cancel()
    self.cancelled = true
end

return module

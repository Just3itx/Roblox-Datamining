-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-18T23:21:15Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local CrossExperience = script:FindFirstAncestor("CrossExperience")

local _Types = require(CrossExperience.Types)

local Logger = require(CrossExperience.Logger)

local module = {}
module.__index = module

local function getFirstKeyInTable(events) -- Luacid: Inlined by compiler; 1 call site recovered
    local var1 = nil
    if events then
        for k, _ in pairs(events) do
            return k
        end
    end
    return var1
end

function module.new(requiresEventsInOrder: boolean)
    local tbl1 = {
        queues = {},
        requiresEventsInOrder = requiresEventsInOrder
    }
    setmetatable(tbl1, module)
    return tbl1
end

function module:processNextEvent(str1: string, tbl1)
    local var1 = self.queues[str1]
    if not var1 then
        Logger:error("EventQueue: queue not found for origin {} abort processing", str1)
        return
    end
    if var1.nextSequenceNumber == nil then
        local nextSequenceNumber = getFirstKeyInTable(var1.events)
        if nextSequenceNumber ~= nil then
            Logger:info("EventQueue: sequence for {} at {}", str1, nextSequenceNumber)
            var1.nextSequenceNumber = nextSequenceNumber
        end
    end

    local event = var1.events[var1.nextSequenceNumber]
    if not event then
        if tbl1 then
            Logger:info(
                "EventQueue: delaying processing event {} seq {} expecting {}",
                tbl1.event.NOTIFY,
                tbl1.params._seq,
                var1.nextSequenceNumber
            )
        end
        return
    end

    Logger:info("EventQueue: processing event {} seq {}", event.event.NOTIFY, event.params._seq)
    if not tbl1 then
        Logger:info("EventQueue: event originally delayed {} seq {} ", event.event.NOTIFY, event.params._seq)
    end

    event.callback(event.params)
    var1.events[var1.nextSequenceNumber] = nil
    var1.nextSequenceNumber += 1
    self:processNextEvent(str1)
end

function module:reset()
    self.queues = {}
end

function module:process(event, params, callback: ((...any) -> (...any))?)
    if not params then
        Logger:error("EventQueue: invalid event {} params missing", event.NOTIFY)
        return
    end

    local _origin = params._origin
    local _seq = params._seq

    if not (_origin and _seq and self.requiresEventsInOrder) then
        Logger:info("EventQueue: event {} processing immediately", event.NOTIFY)
        if callback then
            callback(params)
        end
        return
    end

    if not self.queues[_origin] then
        Logger:info("EventQueue: initiating queue {}", _origin)
        self.queues[_origin] = {
            nextSequenceNumber = nil,
            events = {}
        }
    end

    Logger:info(
        "EventQueue: new event {} seq {} current seq {}",
        event.NOTIFY,
        _seq,
        self.queues[_origin].nextSequenceNumber
    )

    local tbl1 = { event = event, params = params, callback = callback }

    self.queues[_origin].events[_seq] = tbl1
    self:processNextEvent(_origin, tbl1)
end

return module

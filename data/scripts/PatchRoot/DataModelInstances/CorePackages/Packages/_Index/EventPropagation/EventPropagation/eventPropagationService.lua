-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T07:01:26Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local FocusNavigationUtils = require(scriptParentParent.FocusNavigationUtils)
local getAncestors = FocusNavigationUtils.getAncestors
local mockableWarn = FocusNavigationUtils.mockableWarn

local eventPropagationEvent = require(script.Parent.eventPropagationEvent)

local __DEBUG_EVENT_PROPAGATION__ = _G.__DEBUG_EVENT_PROPAGATION__

local function describeFunction(func1: (...any) -> (...any)): string
    return table.concat(table.pack(debug.info(func1, "sln")), " ")
end

local function getEventsFromRegistry(tbl1, arg1) -- Luacid: Inlined by compiler; 13 call sites recovered
    return tbl1[arg1]
end

local function getEventPhasesFromRegistry(eventHandlerRegistry, arg1, str1: string) -- Luacid: Inlined by compiler; 6 call sites recovered
    local eventsFromRegistry = getEventsFromRegistry(eventHandlerRegistry, arg1)

    return if eventsFromRegistry then eventsFromRegistry[str1] else nil
end

local function getEventHandler(eventHandlerRegistry, arg1, str1: string, str2: string) -- Luacid: Inlined by compiler; 4 call sites recovered
    local eventPhasesFromRegistry = getEventPhasesFromRegistry(eventHandlerRegistry, arg1, str1)
    return if eventPhasesFromRegistry == nil then nil else eventPhasesFromRegistry[str2]
end

local module = ({})
module.__index = module

function module:registerEventHandler(arg1, str1: string, handler: (...any) -> (...any), arg2)
    if __DEBUG_EVENT_PROPAGATION__ then
        print("+++ register handler", str1, tostring(arg1), arg2 or "Bubble")
    end

    local var1 = arg2 or "Bubble"
    self.eventHandlerRegistry[arg1] = self.eventHandlerRegistry[arg1] or {}
    self.eventHandlerRegistry[arg1][str1] = self.eventHandlerRegistry[arg1][str1] or {}
    if _G.__DEV__ then
        local var2 = self.eventHandlerRegistry[arg1][str1][var1]
        if var2 then
            mockableWarn(
                (getEventsFromRegistry(string, "format"))(
                    "New handler bound to the %s phase of '%s' will override an existing handler:\n\tprevious handler: %s\n\t     new handler: %s",
                    var1,
                    str1,
                    (getEventsFromRegistry(table, "concat"))(
                        (getEventsFromRegistry(table, "pack"))((getEventsFromRegistry(debug, "info"))(handler, "sln")),
                        " "
                    ),
                    describeFunction(var2)
                )
            )
        end
    end
    self.eventHandlerRegistry[arg1][str1][var1] = handler
end

function module:registerEventHandlers(arg1, tbl1)
    if not self.eventHandlerRegistry[arg1] then
        self.eventHandlerRegistry[arg1] = {}
    end
    for value, value2 in tbl1 do
        self:registerEventHandler(arg1, value, value2.handler, value2.phase)
    end
end

function module:deregisterEventHandlers(arg1, tbl1)
    if not self.eventHandlerRegistry[arg1] then
        return
    end
    for value, value2 in tbl1 do
        self:deregisterEventHandler(arg1, value, value2.handler, value2.phase)
    end
end

function module:deregisterEventHandler(arg1, str1: string, handler: (...any) -> (...any), arg2)
    if __DEBUG_EVENT_PROPAGATION__ then
        print("--- deregister handler", str1, tostring(arg1), arg2 or "Bubble")
    end
    local var1 = arg2 or "Bubble"
    local eventPhasesFromRegistry = getEventPhasesFromRegistry(self.eventHandlerRegistry, arg1, str1)
    if not (eventPhasesFromRegistry and eventPhasesFromRegistry[var1]) then
        if _G.__DEV__ then
            mockableWarn(string.format("Cannot deregister unregistered event handler bound to the %s phase of '%s'", var1, str1))
        end

        return
    end

    if _G.__DEV__ then
        local handler2 = eventPhasesFromRegistry[var1]
        if handler2 ~= handler then
            mockableWarn(
                string.format(
                    "Deregistering non-matching event handler bound to the %s phase of '%s':\n\tprevious handler: %s\n\t     new handler: %s",
                    var1,
                    str1,
                    if type(handler) == "function" then table.concat(table.pack(debug.info(handler, "sln")), " ") else tostring(handler),
                    if type(handler2) == "function" then table.concat(table.pack(debug.info(handler2, "sln")), " ") else tostring(handler2)
                )
            )
        end
    end

    eventPhasesFromRegistry[var1] = nil
end

function module.getRegisteredEventHandlers(tbl1, arg1)
    local eventsFromRegistry = getEventsFromRegistry(getEventsFromRegistry(tbl1, "eventHandlerRegistry"), arg1)
    if not eventsFromRegistry then
        return nil
    end

    local registeredEventHandlers = ({})
    for value, value2 in eventsFromRegistry do
        registeredEventHandlers[value] = next(value2) ~= nil
    end

    return registeredEventHandlers
end

function module.propagateEvent(tbl1, arg1, str1: string, arg2, tbl2)
    local tbl3 = tbl2 or {}
    local synthetic = tbl3.synthetic or false
    local silent = tbl3.silent or false

    local function runEventHandler(arg3, str2: string) -- Luacid: Inlined by compiler; 3 call sites recovered
        local eventHandler = getEventHandler(tbl1.eventHandlerRegistry, arg3, str1, str2)
        if not eventHandler then
            return false
        end

        local eventPropagationEvent2 = eventPropagationEvent.new(arg1, arg3, str1, str2, synthetic, arg2)
        eventHandler(eventPropagationEvent2)

        return eventPropagationEvent2.cancelled
    end

    local var1 = silent and { arg1 } or getAncestors(arg1)

    if __DEBUG_EVENT_PROPAGATION__ then
        print(">>> capture event", str1, "for", tostring(arg1))
    end

    for i = #var1, 1, -1 do
        if runEventHandler(var1[i], "Capture") then
            return
        end
    end

    if runEventHandler(arg1, "Target") then
        return
    end

    if __DEBUG_EVENT_PROPAGATION__ then
        print("<<< bubble event", str1, "from", tostring(arg1))
    end

    for i = 1, #var1 do
        if runEventHandler(var1[i], "Bubble") then
            return
        end
    end
end

function module.new()
    local tbl1 = {
        eventHandlerRegistry = setmetatable({}, { __mode = "k" })
    }
    setmetatable(tbl1, module)
    return tbl1
end

return module

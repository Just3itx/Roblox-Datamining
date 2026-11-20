-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:31:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local Cryo = require(scriptParentParent.Parent.Cryo)

local module = {}

module.__index = module

local function validateStateTableItem(arg1, str1: string) -- Luacid: Inlined by compiler; 5 call sites recovered
    local str2 = typeof(arg1)

    local format = string.format
    local str3 = tostring(arg1)
    assert(
        str2 == "string" or str2 == "userdata",
        format("%s '%s' must be a string or userdata but is a %s", str1, str3, str2)
    )
end

function module.new(name, currentState, currentContext, arg2)
    assert(typeof(name) == "string", "name must be a string")
    assert(#name > 0, "name must not be an empty string")
    validateStateTableItem(currentState, "initialState")
    assert(currentContext == nil or typeof(currentContext) == "table", "initialContext must be a table or nil")

    assert(typeof(arg2) == "table", "transitionTable must be a table")
    assert(typeof(arg2[currentState]) == "table", "initialState must be present in transitionTable")

    local result = {}
    setmetatable(result, module)

    result.name = name
    result.currentState = currentState
    result.currentContext = currentContext or {}
    result.transitionTable = {}
    result.events = {}

    for k, value in pairs(arg2) do
        validateStateTableItem(k, "state")
        assert(typeof(value) == "table", string.format("state '%s' must map to a table", tostring(k)))

        local tbl1 = ({})
        for k2, value2 in pairs(value) do
            validateStateTableItem(k2, "event")
            assert(typeof(value2) == "table", string.format("event '%s' must map to a table", tostring(k2)))

            local nextState = value2.nextState
            local action = value2.action

            if nextState ~= nil then
                validateStateTableItem(nextState, "nextState")
                assert(arg2[nextState] ~= nil, string.format("nextState '%s' does not exist in transitionTable", tostring(nextState)))
            end

            assert(action == nil or typeof(action) == "function", "action must be a function")

            tbl1[k2] = value2

            if result.events[k2] == nil then
                result.events[k2] = function(arg3)
                    return result:handleEvent(k2, arg3)
                end
            end
        end

        result.transitionTable[k] = tbl1
    end

    setmetatable(result.events, {
        __index = function(_, arg3)
            error(string.format("'%s' is not a valid event in StateTable '%s'", tostring(arg3), result.name), 2)
        end
    })

    return result
end

function module:handleEvent(arg1, arg2)
    validateStateTableItem(arg1, "event")
    assert(arg2 == nil or typeof(arg2) == "table", "args must be nil or valid table")

    local currentState = self.currentState
    local var1 = self.transitionTable[currentState]

    assert(var1 ~= nil, "no transition events for current state")

    if var1[arg1] == nil then
        return
    end

    local var2 = var1[arg1]
    local var3 = var2.nextState or currentState
    local action = var2.action

    local currentContext = self.currentContext
    if action ~= nil then
        local var4 = action(currentState, var3, arg2, self.currentContext) or {}
        currentContext = Cryo.Dictionary.join(self.currentContext, var4)
        self.currentContext = currentContext
    end

    self.currentState = var3

    if self.stateChangeHandler ~= nil then
        self.stateChangeHandler(currentState, var3, currentContext)
    end
end

function module.onStateChange(arg1, stateChangeHandler)
    assert(
        stateChangeHandler == nil or typeof(stateChangeHandler) == "function",
        "stateChangeHandler must be nil or a function"
    )

    arg1.stateChangeHandler = stateChangeHandler
end

return module

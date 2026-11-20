-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:00:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local _ControlState = require(Foundation.Enums.ControlState)
local _ControlStateEvent = require(Foundation.Enums.ControlStateEvent)
local Logger = require(Foundation.Utility.Logger)

local module = {}

module.__index = module

function module.new(name: string, currentState, tbl1)
    assert(#name > 0, "name must not be an empty string")
    assert(tbl1[currentState] ~= nil, "initialState must be present in transitionTable")

    local result = {}
    setmetatable(result, module)

    result.name = name
    result.currentState = currentState
    result.transitionTable = {}
    result.events = {}

    for value, value2 in tbl1 do
        local tbl2 = ({})
        for value3, value4 in value2 do
            local nextState = value4.nextState

            if nextState ~= nil then
                assert(tbl1[nextState] ~= nil, "nextState does not exist in transitionTable")
            end

            tbl2[value3] = value4

            if result.events[value3] == nil then
                result.events[value3] = function()
                    return result:handleEvent(value3)
                end
            end
        end

        result.transitionTable[value] = tbl2
    end

    setmetatable(result.events, {
        __index = function(_, arg1)
            error(string.format("'%s' is not a valid event in StateTable '%s'", tostring(arg1), result.name), 2)
        end
    })

    return result
end

function module:handleEvent(str1: string)
    local currentState = self.currentState
    local var1 = self.transitionTable[currentState][str1]

    if var1 == nil then
        Logger:debug("No transition found for event " .. str1 .. " in state " .. currentState)
        return
    end

    local nextState = var1.nextState

    self.currentState = nextState

    if self.stateChangeHandler ~= nil then
        self.stateChangeHandler(nextState)
    end
end

function module.onStateChange(tbl1, stateChangeHandler: ((...any) -> (...any))?)
    tbl1.stateChangeHandler = stateChangeHandler
end

return module

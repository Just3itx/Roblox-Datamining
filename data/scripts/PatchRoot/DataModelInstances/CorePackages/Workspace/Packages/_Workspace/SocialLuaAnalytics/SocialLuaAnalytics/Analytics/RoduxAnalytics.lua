-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T16:10:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Actions = require(script.Actions)
local Selectors = require(script.Selectors)
local Reducers = require(script.Reducers)
local _AnalyticsTypes = require(script.AnalyticsTypes)

return {
    config = function(arg1)
        return {
            installReducer = function()
                return Reducers(arg1)
            end,
            Actions = Actions(arg1),
            Selectors = Selectors(arg1)
        }
    end
}

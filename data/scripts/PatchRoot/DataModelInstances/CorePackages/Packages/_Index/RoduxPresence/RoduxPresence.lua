-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:11:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local Cryo = require(scriptParent.Cryo)
local RoduxNetworking = require(scriptParent.RoduxNetworking)
local NetworkingPresence = require(scriptParent.NetworkingPresence)

local Reducer = require(script.Reducer)
local Actions = require(script.Actions)
local Selectors = require(script.Selectors)
local Models = require(script.Models)
local Enums = require(script.Enums)

return {
    config = function(arg1)
        local var1 = Cryo.Dictionary.join(
            arg1,
            {
                presenceNetworking = NetworkingPresence.config({ roduxNetworking = RoduxNetworking.mock() })
            }
        )

        return {
            installReducer = function()
                return Reducer(var1)
            end,
            Actions = Actions(var1),
            Selectors = Selectors(var1),
            Models = Models,
            Enums = Enums
        }
    end
}

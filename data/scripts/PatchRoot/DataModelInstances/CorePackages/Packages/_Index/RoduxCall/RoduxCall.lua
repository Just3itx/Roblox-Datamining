-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:40:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Actions = require(script.Actions)
local Enums = require(script.Enums)
local Reducers = require(script.Reducers)
local Models = require(script.Models)

local scriptParent = script.Parent
local Cryo = require(scriptParent.Cryo)
local RoduxNetworking = require(scriptParent.RoduxNetworking)
local NetworkingCall = require(scriptParent.NetworkingCall)

return {
    config = function(arg1)
        local var1 = Cryo.Dictionary.join(arg1, { NetworkingCall = NetworkingCall.config({ roduxNetworking = RoduxNetworking.mock() }) })

        return {
            installReducer = function()
                return Reducers(var1)
            end,
            Actions = Actions,
            Enums = Enums,
            Models = Models
        }
    end
}

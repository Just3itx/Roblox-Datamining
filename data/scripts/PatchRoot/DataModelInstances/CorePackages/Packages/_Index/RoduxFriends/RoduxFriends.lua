-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:50:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local llama = require(scriptParent.llama)
local RoduxNetworking = require(scriptParent.RoduxNetworking)
local FriendsNetworking = require(scriptParent.FriendsNetworking)
local NetworkingBlocking = require(scriptParent.NetworkingBlocking)

local FriendsReducer = require(script.Reducers.FriendsReducer)
local Actions = require(script.Actions)
local Selectors = require(script.Selectors)
local Models = require(script.Models)
local Enums = require(script.Enums)

return {
    config = function(arg1)
        local var1 = llama.Dictionary.join(arg1, {
            friendsNetworking = FriendsNetworking.config({ roduxNetworking = RoduxNetworking.mock() }),
            networkingBlocking = NetworkingBlocking.config({ roduxNetworking = RoduxNetworking.mock() })
        })

        return {
            installReducer = function()
                return FriendsReducer(var1)
            end,
            Actions = Actions(var1),
            Selectors = Selectors(var1),
            Models = Models,
            Enums = Enums
        }
    end
}

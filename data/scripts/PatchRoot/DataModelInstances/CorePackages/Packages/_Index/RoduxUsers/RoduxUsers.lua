-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:30:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Reducers = require(script.Reducers)
local Actions = require(script.Actions)
local Models = require(script.Models)

local scriptParent = script.Parent
local Cryo = require(scriptParent.Cryo)
local RoduxNetworking = require(scriptParent.RoduxNetworking)
local FriendsNetworking = require(scriptParent.FriendsNetworking)
local UsersNetworking = require(scriptParent.UsersNetworking)
local roduxUsersTypes = require(script.roduxUsersTypes)

return {
    config = function(arg1)
        local var1 = Cryo.Dictionary.join(arg1, {
            usersNetworking = UsersNetworking.config({ roduxNetworking = RoduxNetworking.mock() }),
            friendsNetworking = FriendsNetworking.config({ roduxNetworking = RoduxNetworking.mock() })
        })

        return {
            installReducer = function()
                return Reducers(var1)
            end,
            Actions = Actions,
            Models = Models,
            roduxUsersTypes = roduxUsersTypes
        }
    end
}

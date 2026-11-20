-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:21:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local Dash = require(scriptParent.Dash)
local RoduxNetworking = require(scriptParent.RoduxNetworking)
local NetworkingUserSettings = require(scriptParent.NetworkingUserSettings)
local NetworkingAccountInformation = require(scriptParent.NetworkingAccountInformation)
local UserPermissionsReducer = require(script.Reducers.UserPermissionsReducer)

return {
    config = function(arg1)
        local var1 = Dash.join(arg1, {
            networkingUserSettings = NetworkingUserSettings.config({ roduxNetworking = RoduxNetworking.mock() }),
            networkingAccountInformation = NetworkingAccountInformation.config({ roduxNetworking = RoduxNetworking.mock() })
        })

        return {
            installReducer = function()
                return UserPermissionsReducer(var1)
            end
        }
    end
}

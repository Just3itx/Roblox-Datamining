-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:01:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local RoduxNetworking = require(scriptParent.RoduxNetworking)
local Dash = require(scriptParent.Dash)
local NetworkingGames = require(scriptParent.NetworkingGames)

local Reducers = require(script.Reducers)
local Actions = require(script.Actions)
local Models = require(script.Models)
local Enums = require(script.Enums)

return {
    config = function(arg1)
        local var1 = Dash.join(arg1, { networkingGames = NetworkingGames.config({ roduxNetworking = RoduxNetworking.mock() }) })

        return {
            installReducer = function()
                return Reducers(var1)
            end,
            Actions = Actions,
            Models = Models,
            Enums = Enums
        }
    end
}

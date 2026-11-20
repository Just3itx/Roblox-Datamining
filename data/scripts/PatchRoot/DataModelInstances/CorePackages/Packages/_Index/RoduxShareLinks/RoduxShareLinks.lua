-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:21:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Reducers = require(script.Reducers)
local Actions = require(script.Actions)
local Models = require(script.Models)
local Enums = require(script.Enums)

local scriptParent = script.Parent
local Cryo = require(scriptParent.Cryo)
local RoduxNetworking = require(scriptParent.RoduxNetworking)
local ShareLinksNetworking = require(scriptParent.ShareLinksNetworking)

return {
    config = function(arg1)
        local var1 = Cryo.Dictionary.join(
            arg1,
            {
                shareLinksNetworking = ShareLinksNetworking.config({ roduxNetworking = RoduxNetworking.mock() })
            }
        )

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

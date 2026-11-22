-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T08:00:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local NavigationRodux = script:FindFirstAncestor("NavigationRodux")
local NavigationRoduxParent = NavigationRodux.Parent

local FFlagSignalsNavP2NavigationPrimitives = require(NavigationRoduxParent.SharedFlags).FFlagSignalsNavP2NavigationPrimitives
local NavigationCommands = if FFlagSignalsNavP2NavigationPrimitives then require(NavigationRoduxParent.RobloxAppNavigation).NavigationCommands else nil
local SetNavigationLocked = require(NavigationRodux.Thunks.SetNavigationLocked)
local ArgCheck = require(NavigationRoduxParent.ArgCheck)

local Cryo = require(NavigationRoduxParent.Cryo)
local RoactNavigation = require(NavigationRoduxParent.RoactNavigation)
local RNAdapterThunk = require(NavigationRodux.Thunks.RNAdapterThunk)

return function(arg1, arg2)
    ArgCheck.isType(arg1, "table", "route")
    ArgCheck.isTypeOrNil(arg2, "boolean", "bypassNavigationLock")

    if FFlagSignalsNavP2NavigationPrimitives then
        return function()
            NavigationCommands.to(NavigationCommands.fromLegacyPage(arg1[#arg1]), arg2)
        end
    end

    return RNAdapterThunk.new("NavigateToRoute", function(arg3, callback)
        if arg3:getState().Navigation.lockNavigationActions and not arg2 then
            return
        end

        arg3:dispatch(SetNavigationLocked(true))

        local var1 = arg1[#arg1]
        callback(
            RoactNavigation.Actions.navigate(
                {
                    routeName = var1.name,
                    params = Cryo.Dictionary.join(var1, { name = Cryo.None, rnKey = Cryo.None })
                }
            )
        )
    end)
end

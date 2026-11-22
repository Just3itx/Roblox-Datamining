-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T08:00:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local NavigationRodux = script:FindFirstAncestor("NavigationRodux")
local NavigationRoduxParent = NavigationRodux.Parent

local FFlagSignalsNavP2NavigationPrimitives = require(NavigationRoduxParent.SharedFlags).FFlagSignalsNavP2NavigationPrimitives
local NavigationCommands = if FFlagSignalsNavP2NavigationPrimitives then require(NavigationRoduxParent.RobloxAppNavigation).NavigationCommands else nil
local Cryo = require(NavigationRoduxParent.Cryo)
local SetNavigationLocked = require(NavigationRodux.Thunks.SetNavigationLocked)
local ArgCheck = require(NavigationRoduxParent.ArgCheck)

local RoactNavigation = require(NavigationRoduxParent.RoactNavigation)
local RNAdapterThunk = require(NavigationRodux.Thunks.RNAdapterThunk)

return function(arg1, arg2)
    ArgCheck.isType(arg1, "table", "page")
    ArgCheck.isTypeOrNil(arg2, "boolean", "bypassNavigationLock")

    if FFlagSignalsNavP2NavigationPrimitives then
        return function()
            NavigationCommands.down(NavigationCommands.fromLegacyPage(arg1), arg2)
        end
    end

    return RNAdapterThunk.new("NavigateDown", function(arg3, callback)
        if arg3:getState().Navigation.lockNavigationActions and not arg2 then
            return
        end

        arg3:dispatch(SetNavigationLocked(true))

        callback(
            RoactNavigation.StackActions.push(
                {
                    routeName = arg1.name,
                    params = Cryo.Dictionary.join(arg1, { name = Cryo.None, rnKey = Cryo.None })
                }
            )
        )
    end)
end

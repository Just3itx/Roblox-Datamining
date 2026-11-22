-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T08:00:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local NavigationRodux = script:FindFirstAncestor("NavigationRodux")
local NavigationRoduxParent = NavigationRodux.Parent

local FFlagSignalsNavP2NavigationPrimitives = require(NavigationRoduxParent.SharedFlags).FFlagSignalsNavP2NavigationPrimitives
local NavigationCommands = if FFlagSignalsNavP2NavigationPrimitives then require(NavigationRoduxParent.RobloxAppNavigation).NavigationCommands else nil
local Cryo = require(NavigationRoduxParent.Cryo)
local ArgCheck = require(NavigationRoduxParent.ArgCheck)
local RoactNavigation = require(NavigationRoduxParent.RoactNavigation)

local SetNavigationLocked = require(NavigationRodux.Thunks.SetNavigationLocked)
local RNAdapterThunk = require(NavigationRodux.Thunks.RNAdapterThunk)

return function(arg1, bool1: boolean?)
    ArgCheck.isType(arg1, "table", "page")
    ArgCheck.isTypeOrNil(bool1, "boolean", "bypassNavigationLock")

    if FFlagSignalsNavP2NavigationPrimitives then
        return function()
            NavigationCommands.fromWebView(NavigationCommands.fromLegacyPage(arg1), bool1)
        end
    end

    return RNAdapterThunk.new("NavigateFromWebView", function(arg2, callback)
        if arg2:getState().Navigation.lockNavigationActions and not bool1 then
            return
        end

        arg2:dispatch(SetNavigationLocked(true))
        callback(
            RoactNavigation.StackActions.replace(
                {
                    routeName = arg1.name,
                    key = arg1.key,
                    params = Cryo.Dictionary.join(arg1, { name = Cryo.None, rnKey = Cryo.None })
                }
            )
        )
    end)
end

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T08:00:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local NavigationRodux = script:FindFirstAncestor("NavigationRodux")
local NavigationRoduxParent = NavigationRodux.Parent

local FFlagSignalsNavP2NavigationPrimitives = require(NavigationRoduxParent.SharedFlags).FFlagSignalsNavP2NavigationPrimitives
local NavigationCommands = if FFlagSignalsNavP2NavigationPrimitives then require(NavigationRoduxParent.RobloxAppNavigation).NavigationCommands else nil
local SetNavigationLocked = require(NavigationRodux.Thunks.SetNavigationLocked)
local ArgCheck = require(NavigationRoduxParent.ArgCheck)

local RoactNavigation = require(NavigationRoduxParent.RoactNavigation)
local RNAdapterThunk = require(NavigationRodux.Thunks.RNAdapterThunk)

return function(bool1: boolean?)
    ArgCheck.isTypeOrNil(bool1, "boolean", "bypassNavigationLock")

    if FFlagSignalsNavP2NavigationPrimitives then
        return function(_)
            NavigationCommands.back(bool1)
        end
    end

    return RNAdapterThunk.new("NavigateBack", function(arg1, callback)
        if arg1:getState().Navigation.lockNavigationActions and not bool1 then
            return
        end

        arg1:dispatch(SetNavigationLocked(true))
        callback(RoactNavigation.Actions.back())
    end)
end

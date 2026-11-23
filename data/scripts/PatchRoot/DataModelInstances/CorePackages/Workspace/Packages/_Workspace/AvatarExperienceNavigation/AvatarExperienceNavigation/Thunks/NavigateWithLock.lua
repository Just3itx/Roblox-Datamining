-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T17:01:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceNavigationParent = script:FindFirstAncestor("AvatarExperienceNavigation").Parent

local ArgCheck = require(AvatarExperienceNavigationParent.ArgCheck)
local NavigationRodux = require(AvatarExperienceNavigationParent.NavigationRodux)
local ApplySetNavigationLocked = NavigationRodux.Actions.ApplySetNavigationLocked
local Selectors = NavigationRodux.Selectors
local SharedFlags = require(AvatarExperienceNavigationParent.SharedFlags)
local FFlagUseNavigationSelectors = SharedFlags.FFlagUseNavigationSelectors
local FFlagSignalsNavP2NavigationPrimitives = SharedFlags.FFlagSignalsNavP2NavigationPrimitives
local FFlagSignalsNavPendingLock = SharedFlags.FFlagSignalsNavPendingLock
local AppNavigationRegistry = if FFlagSignalsNavP2NavigationPrimitives then require(AvatarExperienceNavigationParent.RobloxAppNavigation).AppNavigationRegistry else nil

return function(callback)
    ArgCheck.isType(callback, "function", "navigationCallback")
    return function(arg1)
        if not FFlagSignalsNavP2NavigationPrimitives then
            local state = arg1:getState()

            if if FFlagUseNavigationSelectors then Selectors.selectNavigationLocked(state) else state.Navigation.lockNavigationActions then
                return
            end

            arg1:dispatch(ApplySetNavigationLocked(true))
            callback()
            return
        end

        if FFlagSignalsNavPendingLock then
            if AppNavigationRegistry.isNavigationLocked(false) then
                return
            end
        elseif AppNavigationRegistry.get().getIsNavigating(false) then
            return
        end
        callback()
    end
end

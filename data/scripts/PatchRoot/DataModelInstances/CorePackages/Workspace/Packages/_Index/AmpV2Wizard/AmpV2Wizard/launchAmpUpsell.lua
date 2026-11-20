-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T21:40:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent
local _Types = require(scriptParent.Types)
local startAmpUpsell = require(scriptParent.startAmpUpsell)

return function(arg1, arg2, bool1: boolean?)
    return function(tbl1)
        return startAmpUpsell(arg1, arg2, function(extraProps)
            local sharedFlags = require(scriptParentParent.SharedFlags)
            if not sharedFlags.FFlagEnableAmpV2Wizard then
                return false
            end
            local tbl2 = {
                name = require(scriptParentParent.RobloxAppEnums).AppPage.AmpV2Wizard,
                extraProps = extraProps
            }

            if sharedFlags.FFlagSignalsNavP3Dispatch or sharedFlags.FFlagSignalsNavP2NavigationPrimitives then
                local robloxAppNavigation = require(scriptParentParent.RobloxAppNavigation)
                local appNavigationRegistry = robloxAppNavigation.AppNavigationRegistry

                if not appNavigationRegistry.isRegistered() or not bool1 and appNavigationRegistry.get().getIsNavigating(false) then
                    return false
                end
                local navigationCommands = robloxAppNavigation.NavigationCommands
                navigationCommands.down(navigationCommands.fromLegacyPage(tbl2), bool1)
            else
                local navigation = tbl1:getState().Navigation
                if not navigation or navigation.lockNavigationActions and not bool1 then
                    return false
                end
                local navigationRodux = require(scriptParentParent.NavigationRodux)
                tbl1:dispatch(navigationRodux.Thunks.NavigateDown(tbl2, bool1))
            end
            return true
        end, false)
    end
end

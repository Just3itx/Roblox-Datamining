-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T17:01:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceNavigation = script:FindFirstAncestor("AvatarExperienceNavigation")
local AvatarExperienceNavigationParent = AvatarExperienceNavigation.Parent

local Cryo = require(AvatarExperienceNavigationParent.Cryo)
local AppPage = require(AvatarExperienceNavigationParent.RobloxAppEnums).AppPage
local AvatarScreenProperties = require(AvatarExperienceNavigation.AvatarRoute.AvatarScreenProperties)
local NavigateDown = require(AvatarExperienceNavigationParent.NavigationRodux).Thunks.NavigateDown
local FFlagSignalsNavP3Dispatch = require(AvatarExperienceNavigationParent.SharedFlags).FFlagSignalsNavP3Dispatch
local NavigationCommands = if FFlagSignalsNavP3Dispatch then require(AvatarExperienceNavigationParent.RobloxAppNavigation).NavigationCommands else nil

local function NavigateDownToAvatarScreen(routeName: string, detail: string?, arg1)
    local var1 = AvatarScreenProperties[routeName]
    local isTransparent = var1 and var1.isTransparent
    return function(arg2)
        local tbl1 = {
            name = isTransparent and AppPage.AvatarExperienceWrapperTransparent or AppPage.AvatarExperienceWrapper,
            detail = detail,
            extraProps = {
                routeName = routeName,
                params = Cryo.Dictionary.join(arg1 or {}, { detail = detail })
            }
        }

        if not FFlagSignalsNavP3Dispatch then
            return arg2:dispatch(NavigateDown(tbl1))
        end

        NavigationCommands.down(NavigationCommands.fromLegacyPage(tbl1))
    end
end

return NavigateDownToAvatarScreen

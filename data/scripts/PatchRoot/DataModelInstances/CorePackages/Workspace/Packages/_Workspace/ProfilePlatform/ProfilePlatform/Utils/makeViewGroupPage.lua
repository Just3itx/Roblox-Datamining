-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T06:11:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent

local AppPage = require(ProfilePlatformParent.RobloxAppEnums).AppPage
local _NavigationRodux = require(ProfilePlatformParent.NavigationRodux)
local Responsive = require(ProfilePlatformParent.Responsive)
local SocialLuaAnalytics = require(ProfilePlatformParent.SocialLuaAnalytics)
local UrlBuilder = require(ProfilePlatformParent.UrlBuilder).UrlBuilder

local TextKeys = require(ProfilePlatform.Common.TextKeys)

local FFlagEnableGroupOverviewPane = require(ProfilePlatformParent.SharedFlags).FFlagEnableGroupOverviewPane
local Sources = SocialLuaAnalytics.Analytics.Enums.Sources

local function makeViewGroupPage(groupId: string, onClose: ((...any) -> (...any))?)
    local bool1 = Responsive.GetInputModeStore(false).getPreferredInputType(false) == Responsive.Input.Directional

    if FFlagEnableGroupOverviewPane and not bool1 then
        return {
            name = AppPage.Groups,
            extraProps = {
                groupId = groupId,
                source = Sources.ProfilePlatform
            }
        }
    end

    return {
        name = AppPage.GenericWebPage,
        detail = UrlBuilder.user.group({ groupId = groupId }),
        extraProps = {
            titleKey = TextKeys.Community,
            onClose = onClose
        }
    }
end

return makeViewGroupPage

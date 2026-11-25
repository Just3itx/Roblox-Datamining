-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:21:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent

local React = require(ProfilePlatformParent.React)
local Localization = require(ProfilePlatformParent.Localization)
local Navigation = require(ProfilePlatformParent.Navigation)
local AppPage = require(ProfilePlatformParent.RobloxAppEnums).AppPage
local SocialLuaAnalytics = require(ProfilePlatformParent.SocialLuaAnalytics)

local Enums = require(ProfilePlatform.Common.Enums)
local _Types = require(ProfilePlatform.Common.Types)
local TextKeys = require(ProfilePlatform.Common.TextKeys)
local EventNames = require(ProfilePlatform.Analytics.EventNames)
local useProfileJsonComponent = require(ProfilePlatform.Hooks.useProfileJsonComponent)

local useNavigation = Navigation.useNavigation
local useLocalization = Localization.Hooks.useLocalization
local Contexts = SocialLuaAnalytics.Analytics.Enums.Contexts

local function useSchoolChip(arg1)
    local var1 = useNavigation()
    local school = useProfileJsonComponent(Enums.Components.UserProfileHeader).school

    local var2 = useLocalization({ classmates = TextKeys.Classmates })

    local text = React.useMemo(function()
        return if if school then school.isSameSchool else nil then var2.classmates else nil
    end, { school, var2 })

    local onActivated = React.useCallback(function()
        arg1.fireAnalyticsEvent(EventNames.SchoolButton)
        var1.navigate(AppPage.Schools, { extraProps = { source = Contexts.PlayerProfile } })
    end, { arg1, var1 })

    return React.useMemo(function(): {isDisabled: boolean, layoutOrder: number, onActivated: any, text: any}?
        return if text == nil then nil else {
            text = text,
            layoutOrder = 0,
            isDisabled = false,
            onActivated = onActivated
        }
    end, { text, onActivated })
end

return useSchoolChip

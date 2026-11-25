-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T04:51:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent

local Foundation = require(ProfilePlatformParent.Foundation)

local ButtonVariant = Foundation.Enums.ButtonVariant
local IconName = Foundation.Enums.IconName

local Enums = require(ProfilePlatform.Common.Enums)
local _Types = require(ProfilePlatform.Components.CTARow.Types)
local EventNames = require(ProfilePlatform.Analytics.EventNames)
local ProfileTypes = Enums.ProfileTypes

local FFlagProfilePlatformEnableEditAppearanceMenu = require(ProfilePlatform.Flags.FFlagProfilePlatformEnableEditAppearanceMenu)

local FFlagProfilePlatformEditBackgroundMenuItem = require(ProfilePlatform.Flags.FFlagProfilePlatformEditBackgroundMenuItem)
local FFlagProfilePlatformEnableEditLook = require(ProfilePlatform.Flags.FFlagProfilePlatformEnableEditLook)

local module = {
    [Enums.ProfileActions.EditAppearance] = FFlagProfilePlatformEnableEditAppearanceMenu and function(arg1)
        local tbl1 = {
            text = arg1.localized[Enums.ProfileActions.EditAppearance],
            variant = ButtonVariant.Emphasis,
            onActivated = 0
        }
        local onActivated = {}
        onActivated[ProfileTypes.User] = function()
            arg1.analytics.fireAnalyticsEvent(EventNames.CTAButtonEditAppearance, { buttonSurface = arg1.buttonSurface })
        end

        tbl1.onActivated = onActivated
        return tbl1
    end or nil
}

module[Enums.ProfileActions.EditAvatar] = function(arg1)
    local tbl1 = {
        text = arg1.localized[Enums.ProfileActions.EditAvatar],
        icon = if FFlagProfilePlatformEnableEditAppearanceMenu then IconName.Person else nil,
        onActivated = 0
    }
    local onActivated = {}
    onActivated[ProfileTypes.User] = function()
        arg1.analytics.fireAnalyticsEvent(
            if FFlagProfilePlatformEnableEditAppearanceMenu then EventNames.EditAppearanceMenuEditAvatar else EventNames.CTAButtonEditAvatar,
            {
                buttonSurface = arg1.buttonSurface
            }
        )
        arg1.navigateTo.editAvatar()
    end

    tbl1.onActivated = onActivated
    return tbl1
end

module[Enums.ProfileActions.EditLook] = FFlagProfilePlatformEnableEditLook and function(arg1)
    local tbl1 = {
        text = arg1.localized[Enums.ProfileActions.EditLook],
        icon = IconName.Person,
        onActivated = 0
    }
    local onActivated = {}
    onActivated[ProfileTypes.User] = function()
        arg1.analytics.fireAnalyticsEvent(EventNames.CTAButtonEditLook, { buttonSurface = arg1.buttonSurface })

        arg1.navigateTo.editAvatar()
    end

    tbl1.onActivated = onActivated
    return tbl1
end or nil

module[Enums.ProfileActions.EditEmotes] = FFlagProfilePlatformEnableEditAppearanceMenu and function(arg1)
    local tbl1 = {
        text = arg1.localized[Enums.ProfileActions.EditEmotes],
        icon = IconName.SquareFaceWavingHand,
        onActivated = 0
    }
    local onActivated = {}
    onActivated[ProfileTypes.User] = function()
        arg1.analytics.fireAnalyticsEvent(EventNames.EditAppearanceMenuEditEmote, { buttonSurface = arg1.buttonSurface })

        local editEmotes = arg1.navigateTo.editEmotes
        if editEmotes then
            editEmotes()
        end
    end

    tbl1.onActivated = onActivated
    return tbl1
end or nil

module[Enums.ProfileActions.SwitchAvatar] = FFlagProfilePlatformEnableEditAppearanceMenu and function(arg1)
    local tbl1 = {
        text = arg1.localized[Enums.ProfileActions.SwitchAvatar],
        icon = IconName.PersonStandingArrowReverse,
        onActivated = 0
    }
    local onActivated = {}
    onActivated[ProfileTypes.User] = function()
        arg1.analytics.fireAnalyticsEvent(EventNames.EditAppearanceMenuSwitchAvatar, { buttonSurface = arg1.buttonSurface })

        local switchAvatar = arg1.navigateTo.switchAvatar
        if switchAvatar then
            switchAvatar()
        end
    end

    tbl1.onActivated = onActivated
    return tbl1
end or nil

module[Enums.ProfileActions.EditBackground] = FFlagProfilePlatformEnableEditAppearanceMenu and FFlagProfilePlatformEditBackgroundMenuItem and function(arg1)
    local tbl1 = {
        text = arg1.localized[Enums.ProfileActions.EditBackground],
        icon = IconName.Image,
        onActivated = 0
    }
    local onActivated = {}
    onActivated[ProfileTypes.User] = function()
        arg1.analytics.fireAnalyticsEvent(EventNames.EditAppearanceMenuEditBackground, { buttonSurface = arg1.buttonSurface })

        local editBackground = arg1.navigateTo.editBackground
        if editBackground then
            editBackground()
        end
    end

    tbl1.onActivated = onActivated
    return tbl1
end or nil

return module

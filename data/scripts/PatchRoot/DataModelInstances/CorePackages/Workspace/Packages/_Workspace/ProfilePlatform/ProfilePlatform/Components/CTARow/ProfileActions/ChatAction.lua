-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T04:50:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent
local GuiService = game:GetService("GuiService")

local Foundation = require(ProfilePlatformParent.Foundation)
local SocialCommon = require(ProfilePlatformParent.SocialCommon)

local ButtonVariant = Foundation.Enums.ButtonVariant
local ChatEntryPointNames = SocialCommon.Enums.ChatEntryPointNames
local EnteredChatFromEntryPoint = require(ProfilePlatformParent.AppChat.EnteredChatFromEntryPoint)
local notificationTypeList = GuiService:GetNotificationTypeList()

local Enums = require(ProfilePlatform.Common.Enums)
local _Types = require(ProfilePlatform.Components.CTARow.Types)
local EventNames = require(ProfilePlatform.Analytics.EventNames)
local ProfileTypes = Enums.ProfileTypes

local module = {}
module[Enums.ProfileActions.Chat] = function(arg1)
    local tbl1 = {
        text = arg1.localized[Enums.ProfileActions.Chat],
        variant = ButtonVariant.Standard,
        onActivated = 0
    }
    local onActivated = {}
    onActivated[ProfileTypes.User] = function()
        if arg1.buttonSurface == Enums.ButtonSurface.ContextualMenu then
            arg1.analytics.fireAnalyticsEvent(EventNames.ContextualMenuButtonChat, { buttonSurface = arg1.buttonSurface })
        else
            arg1.analytics.fireAnalyticsEvent(EventNames.CTAButtonChat, { buttonSurface = arg1.buttonSurface })
        end

        arg1.dispatch(EnteredChatFromEntryPoint(ChatEntryPointNames.ProfilePeekView))
        GuiService:BroadcastNotification(arg1.profileId, notificationTypeList.LAUNCH_CONVERSATION)
    end

    tbl1.onActivated = onActivated
    return tbl1
end

return module

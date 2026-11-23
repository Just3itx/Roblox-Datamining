-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:31:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local SharedFlags = require(AppChatParent.SharedFlags)
local GetFFlagEnableAppChatInExperience = SharedFlags.GetFFlagEnableAppChatInExperience

local useAppPolicy = require(AppChat.Hooks.useAppPolicy)
local useIsChatEnabled = require(AppChat.Hooks.useIsChatEnabled)
local useIsInExperience = require(AppChat.Hooks.useIsInExperience)
local getFFlagHideNotificationIconForVR = require(AppChat.Flags.getFFlagHideNotificationIconForVR)
local FFlagAppChatRemoveNotifications = SharedFlags.FFlagAppChatRemoveNotifications

local useSelector = require(AppChatParent.RoactUtils).Hooks.RoactRodux.useSelector

local function useChatLandingVisibility()
    local showSearchRow = useIsInExperience()
    local var2 = useIsChatEnabled()

    local var3 = useAppPolicy(function(arg1)
        return arg1.getChatHeaderSearch()
    end)
    local var4 = useAppPolicy(function(arg1)
        return arg1.getChatHeaderCreateChatGroup()
    end)
    local var5 = useAppPolicy(function(arg1)
        return arg1.getChatHeaderNotifications() and (not getFFlagHideNotificationIconForVR() or arg1.getWebViewSupport())
    end)

    local notificationCount = useSelector(function(arg1)
        local notificationBadgeCounts = arg1.NotificationBadgeCounts
        return notificationBadgeCounts and notificationBadgeCounts.TopBarNotificationIcon or 0
    end)

    return {
        topBarShowSearch = var3 and not showSearchRow and var2,
        topBarShowCreateChatGroup = var4 and var2,
        topBarShowNotifications = not showSearchRow and var5 and not FFlagAppChatRemoveNotifications,
        topBarShowSnoozeNotifications = showSearchRow and GetFFlagEnableAppChatInExperience(),
        showSearchRow = showSearchRow,
        notificationCount = notificationCount
    }
end

return useChatLandingVisibility

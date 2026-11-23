-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:00:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local AppChatToastEventReceiver = require(AppChat.Components.EventReceivers.AppChatToastEventReceiver)

local Cryo = require(AppChatParent.Cryo)
local React = require(AppChatParent.React)
local SignalsReact = require(AppChatParent.SignalsReact)

local GetFFlagAppChatInExpToastSnoozeMenuDismissFix = require(AppChatParent.SharedFlags).GetFFlagAppChatInExpToastSnoozeMenuDismissFix
local FriendsSurfaceVisibility = require(AppChatParent.ExpChatShared).FriendsSurfaceVisibility

local tbl1 = { hideAllChatToasts = false, isAppChatVisible = false }

function AppChatToastManagerInExp(tbl2)
    local var1 = Cryo.Dictionary.join(tbl1, tbl2)

    local visibleFriendsConversationId = SignalsReact.useSignalState(FriendsSurfaceVisibility.getVisibleConversationId)

    local navigateToChat = React.useCallback(function(str1: string)
        var1.navigateToChat(str1)
    end, { var1.navigateToChat })

    return React.createElement(AppChatToastEventReceiver, {
        navigateToChat = navigateToChat,
        hideAllChatToasts = if GetFFlagAppChatInExpToastSnoozeMenuDismissFix() then nil else var1.hideAllChatToasts,
        isAppChatVisible = if GetFFlagAppChatInExpToastSnoozeMenuDismissFix() then var1.isAppChatVisible else nil,
        isInExperience = true,
        visibleFriendsConversationId = visibleFriendsConversationId
    })
end

return AppChatToastManagerInExp

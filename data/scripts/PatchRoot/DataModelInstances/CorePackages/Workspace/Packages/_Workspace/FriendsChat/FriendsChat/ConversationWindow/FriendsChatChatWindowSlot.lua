-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T13:01:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsChatParent = script:FindFirstAncestor("FriendsChat").Parent

local React = require(FriendsChatParent.React)

local FriendsChatMessageList = require(script.Parent.FriendsChatMessageList)
local _useConversationHeaderFadeLayout = require(script.Parent.useConversationHeaderFadeLayout)
local useConversationMessagePool = require(script.Parent.useConversationMessagePool)

local function FriendsChatChatWindowSlot(tbl1)
    local fadeLayout = tbl1.fadeLayout

    local scrollViewChildrenSignal = useConversationMessagePool({
        conversationId = tbl1.conversationId,
        shouldReadMessages = tbl1.hasConversationId,
        chatWindowSettings = tbl1.hostChatWindowSettings,
        textTransparency = tbl1.textTransparency,
        isSpatialUIEnabled = tbl1.isSpatialUIEnabled
    })

    return React.createElement(FriendsChatMessageList, {
        layoutOrder = tbl1.layoutOrder,
        conversationId = tbl1.conversationId,
        scrollViewChildrenSignal = scrollViewChildrenSignal,
        contentTopPadding = fadeLayout.contentTopPadding,
        messageFadeSequence = fadeLayout.messageFadeSequence,
        onCanvasPositionChanged = fadeLayout.onMessageCanvasPositionChanged,
        onViewportAbsoluteSizeChanged = fadeLayout.onMessageViewportAbsoluteSizeChanged,
        chatWindowSettings = tbl1.chatWindowSettings,
        transparencyValue = tbl1.transparencyValue,
        textTransparency = tbl1.textTransparency,
        isSpatialUIEnabled = tbl1.isSpatialUIEnabled,
        isChannelBarVisible = tbl1.isChannelBarVisible,
        scrollToTopOnReset = tbl1.shouldOpenToOsaSystemMessage,
        onHovered = tbl1.onHovered,
        onUnhovered = tbl1.onUnhovered,
        onAbsoluteSizeChanged = tbl1.onAbsoluteSizeChanged,
        onAbsolutePositionChanged = tbl1.onAbsolutePositionChanged
    })
end

return FriendsChatChatWindowSlot

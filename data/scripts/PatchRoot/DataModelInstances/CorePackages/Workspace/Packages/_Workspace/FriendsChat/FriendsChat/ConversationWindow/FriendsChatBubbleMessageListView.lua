-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T13:01:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsChatParent = script:FindFirstAncestor("FriendsChat").Parent

local React = require(FriendsChatParent.React)
local MessageList = require(FriendsChatParent.ChatUIPrimitives.MessageList)

local function FriendsChatBubbleMessageListView(tbl1)
    local element = React.createElement(MessageList, tbl1.messageListProps)

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        Name = "FriendsChatWindowSlot",
        LayoutOrder = tbl1.layoutOrder,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Size = UDim2.fromScale(1, 0),
        ZIndex = 1,
        [React.Change.AbsoluteSize] = tbl1.onSlotAbsoluteSizeChanged,
        [React.Change.AbsolutePosition] = tbl1.onSlotAbsolutePositionChanged,
        [React.Event.MouseEnter] = tbl1.onHovered,
        [React.Event.MouseLeave] = tbl1.onUnhovered
    }

    local tbl3 = {
        flex = React.createElement("UIFlexItem", { FlexMode = Enum.UIFlexMode.Fill }),
        padding = React.createElement("UIPadding", {
            PaddingTop = tbl1.topInset:map(function(offset: number): UDim
                return UDim.new(0, offset)
            end)
        }),
        messageMask = 0
    }

    local createElement2 = React.createElement
    local str2 = "CanvasGroup"
    local tbl4 = {
        Name = "FriendsChatMessageMask",
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        GroupTransparency = tbl1.textTransparency,
        Visible = tbl1.messagesVisible,
        Size = UDim2.fromScale(1, 1),
        [React.Change.AbsoluteSize] = tbl1.onMaskAbsoluteSizeChanged,
        ref = tbl1.maskRef
    }
    local tbl5 = {
        fade = React.createElement("UIGradient", { Rotation = 90, Transparency = tbl1.topFade }),
        messageList = if tbl1.isReady then React.createElement(React.Fragment, nil, { [tbl1.conversationId] = element }) else nil
    }
    tbl3.messageMask = createElement2(str2, tbl4, tbl5)
    return createElement(str1, tbl2, tbl3)
end

return FriendsChatBubbleMessageListView

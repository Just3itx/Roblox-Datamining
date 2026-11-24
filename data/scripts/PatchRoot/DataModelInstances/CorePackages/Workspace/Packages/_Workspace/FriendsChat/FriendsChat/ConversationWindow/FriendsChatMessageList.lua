-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T13:01:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsChatParent = script:FindFirstAncestor("FriendsChat").Parent

local React = require(FriendsChatParent.React)
local _Signals = require(FriendsChatParent.Signals)
local ExpChatShared = require(FriendsChatParent.ExpChatShared)

local useChatWindow = require(script.Parent.Parent.Bridge.useChatWindow)

local var1 = ExpChatShared.Logger:new(script.Name)

local function FriendsChatMessageList(tbl1)
    local var2 = useChatWindow()

    local resetTargetChannel = React.useCallback(function()
        var1:warning("resetTargetChannel called on FriendsChatMessageList; not supported")
    end, {})
    local activateWhisperMode = React.useCallback(function()
        var1:warning("activateWhisperMode called on FriendsChatMessageList; not supported")
    end, {})

    local ref = React.useRef(nil)
    local onViewportAbsoluteSizeChanged = tbl1.onViewportAbsoluteSizeChanged
    React.useEffect(function()
        local current = ref.current
        if current and onViewportAbsoluteSizeChanged then
            onViewportAbsoluteSizeChanged(current)
        end
    end, { onViewportAbsoluteSizeChanged })

    local createElement = React.createElement
    local tbl2 = {
        Name = "FriendsChatWindowSlot",
        LayoutOrder = tbl1.layoutOrder,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Size = UDim2.fromScale(1, 0),
        ZIndex = 1
    }
    local tbl3 = {
        flex = React.createElement("UIFlexItem", { FlexMode = Enum.UIFlexMode.Fill }),
        messageMask = React.createElement("CanvasGroup", {
            Name = "FriendsChatMessageMask",
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            ClipsDescendants = true,
            GroupTransparency = 0,
            Size = UDim2.fromScale(1, 1),
            [React.Change.AbsoluteSize] = tbl1.onViewportAbsoluteSizeChanged,
            ref = ref
        }, {
            fade = React.createElement("UIGradient", { Rotation = 90, Transparency = tbl1.messageFadeSequence }),
            window = React.createElement(var2, {
                size = UDim2.fromScale(1, 1),
                isChannelBarVisible = tbl1.isChannelBarVisible,
                scrollResetKey = "FriendsChat:" .. tbl1.conversationId,
                scrollToTopOnReset = tbl1.scrollToTopOnReset,
                onCanvasPositionChanged = tbl1.onCanvasPositionChanged,
                contentTopPadding = tbl1.contentTopPadding,
                messageComponentsSignal = tbl1.scrollViewChildrenSignal,
                chatWindowSettings = tbl1.chatWindowSettings,
                suppressBackground = true,
                transparencyValue = tbl1.transparencyValue,
                textTransparency = tbl1.textTransparency,
                isSpatialUIEnabled = tbl1.isSpatialUIEnabled,
                onHovered = tbl1.onHovered,
                onUnhovered = tbl1.onUnhovered,
                onAbsoluteSizeChanged = tbl1.onAbsoluteSizeChanged,
                onAbsolutePositionChanged = tbl1.onAbsolutePositionChanged,
                disableLineReporting = true,
                resetTargetChannel = resetTargetChannel,
                activateWhisperMode = activateWhisperMode
            })
        })
    }
    return createElement("Frame", tbl2, tbl3)
end

return FriendsChatMessageList

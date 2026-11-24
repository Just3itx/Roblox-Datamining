-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T08:01:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent
local Roact = require(ExpChatParent.Roact)
local Dictionary = require(ExpChatParent.llama).Dictionary
local ExpChatShared = require(ExpChatParent.ExpChatShared)
local FFlagExpChatEnableV2ChatWindow = require(ExpChat.Flags.FFlagExpChatEnableV2ChatWindow)
local GetFFlagTextChatEnableUniverseChatTabs = ExpChatShared.Flags.GetFFlagTextChatEnableUniverseChatTabs

local BottomLockedScrollViewV3 = require(ExpChat.ChatWindow.UI.BottomLockedScrollViewV3)

local var1 = Roact.PureComponent:extend("ScrollingView")
var1.defaultProps = {}

function var1.render(arg1)
    local tbl1

    if FFlagExpChatEnableV2ChatWindow then
        tbl1 = {
            showTranslationButton = arg1.props.showTranslationButton,
            chatWindowSettings = arg1.props.chatWindowSettings,
            textTransparency = arg1.props.textTransparency,
            onTextMessageLabelButtonActivated = arg1.props.onTextMessageLabelButtonActivated,
            isSpatialUIEnabled = arg1.props.isSpatialUIEnabled,
            chatWindowTransparencyBindable = arg1.props.chatWindowTransparencyBindable,
            visible = arg1.props.visible,
            selectedChannelName = if GetFFlagTextChatEnableUniverseChatTabs() then arg1.props.selectedChannelName else nil,
            historicalMessageCountSignal = arg1.props.historicalMessageCountSignal
        }
    else
        tbl1 = {}
    end

    tbl1.messageComponentsSignal = arg1.props.messageComponentsSignal
    return Roact.createElement("ImageButton", {
        BackgroundTransparency = 1,
        Selectable = false,
        Size = arg1.props.size
    }, {
        bottomLockedScrollView = Roact.createElement(
            BottomLockedScrollViewV3,
            Dictionary.join({
                Size = UDim2.fromScale(1, 1),
                isChannelBarVisible = arg1.props.isChannelBarVisible,
                scrollResetKey = arg1.props.scrollResetKey,
                scrollToTopOnReset = arg1.props.scrollToTopOnReset,
                onCanvasPositionChanged = arg1.props.onCanvasPositionChanged,
                contentTopPadding = arg1.props.contentTopPadding
            }, tbl1)
        )
    })
end

return var1

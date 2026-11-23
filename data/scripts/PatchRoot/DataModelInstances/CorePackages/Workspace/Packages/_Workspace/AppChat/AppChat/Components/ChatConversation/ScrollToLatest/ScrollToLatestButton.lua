-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:40:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local Foundation = require(AppChatParent.Foundation)
local React = require(AppChatParent.React)
local useLocalization = require(AppChatParent.Localization).Hooks.useLocalization

local EventNames = require(AppChat.Analytics.EventNames)
local useAnalytics = require(AppChat.Analytics.useAnalytics)

local ButtonVariant = Foundation.Enums.ButtonVariant
local IconName = Foundation.Enums.IconName
local InputSize = Foundation.Enums.InputSize
local PopoverAlign = Foundation.Enums.PopoverAlign
local PopoverSide = Foundation.Enums.PopoverSide

local function ScrollToLatestButton(tbl1)
    local var1 = useAnalytics()
    local var2 = useLocalization({ jumpToLatestMessages = "Feature.Chat.Action.JumpToLatestMessages" })

    local conversationId = tbl1.conversationId
    local messageListVersion = tbl1.messageListVersion
    local onActivated = tbl1.onActivated
    local var3 = React.useCallback(function()
        var1.fireAnalyticsEvent(
            EventNames.ConversationScrollToLatestBtnClicked,
            { conversationId = conversationId, messageListVersion = messageListVersion }
        )
        onActivated()
    end, {
        var1,
        conversationId,
        messageListVersion,
        onActivated
    })
    return React.createElement(Foundation.View, {
        tag = "position-bottom-right anchor-bottom-right auto-xy padding-medium",
        ZIndex = 2,
        testId = "chat-conversation-scrollToLatest"
    }, {
        Tooltip = React.createElement(
            Foundation.Tooltip,
            {
                title = var2.jumpToLatestMessages,
                side = PopoverSide.Left,
                align = PopoverAlign.Center
            },
            {
                Button = React.createElement(Foundation.IconButton, {
                    icon = IconName.ChevronLargeDown,
                    size = InputSize.Medium,
                    variant = ButtonVariant.Standard,
                    isCircular = true,
                    onActivated = var3,
                    testId = "chat-conversation-scrollToLatest-button"
                })
            }
        )
    })
end

return ScrollToLatestButton

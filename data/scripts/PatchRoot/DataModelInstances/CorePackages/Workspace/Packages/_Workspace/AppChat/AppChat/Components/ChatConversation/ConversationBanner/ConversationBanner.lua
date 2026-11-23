-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:20:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local Cryo = require(AppChatParent.Cryo)
local Foundation = require(AppChatParent.Foundation)
local React = require(AppChatParent.React)
local _types = require(AppChat.types)
local useTokens = Foundation.Hooks.useTokens

local useChatPagePadding = require(AppChat.Contexts.ChatPagePadding.useChatPagePadding)

local tbl1 = {
    actionText = "PLACEHOLDER Action",
    bodyText = "PLACEHOLDER Body",
    onActivated = function() end,
    onDismissed = function() end
}

return React.memo(function(tbl2) -- name: ConversationBanner
    local var1 = Cryo.Dictionary.union(tbl1, tbl2)
    local medium = useTokens().Padding.Medium
    local var2 = useChatPagePadding()

    return React.createElement(Foundation.View, {
        padding = {
            left = UDim.new(0, var2.left),
            right = UDim.new(0, var2.right),
            top = UDim.new(0, medium),
            bottom = UDim.new(0, medium)
        },
        tag = "row gap-medium align-y-center size-full-0 auto-y bg-shift-200",
        LayoutOrder = var1.layoutOrder
    }, {
        BodyText = React.createElement(Foundation.Text, {
            tag = "text-title-medium text-align-x-left text-truncate-end content-emphasis auto-y fill",
            LayoutOrder = 1,
            Text = var1.bodyText
        }),
        ActionContainer = React.createElement(
            Foundation.View,
            { LayoutOrder = 2, tag = "row gap-small align-y-center auto-xy" },
            {
                ActionButton = React.createElement(
                    Foundation.Button,
                    {
                        text = var1.actionText,
                        onActivated = var1.onActivated,
                        size = Foundation.Enums.InputSize.Small,
                        LayoutOrder = 1
                    }
                ),
                CloseButton = React.createElement(
                    Foundation.View,
                    {
                        onActivated = var1.onDismissed,
                        LayoutOrder = 2,
                        tag = "auto-xy x-default-transparent radius-small padding-xsmall"
                    },
                    {
                        Icon = React.createElement(Foundation.Icon, { size = Foundation.Enums.IconSize.Large, name = Foundation.Enums.IconName.X })
                    }
                )
            }
        )
    })
end)

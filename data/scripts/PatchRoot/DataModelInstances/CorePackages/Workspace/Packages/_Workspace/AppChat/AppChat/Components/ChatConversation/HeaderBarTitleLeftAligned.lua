-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:21:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local Foundation = require(AppChatParent.Foundation)
local ConversationTitleWithFacePile = require(AppChat.Components.ChatConversation.ConversationTitleWithFacePile)
local FFlagAppChatFoundationHeaderBar = require(AppChat.Flags.FFlagAppChatFoundationHeaderBar)
local useTokens = Foundation.Hooks.useTokens

local React = require(AppChatParent.React)

local function HeaderBarTitleLeftAligned(tbl1)
    local var1 = useTokens()
    local createElement = React.createElement
    local view = Foundation.View
    local tbl2 = {
        Size = UDim2.new(1, 0, 1, 0),
        layout = {
            FillDirection = Enum.FillDirection.Horizontal,
            Padding = UDim.new(0, var1.Gap.Medium),
            SortOrder = Enum.SortOrder.LayoutOrder,
            VerticalAlignment = Enum.VerticalAlignment.Center
        }
    }
    local tbl3 = {
        LeftFrame = if tbl1.renderLeft then React.createElement(
            Foundation.View,
            {
                AutomaticSize = Enum.AutomaticSize.XY,
                LayoutOrder = 1,
                ItemLineAlignment = Enum.ItemLineAlignment.Center
            },
            React.createElement(tbl1.renderLeft)
        ) else nil,
        CenterFrame = React.createElement(Foundation.View, {
            flexItem = {
                FlexMode = Enum.UIFlexMode.Fill
            },
            Size = if FFlagAppChatFoundationHeaderBar then UDim2.new(1, 0, 0, var1.Size.Size_1000) else UDim2.new(1, 0, 1, 0),
            LayoutOrder = 2
        }, {
            ConversationTitle = React.createElement(
                ConversationTitleWithFacePile,
                {
                    titleText = tbl1.titleText,
                    conversationId = tbl1.conversationId,
                    navigateToChatDetails = tbl1.navigateToChatDetails
                }
            )
        }),
        RightFrame = 0
    }
    local element

    if tbl1.renderRight then
        element = React.createElement(Foundation.View, {
            tag = if tbl1.ignoreRightMargin then nil else "padding-right-small",
            AutomaticSize = Enum.AutomaticSize.XY,
            ItemLineAlignment = Enum.ItemLineAlignment.Center,
            LayoutOrder = 3
        }, React.createElement(tbl1.renderRight))
    else
        element = nil
    end

    tbl3.RightFrame = element
    return createElement(view, tbl2, tbl3)
end

return HeaderBarTitleLeftAligned

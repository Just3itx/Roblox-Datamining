-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:11:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local Foundation = require(AppChatParent.Foundation)
local React = require(AppChatParent.React)

local useChatPagePadding = require(AppChat.Contexts.ChatPagePadding.useChatPagePadding)

local FFlagAppChatExtendConversationListRowDividers = require(AppChat.Flags.FFlagAppChatExtendConversationListRowDividers)
local FFlagAppChatRemoveConversationListDivider = require(AppChat.Flags.FFlagAppChatRemoveConversationListDivider)

local View = Foundation.View
local Skeleton = Foundation.Skeleton
local Radius = Foundation.Enums.Radius
local useTokens = Foundation.Hooks.useTokens

local uDim2 = UDim2.fromOffset(94, 12)
local uDim2_2 = UDim2.fromOffset(169, 12)

local function SearchLoading(tbl1)
    local var1 = useChatPagePadding()
    local var2 = useTokens()

    local tbl2 = ({})
    for layoutOrder = 1, 3 do
        local str1 = `PlaceholderRow{layoutOrder}`
        local createElement = React.createElement
        local var3 = View
        local tbl3 = {
            tag = "row align-y-center gap-small",
            Size = UDim2.new(1, 0, 0, tbl1.entryHeight),
            LayoutOrder = layoutOrder,
            padding = {
                left = UDim.new(0, var1.left),
                right = if FFlagAppChatExtendConversationListRowDividers then nil else UDim.new(0, var1.right)
            }
        }
        local tbl4 = {
            Avatar = React.createElement(
                Skeleton,
                {
                    Size = UDim2.fromOffset(var2.Size.Size_1000, var2.Size.Size_1000),
                    radius = Radius.Circle,
                    LayoutOrder = 1
                }
            ),
            Body = 0
        }

        local createElement2 = React.createElement
        local var4 = View
        local tbl5 = { tag = "col fill size-0-full", LayoutOrder = 2 }

        local tbl6 = { Lines = 0, Divider = 0 }
        local createElement3 = React.createElement
        local var5 = View
        local tbl7 = {
            tag = "col align-y-center fill gap-small size-full-0",
            LayoutOrder = 1,
            padding = if FFlagAppChatExtendConversationListRowDividers then {
                right = UDim.new(0, var1.right)
            } else nil
        }
        tbl6.Lines = createElement3(var5, tbl7, {
            Title = React.createElement(Skeleton, { Size = uDim2, LayoutOrder = 1 }),
            Subtitle = React.createElement(Skeleton, { Size = uDim2_2, LayoutOrder = 2 })
        })
        local element = if layoutOrder < 3 and not FFlagAppChatRemoveConversationListDivider then React.createElement(
            View,
            { tag = "size-full-0 auto-y", LayoutOrder = 2 },
            {
                Line = React.createElement(Foundation.Divider)
            }
        ) else nil
        tbl6.Divider = element
        tbl4.Body = createElement2(var4, tbl5, tbl6)
        tbl2[str1] = createElement(var3, tbl3, tbl4)
    end

    return React.createElement(
        View,
        {
            tag = "col size-full",
            padding = {
                top = UDim.new(0, tbl1.topPadding or 0)
            }
        },
        {
            ChatLoadingFrame = React.createElement(View, { tag = "col size-full-0 auto-y" }, tbl2)
        }
    )
end

return SearchLoading

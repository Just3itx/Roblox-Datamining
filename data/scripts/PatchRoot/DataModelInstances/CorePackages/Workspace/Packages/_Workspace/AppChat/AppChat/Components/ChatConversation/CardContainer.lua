-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:11:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local Foundation = require(AppChatParent.Foundation)
local React = require(AppChatParent.React)
local SocialCards = require(AppChatParent.SocialCards)
local useLocalUserId = require(AppChatParent.RobloxAppHooks).useLocalUserId
local useChatPagePadding = require(AppChat.Contexts.ChatPagePadding.useChatPagePadding)
local useChatPlacementContext = require(AppChat.Contexts.ChatPlacementContext).useChatPlacementContext

local Cards = SocialCards.Cards

local UserTile = require(AppChatParent.UserTile).UserTile
local LayoutMode = require(AppChatParent.UserTile).LayoutMode
local UserPresence = require(AppChatParent.Foundation).Enums.UserPresence

local useTokens = Foundation.Hooks.useTokens

local function CardContainer(tbl1)
    local var1 = useLocalUserId()
    local bool1 = tostring(var1) == tbl1.senderTargetId
    local var2 = useTokens()
    local var3 = useChatPagePadding()
    local var4 = useChatPlacementContext()

    local var5 = React.useMemo(function(): Vector2
        return Vector2.new(var2.Size.Size_700, var2.Size.Size_700)
    end, { var2 })

    local size200 = var2.Size.Size_200
    local horizontalAlignment = if tbl1.senderTargetId then if bool1 then Enum.HorizontalAlignment.Right else Enum.HorizontalAlignment.Left else Enum.HorizontalAlignment.Center
    local createElement = React.createElement
    local view = Foundation.View
    local tbl2 = {
        AutomaticSize = Enum.AutomaticSize.Y,
        Size = UDim2.fromScale(1, 0),
        testId = tbl1.testId,
        layout = {
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalAlignment = horizontalAlignment,
            Padding = UDim.new(0, size200),
            SortOrder = Enum.SortOrder.LayoutOrder,
            VerticalAlignment = Enum.VerticalAlignment.Bottom
        },
        padding = {
            left = UDim.new(0, var3.left),
            right = UDim.new(0, var3.right),
            top = UDim.new(0, var2.Padding.XSmall)
        }
    }
    local tbl3 = { Avatar = 0, Cards = 0 }
    local element

    if tbl1.senderTargetId and tbl1.senderTargetId ~= var1 then
        element = React.createElement(
            Foundation.View,
            {
                Size = UDim2.new(0, var5.X, 0, var5.Y),
                LayoutOrder = if bool1 then 2 else 1
            },
            { React.createElement(
                    UserTile,
                    {
                        userId = tbl1.senderTargetId,
                        layoutMode = LayoutMode.compact,
                        userPresenceType = UserPresence.None
                    }
                ) }
        )
    else
        element = nil
    end

    tbl3.Avatar = element
    local element2

    if tbl1.cards then
        element2 = React.createElement(
            Foundation.View,
            {
                AutomaticSize = Enum.AutomaticSize.Y,
                Size = UDim2.new(1, if tbl1.senderTargetId then -(var5.X + size200) else 0, 0, 0),
                LayoutOrder = if bool1 then 1 else 2
            },
            React.createElement(Cards, {
                analyticsInfo = {
                    moduleLocation = var4.chatPlacement
                },
                anchorPoint = if bool1 then Vector2.new(1, 0) else Vector2.new(0, 0),
                position = if bool1 then UDim2.fromScale(1, 0) else UDim2.fromScale(0, 0),
                cards = tbl1.cards,
                conversationId = tbl1.conversationId
            })
        )
    else
        element2 = nil
    end

    tbl3.Cards = element2
    return createElement(view, tbl2, tbl3)
end

return CardContainer

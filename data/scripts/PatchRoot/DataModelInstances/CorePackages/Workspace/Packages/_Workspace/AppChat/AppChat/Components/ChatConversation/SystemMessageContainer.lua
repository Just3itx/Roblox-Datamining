-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:50:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local _SocialCards = require(AppChatParent.SocialCards)
local Foundation = require(AppChatParent.Foundation)
local React = require(AppChatParent.React)
local memo = React.memo
local Cryo = require(AppChatParent.Cryo)
local useStyle = require(AppChatParent.UIBlox).Core.Style.useStyle

local getFFlagDebugAppChat = require(AppChat.Flags.getFFlagDebugAppChat)

local CardContainer = require(script.Parent.CardContainer)
local SystemMessage = require(script.Parent.SystemMessage)

local GetFFlagEnableSocialCards = require(AppChatParent.SharedFlags).GetFFlagEnableSocialCards
local FFlagDebugAppChatEnableDomLocators = require(AppChat.Flags.FFlagDebugAppChatEnableDomLocators)
local FFlagAppChatDomLocatorFoundationMigration = require(AppChat.Flags.FFlagAppChatDomLocatorFoundationMigration)
local DomLocators = require(AppChat.Utils.DomLocators)

local tbl1 = { cards = nil, text = "", parentWidth = 0, showDateTime = false, senderTargetId = nil }

local function getCardComponentTypes(cards)
    local cardComponentTypes = {}
    if not cards then
        return cardComponentTypes
    end

    for _, card in cards do
        local components = card.components
        if not components then
            continue
        end

        for _, component in components do
            if component.type then
                table.insert(cardComponentTypes, component.type)
            end
        end
    end

    return cardComponentTypes
end

function SystemMessageContainer(tbl2)
    local var1 = Cryo.Dictionary.join(tbl1, tbl2)
    local var2 = useStyle()

    local var3, var4 = React.useState(false)
    local var5 = React.useCallback(function()
        if getFFlagDebugAppChat() then
            var4(function(arg1): boolean
                return not arg1
            end)
        end
    end, { var4 })

    if GetFFlagEnableSocialCards() and var1.cards then
        local var6 = nil
        if FFlagDebugAppChatEnableDomLocators then
            local cardComponentTypes = getCardComponentTypes(var1.cards)
            if #cardComponentTypes > 0 then
                var6 = DomLocators.chatConversationSystemMessageCard(cardComponentTypes)
            end
        end

        return React.createElement(
            CardContainer,
            {
                cards = var1.cards,
                senderTargetId = var1.senderTargetId,
                conversationId = var1.conversationId,
                testId = var6
            }
        )
    end

    if FFlagAppChatDomLocatorFoundationMigration then
        local createElement = React.createElement
        local view = Foundation.View
        local tbl3 = { tag = "col size-full-0 auto-y align-x-center", onActivated = 0, testId = 0 }

        if not getFFlagDebugAppChat() then
            var5 = nil
        end

        tbl3.onActivated = var5
        tbl3.testId = if FFlagDebugAppChatEnableDomLocators then DomLocators.chatConversationSystemMessage(var1.text) else nil
        return createElement(view, tbl3, {
            DateTime = var1.showDateTime
                and React.createElement(SystemMessage, { LayoutOrder = 1, Text = var1.sent:GetLongRelativeTime(), maxWidth = 1000 }),
            SystemMessage = React.createElement(SystemMessage, { LayoutOrder = 2, Text = var1.text, maxWidth = var1.parentWidth * 0.75 }),
            Notice = var3
                and React.createElement(Foundation.Text, { tag = "auto-xy text-body-small", LayoutOrder = 3, Text = var1.messageId }),
            debug = var1.debugElement or nil
        })
    end

    local createElement = React.createElement
    local str1 = if getFFlagDebugAppChat() then "TextButton" else "Frame"
    local tbl3 = {
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        AutomaticSize = Enum.AutomaticSize.Y,
        Size = UDim2.new(1, 0, 0, 0),
        Text = if getFFlagDebugAppChat() then "" else nil
    }
    local activated = React.Event.Activated

    if not getFFlagDebugAppChat() then
        var5 = nil
    end

    tbl3[activated] = var5
    return createElement(str1, tbl3, {
        Layout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder
        }),
        DateTime = var1.showDateTime
            and React.createElement(SystemMessage, { LayoutOrder = 1, Text = var1.sent:GetLongRelativeTime(), maxWidth = 1000 }),
        SystemMessage = React.createElement(SystemMessage, { LayoutOrder = 2, Text = var1.text, maxWidth = var1.parentWidth * 0.75 }),
        Notice = var3
            and React.createElement("TextLabel", {
                BackgroundTransparency = 1,
                AutomaticSize = Enum.AutomaticSize.XY,
                LayoutOrder = 3,
                Text = var1.messageId,
                TextColor3 = var2.Theme.UIDefault.Color,
                TextTransparency = var2.Theme.UIDefault.Transparency,
                TextXAlignment = Enum.TextXAlignment.Center
            }),
        debug = var1.debugElement or nil
    })
end

return memo(SystemMessageContainer)

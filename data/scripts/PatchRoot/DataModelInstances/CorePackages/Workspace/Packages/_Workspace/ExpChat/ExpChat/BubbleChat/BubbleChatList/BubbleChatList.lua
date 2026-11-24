-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T07:31:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")

local ExpChatParent = ExpChat.Parent
local Roact = require(ExpChatParent.Roact)
local List = require(ExpChatParent.llama).List
local ExpChatShared = require(ExpChatParent.ExpChatShared)
local ChatBubble = require(ExpChat.BubbleChat.ChatBubble)
local BorderlessBubbleChat = require(ExpChat.BubbleChat.BorderlessBubbleChat)
local isBorderlessBubbleChatMessage = require(ExpChat.BubbleChat.Helpers.isBorderlessBubbleChatMessage)
local getBubbleChatDisplayText = require(ExpChat.BubbleChat.Helpers.getBubbleChatDisplayText)
local getBubbleChatStartTimeMillis = require(ExpChat.BubbleChat.Helpers.getBubbleChatStartTimeMillis)

local applyBubbleChatMessagePropertiesText = require(ExpChat.BubbleChat.Helpers.applyBubbleChatMessagePropertiesText)

local GlobalFlags = require(ExpChat.GlobalFlags)

local var1 = Roact.PureComponent:extend("BubbleChatList")

local getFFlagChatTranslationUIEnabledBubbleChat = require(ExpChat.Flags.getFFlagChatTranslationUIEnabledBubbleChat)
local getFFlagExpChatUseUpdatedMessageRendered = require(ExpChat.Flags.getFFlagExpChatUseUpdatedMessageRendered)
local FFlagExpChatPresetChatEnabled = ExpChatShared.Flags.FFlagExpChatPresetChatEnabled
local isBorderlessBubbleChatEnabled = require(ExpChat.isBorderlessBubbleChatEnabled)

function var1.getDerivedStateFromProps(arg1, arg2)
    local bubbles = {}
    local var2 = if isBorderlessBubbleChatEnabled() then arg1.messages[#arg1.messages] else nil

    if arg2.bubbles then
        for _, value in ipairs(arg2.bubbles) do
            if List.findWhere(arg1.messages, function(arg3, _): boolean
                return arg3.messageId == value.messageId
            end) then
                continue
            end

            local var3 = isBorderlessBubbleChatEnabled()

            if var3 then
                if var2 == nil then
                    var3 = false
                else
                    var3 = value.isBorderless or isBorderlessBubbleChatMessage(var2)
                end
            end

            if var3 then
                continue
            end

            table.insert(bubbles, {
                messageId = value.messageId,
                fadingOut = true,
                isBorderless = if isBorderlessBubbleChatEnabled() then value.isBorderless else nil,
                borderlessText = if isBorderlessBubbleChatEnabled() and value.isBorderless then value.borderlessText else nil,
                borderlessReceivedAtMillis = if isBorderlessBubbleChatEnabled() and value.isBorderless then value.borderlessReceivedAtMillis else nil
            })
        end
    end

    for _, value in ipairs(arg1.messages) do
        local timestamp = tonumber(tostring(value.timestamp):sub(-9))
        local isBorderless = if isBorderlessBubbleChatEnabled() then isBorderlessBubbleChatMessage(value) else nil
        table.insert(bubbles, {
            messageId = value.messageId,
            fadingOut = false,
            text = value.text,
            translation = if getFFlagChatTranslationUIEnabledBubbleChat() then value.translation else nil,
            useTranslation = if getFFlagChatTranslationUIEnabledBubbleChat() then value.useTranslation else nil,
            timestamp = timestamp or value.timestamp,
            bubbleChatMessageProperties = value.bubbleChatMessageProperties,
            presetId = if FFlagExpChatPresetChatEnabled then value.presetId else nil,
            textChatMessageInstance = if getFFlagExpChatUseUpdatedMessageRendered() then value.textChatMessageInstance else nil,
            isBorderless = isBorderless,
            borderlessText = if isBorderless then getBubbleChatDisplayText(value) else nil,
            borderlessReceivedAtMillis = if isBorderless then getBubbleChatStartTimeMillis(value) else nil
        })
    end

    return { bubbles = bubbles }
end

function var1.init(arg1, arg2)
    arg1.state = {}

    if (not arg2.messages or #arg2.messages == 0) and arg2.onLastBubbleFadeOut then
        arg2.onLastBubbleFadeOut()
    end

    function arg1.onBubbleFadeOut(messageId)
        local bubbles = List.filter(arg1.state.bubbles, function(arg3): boolean
            return arg3.messageId ~= messageId
        end)
        if #bubbles == 0 and arg1.props.onLastBubbleFadeOut then
            arg1.props.onLastBubbleFadeOut()
            return
        end

        arg1:setState({ bubbles = bubbles })
    end
end

function var1.render(arg1)
    local tbl1 = {}
    local chatSettings = arg1.props.chatSettings

    tbl1.Layout = Roact.createElement("UIListLayout", {
        SortOrder = Enum.SortOrder.LayoutOrder,
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        VerticalAlignment = Enum.VerticalAlignment.Bottom,
        Padding = UDim.new(0, chatSettings.BubblesSpacing)
    })

    tbl1.CaretPadding = arg1.props.chatSettings.TailVisible
        and (not GlobalFlags.AvatarChatEnabled or arg1.props.showCaret)
        and Roact.createElement("UIPadding", { PaddingBottom = UDim.new(0, 8) })

    for i, value in ipairs(arg1.state.bubbles) do
        local isMostRecent = i == #arg1.state.bubbles
        local renderFirstInsert = if isMostRecent then arg1.props.renderFirstInsert or nil else nil
        local insertSize = arg1.props.insertSize

        local text = value.text
        local translation = value.translation
        if isBorderlessBubbleChatEnabled() then
            text, translation = applyBubbleChatMessagePropertiesText(text, translation, value.bubbleChatMessageProperties)
        elseif value.bubbleChatMessageProperties then
            local bubbleChatMessageProperties = value.bubbleChatMessageProperties
            if bubbleChatMessageProperties:IsA("TextChatMessageProperties") then
                if bubbleChatMessageProperties.Text ~= "" then
                    text = bubbleChatMessageProperties.Text
                end

                if bubbleChatMessageProperties.Translation ~= "" then
                    translation = bubbleChatMessageProperties.Translation
                end
            end
        end

        if isBorderlessBubbleChatEnabled() and value.isBorderless then
            local var2 = "Bubble" .. value.messageId
            tbl1[var2] = Roact.createElement(BorderlessBubbleChat, {
                messageId = value.messageId,
                text = value.borderlessText or "",
                timestamp = value.timestamp or 0,
                receivedAtMillis = value.borderlessReceivedAtMillis,
                isDistant = arg1.props.isDistant,
                distanceTransparency = arg1.props.borderlessDistanceTransparency,
                fadingOut = value.fadingOut,
                onFadeOut = arg1.onBubbleFadeOut,
                chatSettings = chatSettings,
                textChatMessageInstance = value.textChatMessageInstance
            })
        else
            local var2 = "Bubble" .. value.messageId
            local createElement = Roact.createElement
            local var3 = ChatBubble
            local tbl2 = {
                messageId = value.messageId,
                text = text or "",
                translation = 0,
                useTranslation = 0,
                timestamp = 0,
                isMostRecent = 0,
                theme = 0,
                fadingOut = 0,
                onFadeOut = 0,
                chatSettings = 0,
                renderInsert = 0,
                insertSize = 0,
                showCaret = 0,
                clientSettings = 0,
                bubbleChatMessageProperties = 0,
                presetId = 0,
                isTextChatServiceOn = 0,
                textChatMessageInstance = 0
            }

            if not getFFlagChatTranslationUIEnabledBubbleChat() then
                translation = nil
            end

            tbl2.translation = translation
            tbl2.useTranslation = if getFFlagChatTranslationUIEnabledBubbleChat() then value.useTranslation else nil
            tbl2.timestamp = value.timestamp or 0
            tbl2.isMostRecent = isMostRecent
            tbl2.theme = arg1.props.theme
            tbl2.fadingOut = value.fadingOut
            tbl2.onFadeOut = arg1.onBubbleFadeOut
            tbl2.chatSettings = chatSettings
            tbl2.renderInsert = renderFirstInsert
            tbl2.insertSize = insertSize
            tbl2.showCaret = arg1.props.showCaret
            tbl2.clientSettings = arg1.props.clientSettings
            tbl2.bubbleChatMessageProperties = value.bubbleChatMessageProperties
            tbl2.presetId = if FFlagExpChatPresetChatEnabled then value.presetId else nil
            tbl2.isTextChatServiceOn = arg1.props.isTextChatServiceOn
            tbl2.textChatMessageInstance = if getFFlagExpChatUseUpdatedMessageRendered() then value.textChatMessageInstance else nil
            tbl1[var2] = createElement(var3, tbl2)
        end
    end

    return Roact.createElement(
        "Frame",
        {
            Visible = arg1.props.isVisible,
            Size = UDim2.fromScale(1, 1),
            BackgroundTransparency = 1
        },
        tbl1
    )
end

return var1

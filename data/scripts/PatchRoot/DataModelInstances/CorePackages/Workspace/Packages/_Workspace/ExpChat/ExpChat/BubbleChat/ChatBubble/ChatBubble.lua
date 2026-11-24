-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T07:40:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local TextChatService = game:GetService("TextChatService")

local Flags = ExpChat.Flags
local getEnablePerBubbleCustomization = require(Flags.getEnablePerBubbleCustomization)

local ExpChatParent = ExpChat.Parent
local Roact = require(ExpChatParent.Roact)
local Otter = require(ExpChatParent.Otter)
local Dictionary = require(ExpChatParent.llama).Dictionary
local ExpChatShared = require(ExpChatParent.ExpChatShared)

local Config = require(ExpChat.Config)

local memoize = require(ExpChat.memoize)

local Helpers = ExpChat.BubbleChat.Helpers
local getSpringFromSettings = require(Helpers.getSpringFromSettings)
local getTextBounds = require(Helpers.getTextBounds)
local getDictFromBubbleChatMessageProperties = require(Helpers.getDictFromBubbleChatMessageProperties)
local shouldSendHighFrequencyTelemetry = require(ExpChat.shouldSendHighFrequencyTelemetry)

local ClientSettingsUtility = require(ExpChat.ClientSettings.ClientSettingsUtility)
local getFFlagExpChatUseUpdatedMessageRendered = require(ExpChat.Flags.getFFlagExpChatUseUpdatedMessageRendered)

local var1 = require(ExpChat.Flags.getFIntExpChatMessageRenderUserThrottlePermyriad)()
local getFFlagExpChatExcludeFOMORenders = require(ExpChat.Flags.getFFlagExpChatExcludeFOMORenders)
local FFlagExpChatPresetChatEnabled = ExpChatShared.Flags.FFlagExpChatPresetChatEnabled

local EngineFeatureExpChatGlobalChatEngineTelemetryEnabled = require(ExpChat.Flags.EngineFeatureExpChatGlobalChatEngineTelemetryEnabled)

local getPresetIconRichText = ExpChatShared.getPresetIconRichText
local getPresetIconSize = ExpChatShared.getPresetIconSize
local isPresetMessage = ExpChatShared.isPresetMessage

local var2 = Roact.Component:extend("ChatBubble")
var2.defaultProps = { isMostRecent = true, text = "", timestamp = 0 }

local var3 = memoize(function(arg1, arg2)
    if arg2 then
        return Dictionary.join(arg1, getDictFromBubbleChatMessageProperties(arg2))
    end

    return arg1
end)

function var2.init(arg1)
    local width, updateWidth = Roact.createBinding(0)
    arg1.width = width
    arg1.updateWidth = updateWidth
    arg1.widthMotor = Otter.createSingleMotor(0)
    arg1.widthMotor:onStep(function(arg2)
        arg1.updateWidth(math.round(arg2))
    end)

    local height, updateHeight = Roact.createBinding(0)
    arg1.height = height
    arg1.updateHeight = updateHeight
    arg1.heightMotor = Otter.createSingleMotor(0)
    arg1.heightMotor:onStep(function(arg2)
        arg1.updateHeight(math.round(arg2))
    end)

    local transparency, updateTransparency = Roact.createBinding(1)
    arg1.transparency = transparency
    arg1.updateTransparency = updateTransparency
    arg1.transparencyMotor = Otter.createSingleMotor(1)
    arg1.transparencyMotor:onStep(arg1.updateTransparency)

    local backgroundTransparency, updateBackgroundTransparency = Roact.createBinding(1)
    arg1.backgroundTransparency = backgroundTransparency
    arg1.updateBackgroundTransparency = updateBackgroundTransparency
    arg1.backgroundTransparencyMotor = Otter.createSingleMotor(1)
    arg1.backgroundTransparencyMotor:onStep(arg1.updateBackgroundTransparency)

    arg1.size = Roact.joinBindings({ arg1.width, arg1.height }):map(function(tbl1: {number}): UDim2
        return UDim2.fromOffset(tbl1[1], tbl1[2])
    end)
end

function var2.render(arg1)
    local chatSettings = arg1.props.chatSettings
    if getEnablePerBubbleCustomization() then
        chatSettings = var3(arg1.props.chatSettings, arg1.props.bubbleChatMessageProperties)
    end

    local var4 = nil

    local fontFace = nil
    local var5, var6, uiCorner, uiPadding

    if arg1.props.isTextChatServiceOn then
        var5 = chatSettings.ImageLabel
        var6 = chatSettings.UIGradient
        uiCorner = chatSettings.UICorner
        uiPadding = chatSettings.UIPadding
        fontFace = chatSettings.FontFace
    else
        var5 = chatSettings.BackgroundImage

        var6 = chatSettings.BackgroundGradient

        uiCorner = chatSettings.CornerEnabled and {
            CornerRadius = chatSettings.CornerRadius
        }
            or chatSettings.CornerEnabled == false and {
                CornerRadius = UDim.new(0, 0)
            }
            or var4

        uiPadding = chatSettings.Padding
            and {
                PaddingTop = UDim.new(0, chatSettings.Padding),
                PaddingRight = UDim.new(0, chatSettings.Padding),
                PaddingBottom = UDim.new(0, chatSettings.Padding),
                PaddingLeft = UDim.new(0, chatSettings.Padding)
            }
            or nil
    end

    local cornerRadius = Config.DefaultBubbleChatChildrenCustomizationProperties.UICorner.CornerRadius
    local uiPadding2 = Config.DefaultBubbleChatChildrenCustomizationProperties.UIPadding

    local var7 = arg1.props.renderInsert and arg1.props.insertSize.X + chatSettings.Padding or 0
    local isTextChatServiceOn = FFlagExpChatPresetChatEnabled and isPresetMessage(arg1.props) and arg1.props.isTextChatServiceOn
    local showCaret = arg1.props.isMostRecent and chatSettings.TailVisible and arg1.props.showCaret

    if getFFlagExpChatUseUpdatedMessageRendered()
        and arg1.props.textChatMessageInstance
        and shouldSendHighFrequencyTelemetry(var1)
        and not (getFFlagExpChatExcludeFOMORenders() and arg1.props.isHiddenMessage)
    then
        if EngineFeatureExpChatGlobalChatEngineTelemetryEnabled then
            TextChatService:SendExpChatMessageClientRendered(arg1.props.textChatMessageInstance, "bubble_chat", -1)
        else
            TextChatService:SendExpChatMessageClientRendered(arg1.props.textChatMessageInstance, "bubble_chat")
        end
    end

    local var8

    if FFlagExpChatPresetChatEnabled then
        if arg1.props.useTranslation and arg1.props.translation and arg1.props.translation ~= "" then
            var8 = arg1.props.translation
        else
            var8 = arg1.props.text
        end
        if isTextChatServiceOn then
            var8 ..= ` {getPresetIconRichText(chatSettings.TextSize)}`
        end
    else
        var8 = nil
    end

    local createElement = Roact.createElement
    local str1 = "Frame"
    local tbl1 = {
        LayoutOrder = arg1.props.timestamp,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Size = arg1.size,
        Position = UDim2.fromScale(1, 0.5),
        Transparency = 1
    }
    local tbl2 = {
        Layout = Roact.createElement("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            Padding = UDim.new(0, -1)
        }),
        ChatBubbleFrame = 0,
        Caret = 0
    }

    local createElement2 = Roact.createElement
    local str2 = "ImageLabel"
    local var9 = Dictionary.join(var5, {
        LayoutOrder = 1,
        BackgroundColor3 = chatSettings.BackgroundColor3,
        AnchorPoint = Vector2.new(0.5, 0),
        Size = UDim2.fromScale(1, 1),
        BorderSizePixel = 0,
        Position = UDim2.new(0.5, 0, 0, 0),
        BackgroundTransparency = if var5 and var5.Image ~= "" then 1 else arg1.backgroundTransparency or arg1.transparency,
        ClipsDescendants = true,
        ImageTransparency = arg1.backgroundTransparency or arg1.transparency
    })
    local tbl3 = {
        UICorner = uiCorner and Roact.createElement("UICorner", { CornerRadius = uiCorner.CornerRadius })
            or Roact.createElement("UICorner", { CornerRadius = cornerRadius }),
        UIListLayout = Roact.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal,
            SortOrder = Enum.SortOrder.LayoutOrder,
            VerticalAlignment = Enum.VerticalAlignment.Bottom,
            Padding = UDim.new(0, chatSettings.Padding)
        }),
        Padding = uiPadding and Roact.createElement("UIPadding", uiPadding) or Roact.createElement("UIPadding", uiPadding2),
        Insert = arg1.props.renderInsert and arg1.props.renderInsert(),
        Text = 0,
        Gradient = 0
    }
    local createElement3 = Roact.createElement
    local str3 = "TextLabel"
    local tbl4 = {
        Text = 0,
        Size = 0,
        AnchorPoint = 0,
        Position = 0,
        BackgroundTransparency = 1,
        FontFace = 0,
        Font = 0,
        TextColor3 = 0,
        TextSize = 0,
        TextTransparency = 0,
        TextWrapped = true,
        AutoLocalize = false,
        LayoutOrder = 2,
        RichText = 0
    }

    if not FFlagExpChatPresetChatEnabled then
        if arg1.props.useTranslation and arg1.props.translation and arg1.props.translation ~= "" then
            var8 = arg1.props.translation
        else
            var8 = arg1.props.text
        end
    end

    tbl4.Text = var8

    tbl4.Size = UDim2.new(1, -var7, 1, 0)
    tbl4.AnchorPoint = Vector2.new(0.5, 0.5)
    tbl4.Position = UDim2.fromScale(0.5, 0.5)

    tbl4.FontFace = fontFace or nil
    tbl4.Font = if fontFace then nil else chatSettings.Font
    tbl4.TextColor3 = chatSettings.TextColor3
    tbl4.TextSize = chatSettings.TextSize
    tbl4.TextTransparency = arg1.transparency

    tbl4.RichText = arg1.props.isTextChatServiceOn
    tbl3.Text = createElement3(str3, tbl4)

    tbl3.Gradient = not (var6 == nil) and Roact.createElement("UIGradient", var6)
    tbl2.ChatBubbleFrame = createElement2(str2, var9, tbl3)
    local element = if showCaret then Roact.createElement(
        "ImageLabel",
        {
            LayoutOrder = 2,
            BackgroundTransparency = 1,
            Size = UDim2.fromOffset(9, 6),
            Image = "rbxasset://textures/ui/InGameChat/Caret.png",
            ImageColor3 = chatSettings.BackgroundColor3,
            ImageTransparency = arg1.backgroundTransparency
        },
        {
            Gradient = not (var6 == nil) and Roact.createElement("UIGradient", var6)
        }
    ) else nil
    tbl2.Caret = element
    return createElement(str1, tbl1, tbl2)
end

function var2.fadeOut(arg1)
    local chatSettings = arg1.props.chatSettings
    if getEnablePerBubbleCustomization() then
        chatSettings = var3(arg1.props.chatSettings, arg1.props.bubbleChatMessageProperties)
    end
    if arg1.isFadingOut then
        return
    end

    arg1.isFadingOut = true

    arg1.transparencyMotor:onComplete(function()
        if arg1.props.onFadeOut then
            arg1.props.onFadeOut(arg1.props.messageId)
        end
    end)

    local springFromSettings = getSpringFromSettings(chatSettings, "transparency")
    arg1.transparencyMotor:setGoal(springFromSettings(1))
    arg1.backgroundTransparencyMotor:setGoal(springFromSettings(1))
end

function var2.didUpdate(arg1, arg2)
    if arg1.props.fadingOut then
        arg1:fadeOut()
    end

    local chatSettings = arg1.props.chatSettings
    if getEnablePerBubbleCustomization() then
        chatSettings = var3(arg1.props.chatSettings, arg1.props.bubbleChatMessageProperties)
    end

    if arg2.text == arg1.props.text
        and arg2.useTranslation == arg1.props.useTranslation
        and arg2.translation == arg1.props.translation
        and arg2.chatSettings == arg1.props.chatSettings
        and arg2.renderInsert == arg1.props.renderInsert
        and arg2.insertSize == arg1.props.insertSize
    then
        return
    end

    local textBounds = if arg1.props.useTranslation and arg1.props.translation and arg1.props.translation ~= "" then getTextBounds(arg1.props.translation, chatSettings) else getTextBounds(arg1.props.text, chatSettings)
    local springFromSettings = getSpringFromSettings(chatSettings, "size")
    local padding = chatSettings.Padding

    local textBoundsX = textBounds.X
    local textBoundsY = textBounds.Y
    if arg1.props.renderInsert then
        textBoundsX += arg1.props.insertSize.X + padding
        textBoundsY = math.max(textBoundsY, arg1.props.insertSize.Y + padding * 2)
    end
    local isTextChatServiceOn = FFlagExpChatPresetChatEnabled and isPresetMessage(arg1.props) and arg1.props.isTextChatServiceOn
    if FFlagExpChatPresetChatEnabled and isTextChatServiceOn then
        local presetIconSize = getPresetIconSize(chatSettings.TextSize)
        textBoundsX += presetIconSize + padding
        textBoundsY = math.max(textBoundsY, presetIconSize)
    end
    arg1.heightMotor:setGoal(springFromSettings(textBoundsY))
    arg1.widthMotor:setGoal(springFromSettings(textBoundsX))
end

function var2.didMount(arg1)
    arg1.isMounted = true

    local chatSettings = arg1.props.chatSettings
    if getEnablePerBubbleCustomization() then
        chatSettings = var3(arg1.props.chatSettings, arg1.props.bubbleChatMessageProperties)
    end

    local textBounds = if arg1.props.useTranslation and arg1.props.translation and arg1.props.translation ~= "" then getTextBounds(arg1.props.translation, chatSettings) else getTextBounds(arg1.props.text, chatSettings)
    local springFromSettings = getSpringFromSettings(chatSettings, "size")
    local springFromSettings2 = getSpringFromSettings(chatSettings, "transparency")

    local textBoundsX = textBounds.X
    local textBoundsY = textBounds.Y
    if arg1.props.renderInsert then
        textBoundsX += arg1.props.insertSize.X + chatSettings.Padding
        textBoundsY = math.max(textBoundsY, arg1.props.insertSize.Y + chatSettings.Padding * 2)
    end
    local isTextChatServiceOn = FFlagExpChatPresetChatEnabled and isPresetMessage(arg1.props) and arg1.props.isTextChatServiceOn
    if FFlagExpChatPresetChatEnabled and isTextChatServiceOn then
        local presetIconSize = getPresetIconSize(chatSettings.TextSize)
        textBoundsX += presetIconSize + chatSettings.Padding
        textBoundsY = math.max(textBoundsY, presetIconSize)
    end

    if arg1.props.isMostRecent then
        arg1.heightMotor:setGoal(springFromSettings(textBoundsY))
        arg1.widthMotor:setGoal(Otter.instant(textBoundsX))
    else
        arg1.heightMotor:setGoal(springFromSettings(textBoundsY))
        arg1.widthMotor:setGoal(springFromSettings(textBoundsX))
    end

    local chatSettingsTransparency = chatSettings.Transparency
    arg1.transparencyMotor:setGoal(springFromSettings2(chatSettingsTransparency))

    local backgroundTransparency = ClientSettingsUtility.getBackgroundTransparency(chatSettings, arg1.props.clientSettings)

    if getEnablePerBubbleCustomization() then
        local bubbleChatMessageProperties = arg1.props.bubbleChatMessageProperties
        if bubbleChatMessageProperties and bubbleChatMessageProperties.BackgroundTransparency then
            backgroundTransparency = ClientSettingsUtility.getBackgroundTransparency(
                {
                    BackgroundTransparency = bubbleChatMessageProperties.BackgroundTransparency
                },
                arg1.props.clientSettings
            )
        end
    end

    arg1.backgroundTransparencyMotor:setGoal(springFromSettings2(backgroundTransparency))
end

function var2.willUnmount(arg1)
    arg1.isMounted = false
    arg1.transparencyMotor:destroy()
    arg1.backgroundTransparencyMotor:destroy()
    arg1.heightMotor:destroy()
    arg1.widthMotor:destroy()
end

return var2

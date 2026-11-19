-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:01:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local TextService = game:GetService("TextService")
local TextChatService = game:GetService("TextChatService")

local Otter = require(CorePackages.Packages.Otter)
local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)
local t = require(CorePackages.Packages.t)
local Cryo = require(CorePackages.Packages.Cryo)

local scriptParentParent = script.Parent.Parent
local Types = require(scriptParentParent.Types)
local getSizeSpringFromSettings = require(scriptParentParent.Helpers.getSizeSpringFromSettings)
local getTransparencySpringFromSettings = require(scriptParentParent.Helpers.getTransparencySpringFromSettings)

local CoreGui = game:GetService("CoreGui")
local var1 = Roact.PureComponent:extend("ChatBubble")

var1.validateProps = t.strictInterface({
    messageId = t.string,
    fadingOut = t.optional(t.boolean),
    onFadeOut = t.optional(t.callback),
    isMostRecent = t.optional(t.boolean),
    theme = t.optional(t.string),
    renderInsert = t.optional(t.callback),
    insertSize = t.optional(t.Vector2),
    chatSettings = Types.IChatSettings,
    text = t.string,
    timestamp = t.number
})

var1.defaultProps = { theme = "Light", isMostRecent = true }

local function initMockSizingLabel(): TextLabel -- Luacid: Inlined by compiler; 1 call site recovered
    local richTextSizingLabel = Instance.new("ScreenGui")
    richTextSizingLabel.Enabled = false
    richTextSizingLabel.Name = "RichTextSizingLabel"
    local textLabel = Instance.new("TextLabel")
    textLabel.TextWrapped = true
    textLabel.RichText = true
    textLabel.Parent = richTextSizingLabel
    richTextSizingLabel.Parent = CoreGui
    return textLabel
end

function var1.init(arg1)
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

    arg1.size = Roact.joinBindings({ arg1.width, arg1.height }):map(function(tbl1: {number}): UDim2
        return UDim2.fromOffset(tbl1[1], tbl1[2])
    end)

    arg1.mockSizingLabel = nil

    arg1.isRichTextEnabled = TextChatService.ChatVersion == Enum.ChatVersion.TextChatService
end

function var1.getBoundsFromSizingLabel(_, textLabelText, textSize, font, arg1)
    local textLabel = initMockSizingLabel()
    textLabel.Text = textLabelText
    textLabel.TextSize = textSize
    textLabel.Font = font
    textLabel.Size = UDim2.fromOffset(arg1.X, arg1.Y)

    local textBounds = textLabel.TextBounds
    textLabel.Parent:Destroy()

    return textBounds
end

function var1.getTextBounds(arg1)
    local chatSettings = arg1.props.chatSettings
    local vector2 = Vector2.new(chatSettings.Padding * 4, chatSettings.Padding * 2)

    local _vector2 = Vector2.new(0, 0)
    local var2

    if arg1.isRichTextEnabled then
        var2 = arg1:getBoundsFromSizingLabel(
            arg1.props.text,
            chatSettings.TextSize,
            chatSettings.Font,
            Vector2.new(chatSettings.MaxWidth, 10000)
        )
    else
        var2 = TextService:GetTextSize(
            arg1.props.text,
            chatSettings.TextSize,
            chatSettings.Font,
            Vector2.new(chatSettings.MaxWidth, 10000)
        )
    end

    return var2 + vector2
end

function var1.render(arg1)
    local chatSettings = arg1.props.chatSettings
    local backgroundImage = chatSettings.BackgroundImage
    local backgroundGradient = chatSettings.BackgroundGradient

    local var2 = arg1.props.renderInsert and arg1.props.insertSize.X + chatSettings.Padding or 0

    return Roact.createElement("Frame", {
        LayoutOrder = arg1.props.timestamp,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Size = arg1.size,
        Position = UDim2.fromScale(1, 0.5),
        Transparency = 1
    }, {
        Layout = Roact.createElement("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            Padding = UDim.new(0, -1)
        }),
        Frame = Roact.createElement(
            "ImageLabel",
            Cryo.Dictionary.join(backgroundImage, {
                LayoutOrder = 1,
                BackgroundColor3 = chatSettings.BackgroundColor3,
                AnchorPoint = Vector2.new(0.5, 0),
                Size = UDim2.fromScale(1, 1),
                BorderSizePixel = 0,
                Position = UDim2.new(0.5, 0, 0, 0),
                BackgroundTransparency = if backgroundImage.Image ~= "" then 1 else arg1.transparency,
                ClipsDescendants = true,
                ImageTransparency = arg1.transparency
            }),
            {
                UICorner = chatSettings.CornerEnabled and Roact.createElement("UICorner", { CornerRadius = chatSettings.CornerRadius }),
                UIListLayout = Roact.createElement("UIListLayout", {
                    FillDirection = Enum.FillDirection.Horizontal,
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    VerticalAlignment = Enum.VerticalAlignment.Bottom,
                    Padding = UDim.new(0, chatSettings.Padding)
                }),
                Padding = Roact.createElement("UIPadding", {
                    PaddingTop = UDim.new(0, chatSettings.Padding),
                    PaddingRight = UDim.new(0, chatSettings.Padding),
                    PaddingBottom = UDim.new(0, chatSettings.Padding),
                    PaddingLeft = UDim.new(0, chatSettings.Padding)
                }),
                Insert = arg1.props.renderInsert and arg1.props.renderInsert(),
                Text = Roact.createElement("TextLabel", {
                    Text = arg1.props.text,
                    Size = UDim2.new(1, -var2, 1, 0),
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Position = UDim2.fromScale(0.5, 0.5),
                    BackgroundTransparency = 1,
                    Font = chatSettings.Font,
                    TextColor3 = chatSettings.TextColor3,
                    TextSize = chatSettings.TextSize,
                    TextTransparency = arg1.transparency,
                    TextWrapped = true,
                    AutoLocalize = false,
                    LayoutOrder = 2,
                    RichText = arg1.isRichTextEnabled
                }),
                Gradient = backgroundGradient.Enabled and Roact.createElement("UIGradient", backgroundGradient)
            }
        ),
        Carat = arg1.props.isMostRecent
            and chatSettings.TailVisible
            and arg1.props.showCarat
            and Roact.createElement("ImageLabel", {
                LayoutOrder = 2,
                BackgroundTransparency = 1,
                Size = UDim2.fromOffset(9, 6),
                Image = "rbxasset://textures/ui/InGameChat/Caret.png",
                ImageColor3 = chatSettings.BackgroundColor3,
                ImageTransparency = arg1.transparency
            })
    })
end

function var1.fadeOut(arg1)
    if arg1.isFadingOut then
        return
    end

    arg1.isFadingOut = true

    arg1.transparencyMotor:onComplete(function()
        if arg1.props.onFadeOut then
            arg1.props.onFadeOut(arg1.props.messageId)
        end
    end)

    local transparencySpringFromSettings = getTransparencySpringFromSettings(arg1.props.chatSettings)
    arg1.transparencyMotor:setGoal(transparencySpringFromSettings(1))
end

function var1.didUpdate(arg1, arg2)
    if arg1.props.fadingOut then
        arg1:fadeOut()
    end

    if arg2.text == arg1.props.text
        and arg2.chatSettings == arg1.props.chatSettings
        and arg2.renderInsert == arg1.props.renderInsert
        and arg2.insertSize == arg1.props.insertSize
    then
        return
    end
    local textBounds = arg1:getTextBounds()
    local sizeSpringFromSettings = getSizeSpringFromSettings(arg1.props.chatSettings)
    local padding = arg1.props.chatSettings.Padding

    local textBoundsX = textBounds.X
    local textBoundsY = textBounds.Y
    if arg1.props.renderInsert then
        textBoundsX += arg1.props.insertSize.X + padding
        textBoundsY = math.max(textBoundsY, arg1.props.insertSize.Y + padding * 2)
    end
    arg1.heightMotor:setGoal(sizeSpringFromSettings(textBoundsY))
    arg1.widthMotor:setGoal(sizeSpringFromSettings(textBoundsX))
end

function var1.didMount(arg1)
    arg1.isMounted = true

    local textBounds = arg1:getTextBounds()
    local chatSettings = arg1.props.chatSettings
    local sizeSpringFromSettings = getSizeSpringFromSettings(chatSettings)
    local transparencySpringFromSettings = getTransparencySpringFromSettings(chatSettings)

    local textBoundsX = textBounds.X
    local textBoundsY = textBounds.Y
    if arg1.props.renderInsert then
        textBoundsX += arg1.props.insertSize.X + chatSettings.Padding
        textBoundsY = math.max(textBoundsY, arg1.props.insertSize.Y + chatSettings.Padding * 2)
    end

    if arg1.props.isMostRecent then
        arg1.heightMotor:setGoal(sizeSpringFromSettings(textBoundsY))
        arg1.widthMotor:setGoal(Otter.instant(textBoundsX))
    else
        arg1.heightMotor:setGoal(sizeSpringFromSettings(textBoundsY))
        arg1.widthMotor:setGoal(sizeSpringFromSettings(textBoundsX))
    end

    arg1.transparencyMotor:setGoal(transparencySpringFromSettings(chatSettings.Transparency))
end

function var1.willUnmount(arg1)
    arg1.isMounted = false
    arg1.transparencyMotor:destroy()
    arg1.heightMotor:destroy()
    arg1.widthMotor:destroy()
end

return RoactRodux.connect(function(arg1, arg2) -- name: mapStateToProps
    local var2 = arg1.messages[arg2.messageId]
    return {
        text = var2 and var2.text or "",
        timestamp = var2 and var2.timestamp or 0
    }
end)(var1)

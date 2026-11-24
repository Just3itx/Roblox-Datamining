-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T07:31:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent
local Dictionary = require(ExpChatParent.llama).Dictionary
local Roact = require(ExpChatParent.Roact)
local Otter = require(ExpChatParent.Otter)

local Config = require(ExpChat.Config)

local BubbleChat = script:FindFirstAncestor("BubbleChat")
local getSpringFromSettings = require(BubbleChat.Helpers.getSpringFromSettings)
local ClientSettingsUtility = require(ExpChat.ClientSettings.ClientSettingsUtility)

local var1 = Roact.PureComponent:extend("BlankBubble")

function var1.init(arg1, arg2)
    arg1.state = {}
    local width, updateWidth = Roact.createBinding(0)
    arg1.width = width
    arg1.updateWidth = updateWidth
    arg1.widthMotor = Otter.createSingleMotor(0)
    arg1.widthMotor:onStep(function(arg3)
        arg1.updateWidth(math.round(arg3))
    end)

    arg1.frameSize = arg1.width:map(function(xOffset: number): UDim2
        if arg1.props.insertSize then
            return UDim2.fromOffset(xOffset, arg1.props.insertSize.Y + arg1.props.chatSettings.Padding * 2)
        end
        return UDim2.fromOffset(xOffset, 0)
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

    if arg2.fadingOut then
        arg1:fadeOut()
    end
end

function var1.getDerivedStateFromProps(arg1, arg2): {fullWidth: any}?
    local fullWidth = if arg1.insertSize then arg1.insertSize.X + arg1.chatSettings.Padding * 2 else 0

    return if fullWidth == arg2.fullWidth then nil else { fullWidth = fullWidth }
end

function var1.render(arg1)
    local chatSettings = arg1.props.chatSettings
    local imageLabel = chatSettings.ImageLabel
    local uiGradient = chatSettings.UIGradient
    local uiCorner = chatSettings.UICorner
    local cornerRadius = Config.DefaultBubbleChatChildrenCustomizationProperties.UICorner.CornerRadius

    local yOffset = if arg1.props.insertSize then arg1.props.insertSize.Y + arg1.props.chatSettings.Padding * 2 else 0

    local createElement = Roact.createElement
    local str1 = "Frame"
    local tbl1 = {
        AnchorPoint = Vector2.new(0.5, 1),
        Size = UDim2.fromOffset(arg1.state.fullWidth, yOffset),
        Position = UDim2.new(0.5, 0, 1, -8),
        Transparency = 1
    }
    local tbl2 = {
        Scale = Roact.createElement("UIScale", { Scale = if arg1.props.isDistant then 0.75 else 1 }),
        Caret = 0,
        RoundedFrame = 0
    }
    local tailVisible = arg1.props.chatSettings.TailVisible

    if tailVisible then
        tailVisible = Roact.createElement(
            "ImageLabel",
            {
                AnchorPoint = Vector2.new(0.5, 0),
                BackgroundTransparency = 1,
                Position = UDim2.new(0.5, 0, 1, -1),
                Size = UDim2.fromOffset(12, 8),
                Image = "rbxasset://textures/ui/InGameChat/Caret.png",
                ImageColor3 = chatSettings.BackgroundColor3,
                ImageTransparency = arg1.backgroundTransparency
            },
            {
                Gradient = not (uiGradient == nil) and Roact.createElement("UIGradient", uiGradient)
            }
        )
    end

    tbl2.Caret = tailVisible

    tbl2.RoundedFrame = Roact.createElement(
        "ImageLabel",
        Dictionary.join(imageLabel, {
            Size = arg1.frameSize,
            BackgroundColor3 = chatSettings.BackgroundColor3,
            BackgroundTransparency = if imageLabel and imageLabel.Image ~= "" then 1 else arg1.backgroundTransparency or arg1.transparency,
            BorderSizePixel = 0,
            AnchorPoint = Vector2.new(0.5, 0),
            Position = UDim2.new(0.5, 0, 0, 0),
            ClipsDescendants = true,
            ImageTransparency = arg1.backgroundTransparency or arg1.transparency,
            Image = imageLabel and imageLabel.Image or ""
        }),
        {
            UICorner = uiCorner and Roact.createElement("UICorner", { CornerRadius = uiCorner.CornerRadius })
                or Roact.createElement("UICorner", { CornerRadius = cornerRadius }),
            Contents = Roact.createElement("Frame", {
                Size = UDim2.fromScale(1, 1),
                BackgroundTransparency = 1
            }, {
                Padding = Roact.createElement("UIPadding", {
                    PaddingTop = UDim.new(0, arg1.props.chatSettings.Padding),
                    PaddingRight = UDim.new(0, arg1.props.chatSettings.Padding),
                    PaddingBottom = UDim.new(0, arg1.props.chatSettings.Padding),
                    PaddingLeft = UDim.new(0, arg1.props.chatSettings.Padding)
                }),
                Insert = arg1.props.renderInsert and arg1.props.renderInsert()
            }),
            Gradient = not (uiGradient == nil) and Roact.createElement("UIGradient", uiGradient)
        }
    )
    return createElement(str1, tbl1, tbl2)
end

function var1.fadeIn(arg1)
    local springFromSettings = getSpringFromSettings(arg1.props.chatSettings, "transparency")

    arg1.transparencyMotor:setGoal(springFromSettings(arg1.props.chatSettings.Transparency))

    local backgroundTransparency = ClientSettingsUtility.getBackgroundTransparency(arg1.props.chatSettings, arg1.props.clientSettings)

    arg1.backgroundTransparencyMotor:setGoal(springFromSettings(backgroundTransparency))

    local springFromSettings2 = getSpringFromSettings(arg1.props.chatSettings, "size")
    arg1.widthMotor:setGoal(springFromSettings2(arg1.state.fullWidth))
end

function var1.fadeOut(arg1)
    arg1.transparencyMotor:onComplete(function()
        if arg1.props.onFadeOut then
            arg1.props.onFadeOut()
        end
    end)

    local springFromSettings = getSpringFromSettings(arg1.props.chatSettings, "transparency")
    arg1.transparencyMotor:setGoal(springFromSettings(1))
    arg1.backgroundTransparencyMotor:setGoal(springFromSettings(1))
end

function var1.didUpdate(arg1, arg2, arg3)
    if arg2.fadingOut ~= arg1.props.fadingOut then
        if arg1.props.fadingOut then
            arg1:fadeOut()
        else
            arg1:fadeIn()
        end
    end
    if arg1.state.fullWidth ~= arg3.fullWidth then
        local springFromSettings = getSpringFromSettings(arg1.props.chatSettings, "size")
        arg1.widthMotor:setGoal(springFromSettings(arg1.state.fullWidth))
    end
end

function var1.didMount(arg1)
    if arg1.props.fadingOut then
        return
    end

    local springFromSettings = getSpringFromSettings(arg1.props.chatSettings, "size")
    local springFromSettings2 = getSpringFromSettings(arg1.props.chatSettings, "transparency")

    arg1.transparencyMotor:setGoal(springFromSettings2(arg1.props.chatSettings.Transparency))

    local backgroundTransparency = ClientSettingsUtility.getBackgroundTransparency(arg1.props.chatSettings, arg1.props.clientSettings)

    arg1.backgroundTransparencyMotor:setGoal(springFromSettings2(backgroundTransparency))

    arg1.widthMotor:setGoal(springFromSettings(arg1.state.fullWidth))
end

function var1.willUnmount(arg1)
    arg1.transparencyMotor:destroy()

    arg1.backgroundTransparencyMotor:destroy()

    arg1.widthMotor:destroy()
end

return var1

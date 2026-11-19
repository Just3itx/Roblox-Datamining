-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:01:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local Otter = require(CorePackages.Packages.Otter)
local Roact = require(CorePackages.Packages.Roact)
local t = require(CorePackages.Packages.t)
local Cryo = require(CorePackages.Packages.Cryo)

local scriptParentParent = script.Parent.Parent
local Types = require(scriptParentParent.Types)
local getSizeSpringFromSettings = require(scriptParentParent.Helpers.getSizeSpringFromSettings)
local getTransparencySpringFromSettings = require(scriptParentParent.Helpers.getTransparencySpringFromSettings)

local _RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")

local var1 = Roact.PureComponent:extend("VoiceBubble")

var1.validateProps = t.strictInterface({
    fadingOut = t.optional(t.boolean),
    onFadeOut = t.optional(t.callback),
    chatSettings = Types.IChatSettings,
    renderInsert = t.optional(t.callback),
    insertSize = t.optional(t.Vector2),
    isDistant = t.optional(t.boolean)
})

function var1.init(arg1, arg2)
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

    if arg2.fadingOut then
        arg1:fadeOut()
    end
end

function var1.getDerivedStateFromProps(arg1, arg2): {fullWidth: any}?
    local chatSettings = arg1.chatSettings

    local fullWidth = if arg1.insertSize then arg1.insertSize.X + chatSettings.Padding * 2 else 0

    return if fullWidth == arg2.fullWidth then nil else { fullWidth = fullWidth }
end

function var1.render(arg1)
    local chatSettings = arg1.props.chatSettings
    local backgroundImage = chatSettings.BackgroundImage
    local backgroundGradient = chatSettings.BackgroundGradient

    local yOffset = if arg1.props.insertSize then arg1.props.insertSize.Y + chatSettings.Padding * 2 else 0

    return Roact.createElement("Frame", {
        AnchorPoint = Vector2.new(0.5, 1),
        Size = UDim2.fromOffset(arg1.state.fullWidth, yOffset),
        Position = UDim2.new(0.5, 0, 1, -8),
        Transparency = 1
    }, {
        Scale = Roact.createElement("UIScale", { Scale = if arg1.props.isDistant then 0.75 else 1 }),
        Carat = chatSettings.TailVisible
            and Roact.createElement("ImageLabel", {
                AnchorPoint = Vector2.new(0.5, 0),
                BackgroundTransparency = 1,
                Position = UDim2.new(0.5, 0, 1, -1),
                Size = UDim2.fromOffset(12, 8),
                Image = "rbxasset://textures/ui/InGameChat/Caret.png",
                ImageColor3 = chatSettings.BackgroundColor3,
                ImageTransparency = arg1.transparency
            }),
        RoundedFrame = Roact.createElement(
            "ImageLabel",
            Cryo.Dictionary.join(backgroundImage, {
                Size = arg1.frameSize,
                BackgroundColor3 = chatSettings.BackgroundColor3,
                BackgroundTransparency = if backgroundImage.Image ~= "" then 1 else arg1.transparency or 1,
                BorderSizePixel = 0,
                AnchorPoint = Vector2.new(0.5, 0),
                Position = UDim2.new(0.5, 0, 0, 0),
                ClipsDescendants = true,
                ImageTransparency = arg1.transparency
            }),
            {
                UICorner = chatSettings.CornerEnabled and Roact.createElement("UICorner", { CornerRadius = chatSettings.CornerRadius }),
                Contents = Roact.createElement("Frame", {
                    Size = UDim2.fromScale(1, 1),
                    BackgroundTransparency = 1
                }, {
                    Padding = Roact.createElement("UIPadding", {
                        PaddingTop = UDim.new(0, chatSettings.Padding),
                        PaddingRight = UDim.new(0, chatSettings.Padding),
                        PaddingBottom = UDim.new(0, chatSettings.Padding),
                        PaddingLeft = UDim.new(0, chatSettings.Padding)
                    }),
                    Insert = arg1.props.renderInsert and arg1.props.renderInsert()
                }),
                Gradient = backgroundGradient.Enabled and Roact.createElement("UIGradient", backgroundGradient)
            }
        )
    })
end

function var1.fadeOut(arg1)
    if arg1.isFadingOut then
        return
    end

    arg1.isFadingOut = true

    arg1.transparencyMotor:onComplete(function()
        if arg1.props.onFadeOut then
            arg1.props.onFadeOut()
        end
    end)

    local transparencySpringFromSettings = getTransparencySpringFromSettings(arg1.props.chatSettings)
    arg1.transparencyMotor:setGoal(transparencySpringFromSettings(1))
end

function var1.didUpdate(arg1, _, arg2)
    if arg1.props.fadingOut then
        arg1:fadeOut()
    elseif arg1.state.fullWidth ~= arg2.fullWidth then
        local chatSettings = arg1.props.chatSettings
        local sizeSpringFromSettings = getSizeSpringFromSettings(chatSettings)
        arg1.widthMotor:setGoal(sizeSpringFromSettings(arg1.state.fullWidth))
    end
end

function var1.didMount(arg1)
    if arg1.props.fadingOut then
        return
    end

    local chatSettings = arg1.props.chatSettings
    local sizeSpringFromSettings = getSizeSpringFromSettings(chatSettings)
    local transparencySpringFromSettings = getTransparencySpringFromSettings(chatSettings)

    arg1.transparencyMotor:setGoal(transparencySpringFromSettings(arg1.props.chatSettings.Transparency))
    arg1.widthMotor:setGoal(sizeSpringFromSettings(arg1.state.fullWidth))
end

function var1.willUnmount(arg1)
    arg1.transparencyMotor:destroy()
    arg1.widthMotor:destroy()
end

return var1

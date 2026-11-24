-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T07:31:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent
local Roact = require(ExpChatParent.Roact)
local ReactIs = require(ExpChatParent.ReactIs)
local Otter = require(ExpChatParent.Otter)
local MessageEffect = require(ExpChat.MessageEffects.MessageEffect)

local RunService = game:GetService("RunService")
local UserGameSettings = UserSettings():GetService("UserGameSettings")

local BubbleChat = script:FindFirstAncestor("BubbleChat")
local getSpringFromSettings = require(BubbleChat.Helpers.getSpringFromSettings)
local sendBubbleChatRenderedTelemetry = require(BubbleChat.Helpers.sendBubbleChatRenderedTelemetry)
local getBorderlessBubbleChatAnimation = require(BubbleChat.Helpers.getBorderlessBubbleChatAnimation)
local getServerTimeNowMillis = require(BubbleChat.Helpers.getServerTimeNowMillis)

local tbl1 = { MessageEffect.BorderlessBubbleChat }

local function getScale(bool1: boolean): number -- Luacid: Inlined by compiler; 1 call site recovered
    return if bool1 then 0.75 else 1
end

local function combineTransparencies(num1: number, num2: number): number -- Luacid: Inlined by compiler; 3 call sites recovered
    return 1 - (1 - num1) * (1 - num2)
end

local var1 = Roact.Component:extend("BorderlessBubbleChat")
var1.defaultProps = { text = "", timestamp = 0, isDistant = false, distanceTransparency = 0 }

function var1.init(arg1)
    local animation, updateAnimation = Roact.createBinding(arg1:getAnimation())
    arg1.animation = animation
    arg1.updateAnimation = updateAnimation
    arg1.animationConnection = nil

    local transparency, updateTransparency = Roact.createBinding(0)
    arg1.transparency = transparency
    arg1.updateTransparency = updateTransparency
    arg1.transparencyMotor = Otter.createSingleMotor(0)
    arg1.transparencyMotor:onStep(arg1.updateTransparency)

    arg1.animatedTransparency = Roact.joinBindings({ arg1.transparency, arg1.animation }):map(function(arg2): number
        return combineTransparencies(arg2[1], arg2[2].transparency)
    end)
    arg1.textPosition = arg1.animation:map(function(arg2): UDim2
        return UDim2.new(0.5, 0, 1, arg2.yOffset)
    end)
    arg1.animationScale = arg1.animation:map(function(arg2)
        return arg2.scale
    end)
end

function var1.getAnimation(arg1)
    local borderlessBubbleChatAnimation = getBorderlessBubbleChatAnimation((getServerTimeNowMillis() - arg1.props.receivedAtMillis) / 1000)

    if UserGameSettings.ReducedMotion then
        borderlessBubbleChatAnimation.scale = 1
        borderlessBubbleChatAnimation.yOffset = 0
    end
    return borderlessBubbleChatAnimation
end

function var1.stopAnimating(arg1)
    if arg1.animationConnection then
        arg1.animationConnection:Disconnect()
        arg1.animationConnection = nil
    end
end

function var1.render(arg1)
    if arg1.props.textChatMessageInstance then
        sendBubbleChatRenderedTelemetry(arg1.props.textChatMessageInstance, tbl1)
    end

    local distanceTransparency = arg1.props.distanceTransparency

    local textTransparency = if ReactIs.isBinding(distanceTransparency) then Roact.joinBindings({ arg1.animatedTransparency, distanceTransparency }):map(function(arg2): number
        return combineTransparencies(arg2[1], arg2[2])
    end) else arg1.animatedTransparency:map(function(arg2): number
        return combineTransparencies(arg2, distanceTransparency)
    end)

    local createElement = Roact.createElement
    local str1 = "Frame"
    local tbl2 = {
        LayoutOrder = arg1.props.timestamp,
        AnchorPoint = Vector2.new(0.5, 1),
        Position = UDim2.fromScale(0.5, 1),
        Size = UDim2.fromOffset(48, 48),
        BackgroundTransparency = 1,
        BorderSizePixel = 0
    }

    local tbl3 = {
        Scale = Roact.createElement("UIScale", {
            Scale = if ReactIs.isBinding(arg1.props.isDistant) then arg1.props.isDistant:map(getScale) else getScale(arg1.props.isDistant)
        }),
        Text = Roact.createElement(
            "TextLabel",
            {
                AnchorPoint = Vector2.new(0.5, 1),
                Position = arg1.textPosition,
                AutomaticSize = Enum.AutomaticSize.XY,
                Size = UDim2.fromOffset(0, 0),
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Text = arg1.props.text,
                TextSize = 48,
                TextTransparency = textTransparency,
                AutoLocalize = false
            },
            {
                AnimationScale = Roact.createElement("UIScale", { Scale = arg1.animationScale })
            }
        )
    }
    return createElement(str1, tbl2, tbl3)
end

function var1.reportFadeOut(arg1)
    if arg1.props.onFadeOut then
        arg1.props.onFadeOut(arg1.props.messageId)
    end
end

function var1.fadeOut(arg1)
    if arg1.isFadingOut then
        return
    end
    arg1.isFadingOut = true

    if arg1:getAnimation().isComplete then
        arg1:reportFadeOut()
        return
    end

    arg1.transparencyMotor:onComplete(function()
        arg1:reportFadeOut()
    end)

    local springFromSettings = getSpringFromSettings(arg1.props.chatSettings, "transparency")
    arg1.transparencyMotor:setGoal(springFromSettings(1))
end

function var1.didMount(arg1)
    if not arg1.animation:getValue().isComplete then
        arg1.animationConnection = RunService.RenderStepped:Connect(function()
            local animation = arg1:getAnimation()
            arg1.updateAnimation(animation)
            if animation.isComplete then
                arg1:stopAnimating()
            end
        end)
    end

    if arg1.props.fadingOut then
        arg1:fadeOut()
    end
end

function var1.didUpdate(arg1)
    if arg1.props.fadingOut then
        arg1:fadeOut()
    end
end

function var1.willUnmount(arg1)
    arg1:stopAnimating()
    arg1.transparencyMotor:destroy()
end

return var1

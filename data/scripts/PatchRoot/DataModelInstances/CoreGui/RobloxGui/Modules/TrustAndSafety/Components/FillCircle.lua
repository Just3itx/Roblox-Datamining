-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:17:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RunService = game:GetService("RunService")
local CorePackages = game:GetService("CorePackages")

local Roact = require(CorePackages.Packages.Roact)
local UIBlox = require(CorePackages.Packages.UIBlox)
local t = require(CorePackages.Packages.t)

local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local Images = UIBlox.App.ImageSet.Images

local darkStoneGrey = Color3.fromRGB(98, 98, 99)
local white = Color3.fromRGB(255, 255, 255)
local crimson = Color3.fromRGB(196, 0, 1)

local component_assetsCircle_29 = Images["component_assets/circle_29"]

local var1 = Roact.PureComponent:extend("FillCircle")

var1.validateProps = t.strictInterface({
    Position = t.UDim2,
    AnchorPoint = t.Vector2,
    fillFraction = t.number,
    largerCircleFraction = t.number,
    popCircleFraction = t.number,
    shakeCircleFraction = t.number,
    BackgroundColor = t.Color3
})

local function getFillRingZIndex(fillFraction): number -- Luacid: Inlined by compiler; 1 call site recovered
    if fillFraction > 0.75 then
        return 8
    end

    if fillFraction > 0.5 then
        return 6
    end

    if fillFraction > 0.25 then
        return 4
    end

    if fillFraction > 0 then
        return 2
    end

    return 0
end

local function linearTween(arg1, arg2, arg3) -- Luacid: unused: defined but never referenced
    local var2 = (arg3 - arg2) / 30
    return (arg1 - arg2 / 30) / var2
end

local function isBetweenFrames(arg1, num1: number, num2: number): boolean -- Luacid: Inlined by compiler; 7 call sites recovered
    return num1 / 30 <= arg1 and arg1 <= num2 / 30
end

local function largerCircleAnimation(arg1, arg2, arg3, callback)
    if arg3 then
        arg1 = 4 / 15 - arg1
    end

    if arg1 >= 0 and arg1 <= 1 / 6 then
        local var2 = 16 + 6 * ((arg1 - 0) / (1 / 6))
        arg2.size(UDim2.new(0, var2, 0, var2))
    elseif isBetweenFrames(arg1, 5, 8) then
        local var2 = 22 - 2 * ((arg1 - 1 / 6) / 0.1)
        arg2.size(UDim2.new(0, var2, 0, var2))
    elseif arg1 < 0 then
        arg2.size(UDim2.new(0, 16, 0, 16))
        callback()
    else
        arg2.size(UDim2.new(0, 20, 0, 20))
        callback()
    end
end

local function popCircleAnimation(arg1, arg2, _, callback)
    if arg1 >= 0 and arg1 <= 0.1 then
        local var2 = 20 + 4 * ((arg1 - 0) / 0.1)
        arg2.size(UDim2.new(0, var2, 0, var2))
    elseif isBetweenFrames(arg1, 3, 6) then
        local var2 = 24 - 4 * ((arg1 - 0.1) / 0.1)
        arg2.size(UDim2.new(0, var2, 0, var2))
    else
        arg2.size(UDim2.new(0, 20, 0, 20))
        callback()
    end
end

local function shakeCircleAnimation(arg1, arg2, _, callback)
    if arg1 >= 0 and arg1 <= 0.1 then
        local var2 = (arg1 - 0) / 0.1

        arg2.positionOffset(UDim2.new(0, -4 * var2, 0, 0))
    elseif isBetweenFrames(arg1, 3, 6) then
        local var2 = (arg1 - 0.1) / 0.1

        arg2.positionOffset(UDim2.new(0, -4 + 12 * var2, 0, 0))
    elseif isBetweenFrames(arg1, 6, 8) then
        local var2 = (arg1 - 0.2) / (1 / 15)

        arg2.positionOffset(UDim2.new(0, 8 - 16 * var2, 0, 0))
    elseif isBetweenFrames(arg1, 8, 10) then
        local var2 = (arg1 - 4 / 15) / (1 / 15)

        arg2.positionOffset(UDim2.new(0, -8 + 16 * var2, 0, 0))
    elseif isBetweenFrames(arg1, 10, 12) then
        local var2 = (arg1 - 1 / 3) / (1 / 15)

        arg2.positionOffset(UDim2.new(0, 8 - 16 * var2, 0, 0))
    elseif isBetweenFrames(arg1, 12, 14) then
        local var2 = (arg1 - 0.4) / (1 / 15)

        arg2.positionOffset(UDim2.new(0, -8 + 8 * var2, 0, 0))
    else
        arg2.positionOffset(UDim2.new(0, 0, 0, 0))
        callback()
    end
end

function var1.init(arg1)
    local sizeBinding, sizeBindingUpdate = Roact.createBinding(UDim2.new(0, 16, 0, 16))
    arg1.sizeBinding = sizeBinding
    arg1.sizeBindingUpdate = sizeBindingUpdate

    arg1.largerSizeBinding = arg1.sizeBinding:map(function(arg2)
        return arg2 + UDim2.new(0, 2, 0, 2)
    end)
    local positionOffsetBinding, positionOffsetBindingUpdate = Roact.createBinding(UDim2.new(0, 0, 0, 0))
    arg1.positionOffsetBinding = positionOffsetBinding
    arg1.positionOffsetBindingUpdate = positionOffsetBindingUpdate

    arg1.updateBindings = {
        size = arg1.sizeBindingUpdate,
        positionOffset = arg1.positionOffsetBindingUpdate
    }

    arg1.animationStartTime = nil
    arg1.animationFunction = nil
    arg1.reverseAnimation = false
    arg1.renderSteppedConnection = nil
end

function var1.render(arg1)
    local props = arg1.props

    local color3 = props.fillFraction >= 1 and crimson or white

    return Roact.createElement(
        "Frame",
        {
            Size = arg1.sizeBinding,
            Position = props.Position,
            AnchorPoint = props.AnchorPoint,
            BackgroundTransparency = 1
        },
        {
            PositionOffsetFrame = Roact.createElement("Frame", {
                Position = arg1.positionOffsetBinding,
                Size = UDim2.new(1, 0, 1, 0),
                BorderSizePixel = 0,
                BackgroundColor3 = darkStoneGrey
            }, {
                OuterRing = Roact.createElement(ImageSetLabel, {
                    Image = "rbxasset://textures/ui/InGameMenu/CircleCutout.png",
                    Size = UDim2.new(1, 0, 1, 0),
                    ImageColor3 = props.BackgroundColor,
                    BackgroundTransparency = 1,
                    ZIndex = 10
                }),
                InnerRing = Roact.createElement(ImageSetLabel, {
                    Image = component_assetsCircle_29,
                    Size = UDim2.new(1, -4, 1, -4),
                    Position = UDim2.new(0.5, 0, 0.5, 0),
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    ImageColor3 = props.BackgroundColor,
                    BackgroundTransparency = 1,
                    ZIndex = 10
                }),
                FillRingRotationFrame = Roact.createElement("Frame", {
                    BackgroundTransparency = 1,
                    Size = UDim2.new(0, 0, 0, 0),
                    Position = UDim2.new(0.5, 0, 0.5, 0),
                    Rotation = props.fillFraction * 360,
                    ZIndex = getFillRingZIndex(props.fillFraction)
                }, {
                    FillRing = Roact.createElement(ImageSetLabel, {
                        Image = "rbxasset://textures/ui/InGameMenu/QuarterCircle.png",
                        Size = arg1.largerSizeBinding,
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        ImageColor3 = color3,
                        BackgroundTransparency = 1
                    })
                }),
                EdgeBlockers = Roact.createElement(
                    "Frame",
                    {
                        BackgroundTransparency = 1,
                        Size = UDim2.new(1, 0, 1, 0),
                        ZIndex = 10
                    },
                    {
                        Top = Roact.createElement("Frame", {
                            AnchorPoint = Vector2.new(0.5, 1),
                            Position = UDim2.new(0.5, 0, 0, 0),
                            Size = UDim2.new(1, 4, 0, 2),
                            BackgroundColor3 = props.BackgroundColor,
                            BorderSizePixel = 0
                        }),
                        Right = Roact.createElement("Frame", {
                            AnchorPoint = Vector2.new(0, 0.5),
                            Position = UDim2.new(1, 0, 0.5, 0),
                            Size = UDim2.new(0, 2, 1, 4),
                            BackgroundColor3 = props.BackgroundColor,
                            BorderSizePixel = 0
                        }),
                        Bottom = Roact.createElement("Frame", {
                            AnchorPoint = Vector2.new(0.5, 0),
                            Position = UDim2.new(0.5, 0, 1, 0),
                            Size = UDim2.new(1, 4, 0, 2),
                            BackgroundColor3 = props.BackgroundColor,
                            BorderSizePixel = 0
                        }),
                        Left = Roact.createElement("Frame", {
                            AnchorPoint = Vector2.new(1, 0.5),
                            Position = UDim2.new(0, 0, 0.5, 0),
                            Size = UDim2.new(0, 2, 1, 4),
                            BackgroundColor3 = props.BackgroundColor,
                            BorderSizePixel = 0
                        })
                    }
                ),
                TopLeftFill = Roact.createElement("Frame", {
                    Size = UDim2.new(0.5, 0, 0.5, 0),
                    BackgroundColor3 = props.fillFraction >= 1 and color3 or darkStoneGrey,
                    BorderSizePixel = 0,
                    ZIndex = if props.fillFraction >= 1 then 9 else 7
                }),
                BottomLeftFill = Roact.createElement("Frame", {
                    Size = UDim2.new(0.5, 0, 0.5, 0),
                    Position = UDim2.new(0, 0, 0.5, 0),
                    BackgroundColor3 = props.fillFraction >= 0.75 and color3 or darkStoneGrey,
                    BorderSizePixel = 0,
                    ZIndex = if props.fillFraction >= 0.75 then 9 else 5
                }),
                BottomRightFill = Roact.createElement("Frame", {
                    Size = UDim2.new(0.5, 0, 0.5, 0),
                    Position = UDim2.new(0.5, 0, 0.5, 0),
                    BackgroundColor3 = props.fillFraction >= 0.5 and color3 or darkStoneGrey,
                    BorderSizePixel = 0,
                    ZIndex = if props.fillFraction >= 0.5 then 9 else 3
                }),
                TopRightFill = Roact.createElement("Frame", {
                    Size = UDim2.new(0.5, 0, 0.5, 0),
                    Position = UDim2.new(0.5, 0, 0, 0),
                    BackgroundColor3 = props.fillFraction >= 0.25 and color3 or darkStoneGrey,
                    BorderSizePixel = 0,
                    ZIndex = if props.fillFraction >= 0.25 then 9 else 1
                })
            })
        }
    )
end

function var1.didUpdate(arg1, arg2, _)
    local bool1 = arg2.fillFraction >= arg2.largerCircleFraction
    local bool2 = arg1.props.fillFraction >= arg1.props.largerCircleFraction
    if bool1 ~= bool2 then
        arg1:playAnimation(largerCircleAnimation, not bool2)
    end

    local bool3 = arg2.fillFraction >= arg2.popCircleFraction
    if arg1.props.fillFraction >= arg1.props.popCircleFraction and not bool3 then
        arg1:playAnimation(popCircleAnimation, false)
    end

    local bool4 = arg2.fillFraction >= arg2.shakeCircleFraction
    if arg1.props.fillFraction >= arg1.props.shakeCircleFraction and not bool4 then
        arg1:playAnimation(shakeCircleAnimation, false)
    end
end

function var1.playAnimation(arg1, animationFunction, reverseAnimation)
    if arg1.animationFunction then
        arg1.animationFunction(100, arg1.updateBindings, arg1.reverseAnimation, function() end)
    end
    arg1.animationStartTime = tick()
    arg1.animationFunction = animationFunction
    arg1.reverseAnimation = reverseAnimation
    if arg1.renderSteppedConnection then
        return
    end

    arg1.renderSteppedConnection = RunService.RenderStepped:Connect(function()
        arg1.animationFunction(tick() - arg1.animationStartTime, arg1.updateBindings, arg1.reverseAnimation, function()
            arg1:stopAnimation()
        end)
    end)
end

function var1.stopAnimation(arg1)
    if arg1.renderSteppedConnection then
        arg1.renderSteppedConnection:Disconnect()
        arg1.renderSteppedConnection = nil
    end
end

function var1.willUnmount(arg1)
    arg1:stopAnimation()
end

return var1

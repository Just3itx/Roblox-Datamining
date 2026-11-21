-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T06:01:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local React = require(scriptParentParentParent.React)

local BlurDirection = require(scriptParentParent.Enums.BlurDirection)

local function getImageRect(direction, vector2: Vector2)
    local vector2X = vector2.X
    local vector2Y = vector2.Y

    if direction == BlurDirection.Up then
        return Vector2.new(0, 0), Vector2.new(vector2X, 1)
    elseif direction == BlurDirection.Down then
        return Vector2.new(0, vector2Y - 1), Vector2.new(vector2X, 1)
    elseif direction == BlurDirection.Left then
        return Vector2.new(0, 0), Vector2.new(1, vector2Y)
    elseif direction == BlurDirection.Right then
        return Vector2.new(vector2X - 1, 0), Vector2.new(1, vector2Y)
    end

    return nil
end

local function getGradientRotation(direction) -- Luacid: Inlined by compiler; 1 call site recovered
    if direction == BlurDirection.Up then
        return 270
    end

    if direction == BlurDirection.Down then
        return 90
    end

    if direction == BlurDirection.Left then
        return 180
    end

    if direction == BlurDirection.Right then
        return 0
    end

    return nil
end

local function getRadialGradientPosition(direction)
    if direction == BlurDirection.Up then
        return UDim2.fromScale(0.5, 1)
    elseif direction == BlurDirection.Down then
        return UDim2.fromScale(0.5, 0)
    elseif direction == BlurDirection.Left then
        return UDim2.fromScale(1, 0.5)
    elseif direction == BlurDirection.Right then
        return UDim2.fromScale(0, 0.5)
    end

    return nil
end

local function getTransparency(num1: number, transparencyBinding)
    if not transparencyBinding then
        return num1
    end

    return transparencyBinding:map(function(arg1)
        return num1 + (1 - num1) * arg1
    end)
end

local function ImageBlurEffect(tbl1)
    local color = if tbl1.gradientColor then tbl1.gradientColor else Color3.new(0, 0, 0)
    local imageRectOffset, imageRectSize = getImageRect(tbl1.direction, tbl1.imageSize)
    local radialGradientPosition = getRadialGradientPosition(tbl1.direction)

    local imageTransparency = React.useMemo(function()
        return getTransparency(0, tbl1.transparencyBinding)
    end, { tbl1.transparencyBinding })

    local var1 = React.useMemo(function()
        return getTransparency(0.9, tbl1.transparencyBinding)
    end, { tbl1.transparencyBinding })

    local var2 = React.useMemo(function()
        return getTransparency(0.8, tbl1.transparencyBinding)
    end, { tbl1.transparencyBinding })

    return React.createElement("ImageLabel", {
        AnchorPoint = tbl1.AnchorPoint,
        BackgroundTransparency = 1,
        ClipsDescendants = true,
        Image = tbl1.image,
        ImageRectOffset = imageRectOffset,
        ImageRectSize = imageRectSize,
        ImageTransparency = imageTransparency,
        Position = tbl1.Position,
        ScaleType = Enum.ScaleType.Crop,
        Size = tbl1.Size,
        ZIndex = tbl1.ZIndex
    }, {
        UIGradient = React.createElement("UIGradient", {
            Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)), ColorSequenceKeypoint.new(1, color) }),
            Rotation = getGradientRotation(tbl1.direction),
            Transparency = NumberSequence.new(
                { NumberSequenceKeypoint.new(0, 0.3), NumberSequenceKeypoint.new(0.5, 0.5), NumberSequenceKeypoint.new(1, 1) }
            )
        }),
        RadialBlur = React.createElement("ImageLabel", {
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundTransparency = 1,
            Image = "rbxasset://textures/shadowblurmask.png",
            ImageTransparency = var1,
            Position = radialGradientPosition,
            ScaleType = Enum.ScaleType.Crop,
            Size = UDim2.fromScale(2, 2),
            ZIndex = 1
        }),
        SoftEdges = React.createElement("ImageLabel", {
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundTransparency = 1,
            Image = "rbxasset://textures/ui/VR/edgeBlur.png",
            ImageTransparency = var2,
            Position = radialGradientPosition,
            ScaleType = Enum.ScaleType.Crop,
            Size = UDim2.fromScale(1.5, 2),
            ZIndex = 2
        })
    })
end

return ImageBlurEffect

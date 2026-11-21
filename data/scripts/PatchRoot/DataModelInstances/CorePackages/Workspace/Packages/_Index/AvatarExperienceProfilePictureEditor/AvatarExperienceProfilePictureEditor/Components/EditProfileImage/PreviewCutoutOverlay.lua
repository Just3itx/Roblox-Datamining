-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:40:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceProfilePictureEditor = script:FindFirstAncestor("AvatarExperienceProfilePictureEditor")
local AvatarExperienceProfilePictureEditorParent = AvatarExperienceProfilePictureEditor.Parent

local React = require(AvatarExperienceProfilePictureEditorParent.React)
local Foundation = require(AvatarExperienceProfilePictureEditorParent.Foundation)

local Constants = require(AvatarExperienceProfilePictureEditor.Constants)

local useTokens = Foundation.Hooks.useTokens

local function createCompositionGridLine(tbl1) -- Luacid: Inlined by compiler; 4 call sites recovered
    return React.createElement("Frame", {
        Size = tbl1.size,
        Position = tbl1.position,
        AnchorPoint = tbl1.anchorPoint,
        BackgroundColor3 = tbl1.color,
        BackgroundTransparency = tbl1.transparency,
        BorderSizePixel = 0,
        Active = false
    })
end

local function buildCompositionGridChildren(num1: number, color3: Color3, transparency: number)
    local vector2 = Vector2.new(0.5, 0)
    local vector2_2 = Vector2.new(0, 0.5)
    local uDim2 = UDim2.new(0, num1, 1, 0)
    local uDim2_2 = UDim2.new(1, 0, 0, num1)
    return {
        VerticalLine1 = createCompositionGridLine({
            size = uDim2,
            position = UDim2.fromScale(1 / 3, 0),
            anchorPoint = vector2,
            color = color3,
            transparency = transparency
        }),
        VerticalLine2 = createCompositionGridLine({
            size = uDim2,
            position = UDim2.fromScale(2 / 3, 0),
            anchorPoint = vector2,
            color = color3,
            transparency = transparency
        }),
        HorizontalLine1 = createCompositionGridLine({
            size = uDim2_2,
            position = UDim2.fromScale(0, 1 / 3),
            anchorPoint = vector2_2,
            color = color3,
            transparency = transparency
        }),
        HorizontalLine2 = createCompositionGridLine({
            size = uDim2_2,
            position = UDim2.fromScale(0, 2 / 3),
            anchorPoint = vector2_2,
            color = color3,
            transparency = transparency
        })
    }
end

local function PreviewCutoutOverlay(tbl1)
    local var1 = useTokens()
    local xOffset = math.max(0, math.floor((tbl1.width - tbl1.cutoutSize) / 2 + 0.5))
    local yOffset = math.max(0, tbl1.height - tbl1.cutoutTopOffset - tbl1.cutoutSize)
    local overMedia100 = var1.Color.OverMedia.OverMedia_100
    local color3 = overMedia100.Color3
    local overMedia100Transparency = overMedia100.Transparency or 0.35
    local emphasis = var1.Color.Stroke.Emphasis
    local color3_2 = emphasis.Color3
    local emphasisTransparency = emphasis.Transparency or 0.84
    local thickness = math.max(1, math.floor(var1.Stroke.Standard + 0.5))
    local num2 = math.floor(tbl1.cutoutSize * Constants.CircleCutoutHoleDiameterFraction + 0.5)
    local num3 = math.max(0, math.floor((tbl1.cutoutSize - num2) / 2 + 0.5))
    local xOffset2 = xOffset + num3
    local yOffset2 = tbl1.cutoutTopOffset + num3
    local xOffset3 = xOffset + tbl1.cutoutSize * 0.5
    local yOffset3 = tbl1.cutoutTopOffset + tbl1.cutoutSize * 0.5
    local num4 = math.max(1, num2 - thickness)

    local createElement = React.createElement
    local fragment = React.Fragment
    local var2 = nil
    local tbl2 = {
        DimTop = React.createElement("Frame", {
            Size = UDim2.new(1, 0, 0, tbl1.cutoutTopOffset),
            BackgroundColor3 = color3,
            BackgroundTransparency = overMedia100Transparency,
            BorderSizePixel = 0,
            Active = false,
            ZIndex = 2
        }),
        DimLeft = React.createElement("Frame", {
            Size = UDim2.fromOffset(xOffset, tbl1.cutoutSize),
            Position = UDim2.fromOffset(0, tbl1.cutoutTopOffset),
            BackgroundColor3 = color3,
            BackgroundTransparency = overMedia100Transparency,
            BorderSizePixel = 0,
            Active = false,
            ZIndex = 2
        }),
        DimRight = React.createElement("Frame", {
            Size = UDim2.fromOffset(xOffset, tbl1.cutoutSize),
            Position = UDim2.fromOffset(xOffset + tbl1.cutoutSize, tbl1.cutoutTopOffset),
            BackgroundColor3 = color3,
            BackgroundTransparency = overMedia100Transparency,
            BorderSizePixel = 0,
            Active = false,
            ZIndex = 2
        }),
        DimBottom = React.createElement("Frame", {
            Size = UDim2.new(1, 0, 0, yOffset),
            Position = UDim2.fromOffset(0, tbl1.cutoutTopOffset + tbl1.cutoutSize),
            BackgroundColor3 = color3,
            BackgroundTransparency = overMedia100Transparency,
            BorderSizePixel = 0,
            Active = false,
            ZIndex = 2
        }),
        CompositionGrid = React.createElement(
            "Frame",
            {
                Size = UDim2.fromOffset(num2, num2),
                Position = UDim2.fromOffset(xOffset2, yOffset2),
                BackgroundTransparency = 1,
                Active = false,
                ZIndex = 2
            },
            (buildCompositionGridChildren(thickness, color3_2, emphasisTransparency))
        ),
        Cutout = React.createElement("ImageLabel", {
            Image = Constants.CircleCutoutAsset,
            ImageColor3 = color3,
            ImageTransparency = overMedia100Transparency,
            Size = UDim2.fromOffset(tbl1.cutoutSize, tbl1.cutoutSize),
            Position = UDim2.fromOffset(xOffset, tbl1.cutoutTopOffset),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Active = false,
            ZIndex = 3
        }),
        CutoutBorder = React.createElement("Frame", {
            Size = UDim2.fromOffset(num4, num4),
            Position = UDim2.fromOffset(xOffset3, yOffset3),
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Active = false,
            ZIndex = 4
        }, {
            UICorner = React.createElement("UICorner", { CornerRadius = UDim.new(0.5, 0) }),
            UIStroke = React.createElement("UIStroke", {
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                Color = color3_2,
                Transparency = emphasisTransparency,
                Thickness = thickness
            })
        }),
        ProfileFrame = 0
    }
    local element

    if tbl1.frameImage then
        element = React.createElement("ImageLabel", {
            Image = tbl1.frameImage,
            Size = UDim2.fromOffset(num2, num2),
            Position = UDim2.fromOffset(xOffset3, yOffset3),
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            ScaleType = Enum.ScaleType.Fit,
            Active = false,
            ZIndex = 5
        })
    else
        element = nil
    end

    tbl2.ProfileFrame = element
    return createElement(fragment, var2, tbl2)
end

return PreviewCutoutOverlay

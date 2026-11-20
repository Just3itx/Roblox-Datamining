-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T06:31:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local FoundationImages = require(FoundationParent.FoundationImages)
local React = require(FoundationParent.React)

local Images = FoundationImages.Images
local CursorComponent = require(script.Parent.Parent.CursorComponent)
local CursorType = require(Foundation.Enums.CursorType)

local _ColorNamespace = require(Foundation.Enums.ColorNamespace)

local useTokens = require(Foundation.Providers.Style.useTokens)

local Components = script.Parent.Parent.Parent.Parent.Components
local getScaledSlice = require(Components.Image.ImageSet.getScaledSlice)

local tbl1 = {
    [CursorType.BulletUp] = {
        Tag = "SlicedImage",
        Image = "component_assets/bulletUp_17_stroke_3",
        SliceCenter = Rect.new(8, 8, 9, 9),
        InsetAdjustment = Vector2.new(2, 2)
    },
    [CursorType.BulletDown] = {
        Tag = "SlicedImage",
        Image = "component_assets/bulletDown_17_stroke_3",
        SliceCenter = Rect.new(8, 8, 9, 9),
        InsetAdjustment = Vector2.new(2, 2)
    },
    [CursorType.InputFields] = {
        Tag = "SlicedImage",
        Image = "component_assets/circle_22_stroke_3",
        SliceCenter = Rect.new(11, 11, 12, 12),
        InsetAdjustment = Vector2.new(7, 0)
    },
    [CursorType.SelectionCell] = {
        Tag = "SlicedImage",
        Image = "component_assets/square_7_stroke_3",
        SliceCenter = Rect.new(3.5, 3.5, 3.5, 3.5),
        InsetAdjustment = Vector2.new(2, 2),
        Padding = 50
    },
    [CursorType.SelectedKnob] = {
        Tag = "FixedSizeImage",
        Image = "component_assets/circle_42_stroke_3",
        Size = 42
    },
    [CursorType.UnselectedKnob] = {
        Tag = "FixedSizeImage",
        Image = "component_assets/circle_52_stroke_3",
        Size = 52
    },
    [CursorType.InputButton] = {
        Tag = "RoundedImage",
        CornerRadius = UDim.new(0, 11),
        Offset = 11,
        BorderWidth = 3
    },
    [CursorType.RoundedRect] = {
        Tag = "RoundedImage",
        CornerRadius = UDim.new(0, 8),
        Offset = 9,
        BorderWidth = 3
    },
    [CursorType.RoundedRectNoInset] = {
        Tag = "RoundedImage",
        CornerRadius = UDim.new(0, 8),
        Offset = 0,
        BorderWidth = 3
    },
    [CursorType.RoundedSlot] = {
        Tag = "RoundedImage",
        CornerRadius = UDim.new(0, 7),
        Offset = 0,
        BorderWidth = 3
    },
    [CursorType.SkinToneCircle] = {
        Tag = "RoundedImage",
        CornerRadius = UDim.new(0.5, 0),
        Offset = 0,
        BorderWidth = 3
    },
    [CursorType.SmallPill] = {
        Tag = "RoundedImage",
        CornerRadius = UDim.new(0, 15),
        Offset = 0,
        BorderWidth = 3
    },
    [CursorType.LargePill] = {
        Tag = "RoundedImage",
        CornerRadius = UDim.new(0, 26),
        Offset = 0,
        BorderWidth = 3
    },
    [CursorType.Square] = {
        Tag = "RoundedImage",
        CornerRadius = UDim.new(0, 0),
        Offset = 2,
        BorderWidth = 3
    },
    [CursorType.Toggle] = {
        Tag = "RoundedImage",
        CornerRadius = UDim.new(0, 13),
        Offset = 0,
        BorderWidth = 3
    }
}

return (React.forwardRef(function(tbl2, ref)
    local var1 = useTokens()
    local colorNamespace = tbl2.colorNamespace
    if tbl2.cursorType == CursorType.NavHighlight then
        return React.createElement("Frame", {
            AnchorPoint = Vector2.new(0, 1),
            Position = UDim2.new(0, 0, 1, -3),
            Size = UDim2.new(1, 0, 0, 3),
            BorderSizePixel = 1,
            BackgroundColor3 = var1[colorNamespace].Selection.Start.Color3,
            BackgroundTransparency = 0,
            BorderColor3 = var1[colorNamespace].Selection.Start.Color3,
            ref = ref
        })
    elseif tbl2.cursorType == CursorType.Invisible then
        return React.createElement("Frame", { BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), ref = ref })
    else
        local var2 = tbl1[tbl2.cursorType]

        if var2.Tag == "FixedSizeImage" then
            local uDim2 = UDim2.fromOffset(var2.Size, var2.Size)
            local uDim2_2 = UDim2.new(0.5, -uDim2.X.Offset / 2, 0.5, -uDim2.Y.Offset / 2)

            return React.createElement("ImageLabel", {
                Image = Images[var2.Image].Image,
                BackgroundTransparency = 1,
                ImageRectOffset = Images[var2.Image].ImageRectOffset,
                ImageRectSize = Images[var2.Image].ImageRectSize,
                Size = uDim2,
                Position = uDim2_2,
                ImageColor3 = var1[colorNamespace].Selection.Start.Color3,
                ImageTransparency = var1[colorNamespace].Selection.Start.Transparency,
                ref = ref
            })
        elseif var2.Tag == "SlicedImage" then
            local insetAdjustment = var2.InsetAdjustment
            local uDim2 = UDim2.new(1, insetAdjustment.X * 2, 1, insetAdjustment.Y * 2)
            local scaledSlice = getScaledSlice(var2.SliceCenter)
            local padding = if var2.Padding then React.createElement("UIPadding", {
                PaddingTop = UDim.new(0, var2.Padding),
                PaddingBottom = UDim.new(0, var2.Padding),
                PaddingLeft = UDim.new(0, var2.Padding),
                PaddingRight = UDim.new(0, var2.Padding)
            }) else nil
            return React.createElement("ImageLabel", {
                Image = Images[var2.Image].Image,
                BackgroundTransparency = 1,
                ImageRectOffset = Images[var2.Image].ImageRectOffset,
                ImageRectSize = Images[var2.Image].ImageRectSize,
                SliceCenter = scaledSlice.center,
                SliceScale = scaledSlice.scale,
                ScaleType = Enum.ScaleType.Slice,
                Size = uDim2,
                Position = UDim2.fromOffset(-insetAdjustment.X, -insetAdjustment.Y),
                ImageColor3 = var1[colorNamespace].Selection.Start.Color3,
                ImageTransparency = var1[colorNamespace].Selection.Start.Transparency,
                ref = ref
            }, { Padding = padding })
        elseif var2.Tag == "RoundedImage" then
            return React.createElement(CursorComponent, {
                isVisible = tbl2.isVisible,
                cornerRadius = var2.CornerRadius,
                offset = var2.Offset - var2.BorderWidth,
                borderWidth = var2.BorderWidth,
                colorNamespace = tbl2.colorNamespace,
                ref = ref
            })
        else
            return nil
        end
    end
end))

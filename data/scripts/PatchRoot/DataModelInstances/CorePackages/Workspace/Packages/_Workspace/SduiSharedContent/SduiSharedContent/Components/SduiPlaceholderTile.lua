-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:01:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedContentParent = script:FindFirstAncestor("SduiSharedContent").Parent

local React = require(SduiSharedContentParent.React)
local useTokens = require(SduiSharedContentParent.Foundation).Hooks.useTokens
local _SduiCompat = require(SduiSharedContentParent.SduiCompat)

local SduiPlaceholder = require(script.Parent.SduiPlaceholder)

return React.memo(function(tbl1) -- name: SduiPlaceholderTile
    local var1 = useTokens()
    local scale = var1.Config.UI.Scale

    local aspectRatio = if tbl1.imageAspectRatio and tbl1.imageAspectRatio > 0 then tbl1.imageAspectRatio else 1

    local offset = tbl1.lineGap or var1.Gap.XSmall
    local yOffset = (tbl1.lineHeight or 8) * scale

    local num1 = math.max(tbl1.titleLineCount or 1, 0)
    local xScale = math.clamp(tbl1.titleLineWidthFraction or 0.7, 0, 1)

    local xScale2 = math.clamp(tbl1.subtitleLineWidthFraction or 0.55, 0, 1)

    local tbl2 = {
        UIListLayout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, offset)
        })
    }

    for layoutOrder = 1, num1 do
        local str1 = `TitleLine{layoutOrder}`
        tbl2[str1] = React.createElement(SduiPlaceholder, {
            backgroundStyle = tbl1.backgroundStyle,
            cornerRadius = tbl1.cornerRadius,
            layoutOrder = layoutOrder,
            size = UDim2.new(xScale, 0, 0, yOffset),
            transparencyBinding = tbl1.transparencyBinding
        })
    end

    if tbl1.showSubtitle then
        tbl2.SubtitleLine = React.createElement(SduiPlaceholder, {
            backgroundStyle = tbl1.backgroundStyle,
            cornerRadius = tbl1.cornerRadius,
            layoutOrder = num1 + 1,
            size = UDim2.new(xScale2, 0, 0, yOffset),
            transparencyBinding = tbl1.transparencyBinding
        })
    end

    return React.createElement("Frame", {
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        LayoutOrder = tbl1.layoutOrder,
        Position = tbl1.position,
        Size = tbl1.size or UDim2.fromScale(1, 1),
        ZIndex = tbl1.zIndex
    }, {
        UIListLayout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, var1.Gap.Medium)
        }),
        ImageWrapper = React.createElement("Frame", {
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            LayoutOrder = 1,
            Size = UDim2.new(1, 0, 1 / aspectRatio, 0),
            SizeConstraint = Enum.SizeConstraint.RelativeXX
        }, {
            UIAspectRatioConstraint = React.createElement("UIAspectRatioConstraint", { AspectRatio = aspectRatio }),
            ImagePlaceholder = React.createElement(SduiPlaceholder, {
                backgroundStyle = tbl1.backgroundStyle,
                cornerRadius = tbl1.imageCornerRadius,
                size = UDim2.fromScale(1, 1),
                transparencyBinding = tbl1.transparencyBinding
            })
        }),
        LineContainer = React.createElement("Frame", {
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            LayoutOrder = 2,
            Size = UDim2.fromScale(1, 0)
        }, tbl2)
    })
end)

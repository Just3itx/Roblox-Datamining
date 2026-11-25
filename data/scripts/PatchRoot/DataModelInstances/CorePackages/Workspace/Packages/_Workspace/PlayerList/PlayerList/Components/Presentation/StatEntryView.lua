-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T03:04:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local React = require(scriptParentParentParentParent.React)
local UIBlox = require(scriptParentParentParentParent.UIBlox)
local Foundation = require(scriptParentParentParentParent.Foundation)
local normalizeFontFace = Foundation.Utility.normalizeFontFace
local useTokens = Foundation.Hooks.useTokens
local FFlagFontFacePlayerList = require(scriptParentParentParentParent.SharedFlags).FFlagFontFacePlayerList
local FormatStatString = require(scriptParentParentParent.Common.FormatStatString)
local useStyle = UIBlox.Core.Style.useStyle
local useLayoutValues = require(scriptParentParentParent.Common.useLayoutValues)

local FFlagRemoveNewPlayerListOverlay = require(scriptParentParentParent.Flags.FFlagRemoveNewPlayerListOverlay)
local FFlagEnableMobilePlayerListOnConsole = require(scriptParentParentParent.Flags.FFlagEnableMobilePlayerListOnConsole)

return React.memo(function(tbl1)
    local var1 = useStyle()
    local var2 = useLayoutValues()
    local var3 = if FFlagFontFacePlayerList then useTokens() else nil
    local textDefault = var1.Theme.TextDefault
    local textStyle = tbl1.textStyle
    local color = if textStyle then textStyle.Color else textDefault.Color
    local transparency = if textStyle then textStyle.Transparency else textDefault.Transparency
    local strokeColor = if textStyle then textStyle.StrokeColor else nil
    local strokeTransparency = if textStyle and textStyle.StrokeTransparency then textStyle.StrokeTransparency else nil
    local var4, var5

    if not var2.IsTenFoot then
        if FFlagFontFacePlayerList then
            var4 = normalizeFontFace(var3.Typography.CaptionLarge.Font)
        else
            var4 = var1.Font.CaptionHeader.Font
        end

        if FFlagEnableMobilePlayerListOnConsole then
            var5 = var2.StatTextSize
        else
            var5 = var1.Font.CaptionHeader.RelativeSize * var1.Font.BaseSize
        end
    else
        var5 = var2.StatTextSize
        if FFlagFontFacePlayerList then
            var4 = normalizeFontFace(var2.StatFont)
        else
            var4 = var2.StatFont
        end

        if tbl1.isTeamEntry then
            if FFlagFontFacePlayerList then
                var4 = normalizeFontFace(var2.TeamStatFont)
            else
                var4 = var2.TeamStatFont
            end
        end
    end
    local var6 = React.useMemo(function()
        return {
            Text = tbl1.statValue:map(function(arg1)
                return FormatStatString(arg1)
            end),
            Size = tbl1.showStatTitle and UDim2.fromScale(1, 0.5) or UDim2.fromScale(1, 1),
            Position = tbl1.showStatTitle and UDim2.fromScale(0, 0.5) or UDim2.fromScale(0, 0),
            Font = if FFlagFontFacePlayerList then nil else var4,
            FontFace = if FFlagFontFacePlayerList then var4 else nil,
            TextSize = var5,
            TextColor3 = color,
            TextTransparency = transparency,
            TextStrokeColor3 = strokeColor,
            TextStrokeTransparency = strokeTransparency,
            TextTruncate = Enum.TextTruncate.AtEnd,
            BackgroundTransparency = 1
        }
    end, {
        tbl1.showStatTitle,
        var4,
        var5,
        color,
        transparency,
        strokeColor,
        strokeTransparency
    })

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        Size = UDim2.new(0, var2.StatEntrySizeX, 1, 0),
        Position = UDim2.new(0, 0, 0, 0),
        BorderSizePixel = 0,
        LayoutOrder = tbl1.layoutOrder,
        BackgroundTransparency = if tbl1.backgroundStyle then tbl1.backgroundStyle.Transparency else 1,
        BackgroundColor3 = if tbl1.backgroundStyle then tbl1.backgroundStyle.Color else nil
    }
    local tbl3 = { PlayerStatDisplay = 0, DoubleOverLay = 0, OverlayFrame = 0 }
    local element

    if tbl1.showStatTitle and tbl1.statName then
        local createElement2 = React.createElement
        local str2 = "Frame"
        local tbl4 = {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            BorderSizePixel = 0
        }

        local tbl5 = {
            StatTitle = React.createElement("TextLabel", {
                Text = tbl1.statName,
                Size = UDim2.fromScale(1, 0.5),
                Position = UDim2.fromScale(0, 0),
                Font = if FFlagFontFacePlayerList then nil else var2.TitleStatFont,
                FontFace = if FFlagFontFacePlayerList then normalizeFontFace(var2.TitleStatFont) else nil,
                TextSize = var5,
                TextColor3 = color,
                TextTransparency = transparency,
                TextStrokeColor3 = strokeColor,
                TextStrokeTransparency = strokeTransparency,
                TextTruncate = Enum.TextTruncate.AtEnd,
                BackgroundTransparency = 1
            }),
            StatText = React.createElement("TextLabel", var6)
        }
        element = createElement2(str2, tbl4, tbl5)
    else
        element = React.createElement("TextLabel", var6)
    end

    tbl3.PlayerStatDisplay = element

    tbl3.DoubleOverLay = if FFlagRemoveNewPlayerListOverlay or not (tbl1.doubleOverlay and tbl1.overlayStyle) then nil else React.createElement(
        "Frame",
        {
            ZIndex = 1,
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = tbl1.overlayStyle.Transparency,
            BackgroundColor3 = tbl1.overlayStyle.Color,
            BorderSizePixel = 0
        }
    )

    tbl3.OverlayFrame = if FFlagRemoveNewPlayerListOverlay or not tbl1.overlayStyle then nil else React.createElement(
        "Frame",
        {
            ZIndex = 2,
            Size = UDim2.new(1, 0, 1, 0),
            BorderSizePixel = 0,
            BackgroundTransparency = tbl1.overlayStyle.Transparency,
            BackgroundColor3 = tbl1.overlayStyle.Color
        }
    )
    return createElement(str1, tbl2, tbl3)
end)

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:40:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local App = script:FindFirstAncestor("App")
local AppParent = App.Parent
local AppParentParent = AppParent.Parent

local React = require(AppParentParent.React)
local _ImagesTypes = require(App.ImageSet.ImagesTypes)
local IconSize = require(App.ImageSet.Enum.IconSize)
local getIconSize = require(App.ImageSet.getIconSize)
local StatWidget = require(App.Indicator.StatWidget)
local _Fonts = require(App.Style.Fonts)
local useStyle = require(AppParent.Core.Style.useStyle)
local GetTextSize = require(AppParent.Core.Text.GetTextSize)
local GetFontFromFontStyle = require(AppParent.Core.Text.GetFontFromFontStyle)
local UIBloxConfig = require(AppParent.UIBloxConfig)
local _StyleTypes = require(AppParent.App.Style.StyleTypes)

local iconSize = getIconSize(IconSize.Large)

local function getTextWidth(arg1, arg2, arg3) -- Luacid: Inlined by compiler; 6 call sites recovered
    local baseSize = arg3.Font.BaseSize
    local var1 = arg2.RelativeSize * baseSize
    local vector2 = Vector2.new(10000, 10000)
    local fontFromFontStyle = GetFontFromFontStyle(arg2)
    return GetTextSize(arg1, var1, fontFromFontStyle, vector2).X
end

local function getMeasuredSectionWidth(arg1, arg2): number -- Luacid: Inlined by compiler; 2 call sites recovered
    local var1 = if UIBloxConfig.enableScalingForSomeEdpIcons then getIconSize(IconSize.Large, arg2) else iconSize
    return math.max(
        getTextWidth(arg1.countText, arg2.Font.Title, arg2),
        (getTextWidth(arg1.labelText, arg2.Font.CaptionHeader, arg2))
    ) + var1 + 12
end

local function PlayerCount(tbl1)
    local var1 = useStyle()

    local measuredSectionWidth = getMeasuredSectionWidth(tbl1.countLeft, var1)
    local xScale = measuredSectionWidth / (measuredSectionWidth + getMeasuredSectionWidth(tbl1.countRight, var1))
    local xScale2 = 1 - xScale

    local countLeft = tbl1.countLeft
    local countRight = tbl1.countRight

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        LayoutOrder = tbl1.layoutOrder,
        AutomaticSize = Enum.AutomaticSize.Y
    }
    local tbl3 = { LeftSection = 0, RightSection = 0 }
    local createElement2 = React.createElement
    local var2 = StatWidget
    local tbl4 = {
        countText = countLeft.countText,
        labelText = countLeft.labelText,
        icon = countLeft.icon,
        layoutOrder = 1,
        position = UDim2.new(0, 0, 0, 0),
        anchorPoint = Vector2.new(0, 0),
        size = UDim2.new(xScale, 0, 1, 0),
        horizontalAlignment = Enum.HorizontalAlignment.Left,
        styleProps = 0
    }
    local tbl5

    if UIBloxConfig.enableScalingForSomeEdpIcons then
        tbl5 = { iconSize = 0 }
        local iconSize2 = getIconSize(IconSize.Large, var1)
        tbl5.iconSize = math.floor(iconSize2)
    else
        tbl5 = nil
    end

    tbl4.styleProps = tbl5
    tbl3.LeftSection = createElement2(var2, tbl4)

    local createElement3 = React.createElement
    local var3 = StatWidget
    local tbl6 = {
        countText = countRight.countText,
        labelText = countRight.labelText,
        icon = countRight.icon,
        layoutOrder = 2,
        position = UDim2.new(1, 0, 0, 0),
        anchorPoint = Vector2.new(1, 0),
        size = UDim2.new(xScale2, 0, 1, 0),
        horizontalAlignment = Enum.HorizontalAlignment.Right,
        styleProps = 0
    }
    local tbl7

    if UIBloxConfig.enableScalingForSomeEdpIcons then
        tbl7 = { iconSize = 0 }
        local iconSize2 = getIconSize(IconSize.Large, var1)
        tbl7.iconSize = math.floor(iconSize2)
    else
        tbl7 = nil
    end

    tbl6.styleProps = tbl7
    tbl3.RightSection = createElement3(var3, tbl6)
    return createElement(str1, tbl2, tbl3)
end

return PlayerCount

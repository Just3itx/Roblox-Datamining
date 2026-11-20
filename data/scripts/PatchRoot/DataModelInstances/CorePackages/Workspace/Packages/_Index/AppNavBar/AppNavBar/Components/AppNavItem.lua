-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T22:50:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local Cryo = require(scriptParentParentParent.Cryo)
local React = require(scriptParentParentParent.React)
local _Foundation = require(scriptParentParentParent.Foundation)
local UIBlox = require(scriptParentParentParent.UIBlox)
local Localization = require(scriptParentParentParent.Localization)
local SharedFlags = require(scriptParentParentParent.SharedFlags)
local Responsive = require(scriptParentParentParent.Responsive)

local usePreferredInput = Responsive.usePreferredInput
local Input = Responsive.Input

local useStyle = UIBlox.Core.Style.useStyle
local ControlState = UIBlox.Core.Control.Enum.ControlState
local NavigationTab = UIBlox.App.Navigation.NavigationTab
local NavigationTabLayout = UIBlox.App.Navigation.Enum.NavigationTabLayout
local useLocalization = Localization.Hooks.useLocalization

local FFlagAppNavLabelScaling = SharedFlags.FFlagAppNavLabelScaling
local FFlagShrinkAppNavBar = SharedFlags.FFlagShrinkAppNavBar
local FFlagEnableNavRailTooltipAndTruncation = SharedFlags.FFlagEnableNavRailTooltipAndTruncation

return React.memo(function(tbl1) -- name: AppNavItem
    local tokens = useStyle().Tokens
    local var1 = useLocalization({ labelText = tbl1.item.labelText })

    local var2, var3 = React.useState(ControlState.Initialize)
    local var4 = if FFlagEnableNavRailTooltipAndTruncation then usePreferredInput() else nil
    local captionSmall = tokens.Typography.CaptionSmall
    local fontSize = if FFlagShrinkAppNavBar then nil else tbl1.systemBarLabelTextSizeBinding.default:getBinding()

    if not FFlagShrinkAppNavBar then
        React.useEffect(function()
            if FFlagAppNavLabelScaling then
                tbl1.systemBarLabelTextSizeBinding.default:setTextToMaxSize(
                    var1.labelText or "",
                    captionSmall.Font,
                    Vector2.new(tokens.Size.Size_1200, tokens.Size.Size_1200),
                    tokens.FontSize.FontSize_300
                )
                return
            end

            tbl1.systemBarLabelTextSizeBinding.default:getMinTextSize(
                var1.labelText or "",
                captionSmall.Font,
                Vector2.new(tokens.Size.Size_1200, tokens.Size.Size_1200)
            )
        end, { fontSize, var1.labelText, tokens })
    end

    local var5 = FFlagEnableNavRailTooltipAndTruncation and var4 == Input.Touch

    return React.createElement(NavigationTab, {
        iconImage = tbl1.item.iconImage,
        iconCheckedImage = tbl1.item.iconCheckedImage,
        renderIcon = tbl1.item.renderIcon and function(bool1: boolean)
            return tbl1.item.renderIcon(bool1, var2)
        end or nil,
        hasLabel = tbl1.hasLabel,
        labelText = var1.labelText,
        labelTypography = not FFlagShrinkAppNavBar
            and {
                Font = captionSmall.Font,
                FontSize = fontSize,
                LineHeight = captionSmall.LineHeight,
                LetterSpacing = captionSmall.LetterSpacing
            }
            or tokens.Typography.CaptionSmall,
        labelMaxTextSize = if var5 then captionSmall.FontSize else nil,
        isChecked = tbl1.isChecked,
        badgeVariant = tbl1.item.badgeVariant,
        badgeValue = tbl1.item.badgeValue,
        layout = NavigationTabLayout.Stacked,
        anchorPoint = if tbl1.isCenterPositioned then Vector2.new(0.5, 0.5) else nil,
        position = if tbl1.isCenterPositioned then UDim2.fromScale(0.5, 0.5) else nil,
        onActivated = tbl1.item.onActivated,
        onStateChanged = tbl1.item.renderIcon and function(_, arg1)
            var3(arg1)
        end or nil,
        width = if FFlagEnableNavRailTooltipAndTruncation then tbl1.width else nil,
        fillWidth = if FFlagEnableNavRailTooltipAndTruncation then tbl1.fillWidth else nil,
        enableTooltip = if FFlagEnableNavRailTooltipAndTruncation then tbl1.enableTooltip else nil,
        tooltipSide = if FFlagEnableNavRailTooltipAndTruncation then tbl1.tooltipSide else nil,
        tooltipAlign = if FFlagEnableNavRailTooltipAndTruncation then tbl1.tooltipAlign else nil,
        tooltipOffset = if FFlagEnableNavRailTooltipAndTruncation then tbl1.tooltipOffset else nil
    })
end, function(tbl1, tbl2) -- name: arePropsEqual
    local bool1 = Cryo.Dictionary.equals(tbl1.item, tbl2.item)

    if bool1 then
        if (FFlagShrinkAppNavBar or tbl1.systemBarLabelTextSizeBinding == tbl2.systemBarLabelTextSizeBinding)
            and tbl1.isChecked == tbl2.isChecked
            and tbl1.isCenterPositioned == tbl2.isCenterPositioned
        then
            bool1 = tbl1.hasLabel == tbl2.hasLabel
        else
            bool1 = false
        end
    end

    if FFlagEnableNavRailTooltipAndTruncation and bool1 then
        if tbl1.width == tbl2.width
            and tbl1.fillWidth == tbl2.fillWidth
            and tbl1.enableTooltip == tbl2.enableTooltip
            and tbl1.tooltipSide == tbl2.tooltipSide
            and tbl1.tooltipAlign == tbl2.tooltipAlign
        then
            bool1 = tbl1.tooltipOffset == tbl2.tooltipOffset
        else
            bool1 = false
        end
    end

    return bool1
end)

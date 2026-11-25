-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:21:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUi = script:FindFirstAncestor("ServerDrivenUi")
local ServerDrivenUiParent = ServerDrivenUi.Parent

local React = require(ServerDrivenUiParent.React)
local combineReactTags = require(ServerDrivenUiParent.RoactUtils).combineReactTags

local UIBlox = require(ServerDrivenUiParent.UIBlox)
local Foundation = require(ServerDrivenUiParent.Foundation)
local useTokens = Foundation.Hooks.useTokens
local View = Foundation.View
local Responsive = require(ServerDrivenUiParent.Responsive)

local TooltipOrientation = UIBlox.App.Dialog.Enum.TooltipOrientation
local IconWithTooltip = require(ServerDrivenUiParent.AppBlox).IconWithTooltip

local SduiTextIconRow = require(ServerDrivenUi.Content.SduiTextIconRow)

local Images = require(ServerDrivenUiParent.FoundationImages).Images
local GetImageData = require(ServerDrivenUiParent.RobloxAppAssets).GetImageData
local FFlagLuaAppEnableSduiHomePage = require(ServerDrivenUiParent.SharedFlags).FFlagLuaAppEnableSduiHomePage

local bool1 = game:DefineFastFlag("AddLayoutOrderToSduiSectionHeaderIconComponent", false)
local bool2 = game:DefineFastFlag("LuaAppSduiSeeAllArrowIconMigration2", false)

return React.memo(function(tbl1) -- name: SduiSectionHeader
    local layoutOrder = tbl1.layoutOrder
    local anchorPoint = tbl1.anchorPoint
    local automaticSize = tbl1.automaticSize
    local size = tbl1.size
    local zIndex = tbl1.zIndex
    local position = tbl1.position

    local var1 = useTokens()

    local fontStyle = tbl1.titleFontStyle or var1.Typography.HeadingSmall
    local var3 = tbl1.titleColor or var1.Color.Content.Emphasis
    local var2 = tbl1.subtitleFontStyle or var1.Typography.BodyMedium
    local var5 = tbl1.subtitleColor or var1.Color.Content.Default

    local offset = tbl1.verticalGap or var1.Gap.XXSmall
    local small = var1.Gap.Small

    local var6 = tbl1.titleGap or var1.Gap.XXSmall
    local var7 = tbl1.titleIconWidth or var1.Size.Size_600

    local bool3 = tbl1.subtitleText ~= nil and tbl1.subtitleText ~= "" or tbl1.subtitleComponent ~= nil
    local onActivated = if tbl1.onSubtitleActivated then tbl1.onSubtitleActivated else tbl1.onTitleActivated
    local gap = tbl1.subtitleGap or var1.Gap.XXSmall
    local iconWidth = tbl1.subtitleIconWidth or var1.Size.Size_400

    local size700 = var1.Size.Size_700

    local var11 = Responsive.usePreferredInput()
    local var12 = tbl1.allowInteractionForDirectionalInput or var11 ~= Responsive.Input.Directional

    local var13 = var12 and (tbl1.infoText ~= nil or tbl1.iconComponent)
    local var14 = var12 and tbl1.onTitleActivated ~= nil
    local selectable = var12 and (var14 or tbl1.onSubtitleActivated ~= nil)
    local var16

    if bool2 then
        var16 = tbl1.titleIcon
        if var16
            and (var16 == GetImageData("LuaApp/icons/GameDetails/navigation/pushRight_small")
                or var16 == Images["icons/navigation/pushRight_small"])
        then
            var16 = Images["icons/actions/cycleRight"]
            var7 = var1.Size.Size_500
            var6 = var1.Gap.XSmall
        end
    else
        var16 = nil
    end

    local var17 = if bool1 and tbl1.iconComponent then React.createElement(View, { tag = "auto-xy", LayoutOrder = 2 }, { IconComponent = tbl1.iconComponent }) else tbl1.iconComponent
    local var18 = if FFlagLuaAppEnableSduiHomePage then combineReactTags(tbl1.tag, if tbl1.testId then `data-testid={tbl1.testId}` else nil) else nil
    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        Position = position,
        AnchorPoint = anchorPoint,
        AutomaticSize = automaticSize or Enum.AutomaticSize.Y,
        Size = size or UDim2.new(1, 0, 0, 0),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        LayoutOrder = layoutOrder,
        ZIndex = zIndex
    }
    local tag = React.Tag

    if not FFlagLuaAppEnableSduiHomePage then
        if tbl1.testId then
            var18 = `data-testid={tbl1.testId}`
        else
            var18 = nil
        end
    end

    tbl2[tag] = var18

    local tbl3 = {
        UIListLayout = React.createElement("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            FillDirection = Enum.FillDirection.Horizontal,
            Padding = UDim.new(0, small),
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            VerticalAlignment = Enum.VerticalAlignment.Center
        }),
        LeftContentFrame = 0,
        IconWithTooltip = 0
    }
    local createElement2 = React.createElement
    local str2 = if var14 then "TextButton" else "Frame"
    local tbl4 = {
        LayoutOrder = 1,
        Text = if var14 then "" else nil,
        TextTransparency = if var14 then 1 else nil,
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        AutoButtonColor = not var14 and nil,
        [React.Event.Activated] = if var14 then tbl1.onTitleActivated else nil,
        Active = var14,
        Selectable = var14
    }
    local tbl5 = {
        UIFlexItem = React.createElement("UIFlexItem", { FlexMode = Enum.UIFlexMode.Shrink }),
        UIListLayout = React.createElement("UIListLayout", {
            HorizontalFlex = Enum.UIFlexAlignment.Fill,
            SortOrder = Enum.SortOrder.Name,
            FillDirection = Enum.FillDirection.Vertical,
            Padding = UDim.new(0, offset),
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            VerticalAlignment = Enum.VerticalAlignment.Center
        }),
        ContentRow1 = 0,
        ContentRow2 = 0
    }

    local titleComponent = tbl1.titleComponent

    if not titleComponent then
        local createElement3 = React.createElement
        local var19 = SduiTextIconRow
        local tbl6 = {
            gap = var6,
            text = tbl1.titleText,
            fontStyle = fontStyle,
            textColor = var3.Color3,
            textFlexMode = Enum.UIFlexMode.Shrink,
            icon = 0,
            iconWidth = 0,
            iconColor = 0,
            selectable = 0,
            testId = "--sdui-section-header-title"
        }

        if var12 then
            if not bool2 then
                var16 = tbl1.titleIcon
            end
        else
            var16 = nil
        end

        tbl6.icon = var16

        tbl6.iconWidth = var7
        tbl6.iconColor = var3.Color3
        tbl6.selectable = var14
        titleComponent = createElement3(var19, tbl6) or nil
    end

    tbl5.ContentRow1 = titleComponent

    local subtitleComponent = tbl1.subtitleComponent

    if not subtitleComponent then
        if bool3 then
            subtitleComponent = React.createElement(SduiTextIconRow, {
                onActivated = onActivated,
                gap = gap,
                text = tbl1.subtitleText,
                fontStyle = var2,
                textColor = var5.Color3,
                textFlexMode = Enum.UIFlexMode.Shrink,
                icon = if var12 then tbl1.subtitleIcon else nil,
                iconWidth = iconWidth,
                iconColor = var5.Color3,
                selectable = selectable,
                testId = "--sdui-section-header-subtitle"
            })
                or nil
        else
            subtitleComponent = nil
        end
    end

    tbl5.ContentRow2 = subtitleComponent
    tbl3.LeftContentFrame = createElement2(str2, tbl4, tbl5)

    if not var17 then
        if var13 and tbl1.infoText then
            var17 = React.createElement(IconWithTooltip, {
                layoutOrder = 2,
                tooltipOrientation = TooltipOrientation.Bottom,
                hoverText = tbl1.infoText,
                triggerPointName = "IconWithTooltip",
                onActivateTooltip = tbl1.onInfoIconActivated,
                supportVR = true,
                supportTenFootUi = true,
                size = UDim2.new(0, size700, 0, size700),
                position = if bool3 then UDim2.new(1, 0, 0, 0) else UDim2.new(1, 0, 0.5, 0),
                anchorPoint = if bool3 then Vector2.new(1, 0) else Vector2.new(1, 0.5)
            })
                or nil
        else
            var17 = nil
        end
    end

    tbl3.IconWithTooltip = var17
    return createElement(str1, tbl2, tbl3)
end)

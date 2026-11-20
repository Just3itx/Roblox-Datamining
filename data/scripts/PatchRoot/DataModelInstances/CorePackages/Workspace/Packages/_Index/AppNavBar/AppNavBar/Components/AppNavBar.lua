-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T22:50:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local React = require(scriptParentParentParent.React)
local Cryo = require(scriptParentParentParent.Cryo)
local Foundation = require(scriptParentParentParent.Foundation)
local UIBlox = require(scriptParentParentParent.UIBlox)
local useAppPolicy = require(scriptParentParentParent.UniversalAppPolicy).useAppPolicy
local useRoactService = require(scriptParentParentParent.RobloxAppHooks).useRoactService
local RoactServiceTags = require(scriptParentParentParent.RoactServiceTags)

local useTokens = Foundation.Hooks.useTokens
local PopoverAlign = Foundation.Enums.PopoverAlign
local PopoverSide = Foundation.Enums.PopoverSide

local NavigationBar = UIBlox.App.Navigation.NavigationBar
local NavigationRailV2 = UIBlox.App.Navigation.NavigationRailV2
local NavigationBarAlignment = UIBlox.App.Navigation.Enum.NavigationBarAlignment
local NavigationRailAlignment = UIBlox.App.Navigation.Enum.NavigationRailAlignment

local Placement = require(scriptParentParent.Enum.Placement)
local AppNavItem = require(scriptParentParent.Components.AppNavItem)
local StudioCTAIcon = require(scriptParentParent.Components.StudioCTAIcon)
local Constants = require(scriptParentParent.Constants)
local VisibilityControl = require(scriptParentParent.VisibilityControl)
local getScrollAwayEnabled = require(scriptParentParent.getScrollAwayEnabled)

local AppNavTelemetry = require(scriptParentParent.Telemetry.AppNavTelemetry)
local engineFeature = game:GetEngineFeature("WebViewRedesignEnabled")
local FFlagAddGamepadBumperNavigation = require(scriptParentParentParent.SharedFlags).FFlagAddGamepadBumperNavigation
local FFlagShrinkAppNavBar = require(scriptParentParentParent.SharedFlags).FFlagShrinkAppNavBar
local FFlagEnableFlyoutOnNavRail = require(scriptParentParentParent.SharedFlags).FFlagEnableFlyoutOnNavRail
local FFlagEnableNavRailTooltipAndTruncation = require(scriptParentParentParent.SharedFlags).FFlagEnableNavRailTooltipAndTruncation
local bool1 = game:DefineFastFlag("AppNavBarGateFooterVisibleOnPlacement", false)

local bool2 = game:DefineFastFlag("AppNavBarFooterVisibleWithoutScrollAway", false)

local function addItems(tbl1, tbl2, items, selectedIndex: number) -- Luacid: Inlined by compiler; 1 call site recovered
    return Cryo.List.join(tbl1, items, tbl2), selectedIndex + #tbl1
end

local tbl1 = { selectedIndex = 1, isVisible = true, clipsDescendants = true }

return React.memo(function(tbl2) -- name: AppNavBar
    local var1 = Cryo.Dictionary.join(tbl1, tbl2)
    local var2 = if FFlagEnableNavRailTooltipAndTruncation then useTokens() else nil

    local var3 = useAppPolicy(function(arg1)
        return arg1.getShowStudioCTA()
    end)
    local var4 = useRoactService(RoactServiceTags.AppEventIngestService)
    local var5 = useRoactService(RoactServiceTags.AppLinking)
    local renderIcon = React.useCallback(function(_: boolean, controlState)
        return React.createElement(
            StudioCTAIcon,
            {
                controlState = controlState,
                showTooltip = if engineFeature then tbl2.showTooltip else nil
            }
        )
    end, { if engineFeature then tbl2.showTooltip else nil })
    local onActivated = React.useCallback(function()
        var4:setRBXEventStream(Constants.STUDIO_CTA_EVENT_CONTEXT, Constants.STUDIO_CTA_EVENT_NAME_OPEN)

        local creatorWebNavUrl = var1.buildCreatorWebNavUrl({ utm_content = "side_bar_blue_icon" })
        var5:openURL(creatorWebNavUrl)
    end, { var4, var5, var1.buildCreatorWebNavUrl })

    local var8, var9

    if FFlagEnableFlyoutOnNavRail then
        local tbl3 = {}
        local tbl4 = {}

        if var1.menuItem ~= nil then
            table.insert(tbl3, var1.menuItem)
        end

        if var3 then
            table.insert(tbl4, { isSecondary = true, renderIcon = renderIcon, onActivated = onActivated })
        end

        var8, var9 = addItems(tbl3, tbl4, var1.items, var1.selectedIndex)
    else
        var8 = var1.items
        var9 = var1.selectedIndex

        if var3 then
            var8 = Cryo.List.join(var8)
            table.insert(var8, { isSecondary = true, renderIcon = renderIcon, onActivated = onActivated })
        end
    end

    local element = nil
    local renderItem = React.useCallback(function(arg1, isChecked: boolean)
        return React.createElement(AppNavItem, {
            item = arg1,
            isChecked = isChecked,
            isCenterPositioned = true,
            hasLabel = true,
            systemBarLabelTextSizeBinding = if FFlagShrinkAppNavBar then nil else var1.systemBarLabelTextSizeBinding,
            fillWidth = if FFlagEnableNavRailTooltipAndTruncation then true else nil,
            enableTooltip = not FFlagEnableNavRailTooltipAndTruncation and nil
        })
    end, { var1.systemBarLabelTextSizeBinding })

    local var6 = React.useCallback(function(arg1, isChecked: boolean)
        return React.createElement(AppNavItem, {
            item = arg1,
            isChecked = isChecked,
            isCenterPositioned = false,
            hasLabel = true,
            systemBarLabelTextSizeBinding = if FFlagShrinkAppNavBar then nil else var1.systemBarLabelTextSizeBinding,
            width = if FFlagEnableNavRailTooltipAndTruncation then UDim.new(1, 0) else nil,
            enableTooltip = if FFlagEnableNavRailTooltipAndTruncation then arg1.labelText ~= nil else nil,
            tooltipSide = if FFlagEnableNavRailTooltipAndTruncation then PopoverSide.Right else nil,
            tooltipAlign = if FFlagEnableNavRailTooltipAndTruncation then PopoverAlign.Center else nil
        })
    end, { var1.systemBarLabelTextSizeBinding })

    local footerBinding

    if getScrollAwayEnabled() or bool2 then
        footerBinding = VisibilityControl.getFooterBinding()
        React.useEffect(function()
            local var12 = if bool1 then var1.isVisible and var1.placement == Placement.Bottom else var1.isVisible
            VisibilityControl.setFooterVisible(var12)
        end, { var1.isVisible, if bool1 then var1.placement else nil })
    else
        footerBinding = nil
    end

    React.useEffect(function()
        local var12 = if FFlagEnableFlyoutOnNavRail then var8[var9] else var1.items[var1.selectedIndex]

        if var12 ~= nil and var12.page ~= nil then
            AppNavTelemetry.logSwitchTabEnd(var12.page)
        end
    end, FFlagEnableFlyoutOnNavRail and { var8, var9 } or { var1.items, var1.selectedIndex })

    React.useEffect(function()
        AppNavTelemetry.logVisibilityEnd(var1.isVisible)
    end, { var1.isVisible })
    React.useEffect(function()
        AppNavTelemetry.logPlacement(var1.placement)
    end, { var1.placement })

    if var1.placement == Placement.Bottom then
        element = React.createElement(NavigationBar, {
            alignment = NavigationBarAlignment.EvenlyDistributed,
            items = var8,
            isVisible = var1.isVisible,
            size = var1.size,
            renderItem = renderItem,
            position = var1.position,
            selection = var9,
            clipsDescendants = var1.clipsDescendants,
            animated = true,
            visibility = footerBinding,
            active = true,
            spacing = if FFlagEnableNavRailTooltipAndTruncation then UDim.new(0, var2.Gap.Small) else nil
        })
    elseif var1.placement == Placement.Left then
        element = React.createElement(NavigationRailV2, {
            alignment = NavigationRailAlignment.Justified,
            items = var8,
            renderItem = var6,
            size = var1.size,
            animated = true,
            isVisible = var1.isVisible,
            position = var1.position,
            selection = var9,
            clipsDescendants = var1.clipsDescendants,
            leadingComponent = if FFlagAddGamepadBumperNavigation then var1.leadingComponent else nil,
            trailingComponent = if FFlagAddGamepadBumperNavigation then var1.trailingComponent else nil,
            spacing = if FFlagEnableNavRailTooltipAndTruncation then UDim.new(0, var2.Gap.Small) else nil
        })
    end

    return element
end)

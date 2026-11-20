-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T23:30:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppSplitView = script:FindFirstAncestor("AppSplitView")
local AppSplitViewParent = AppSplitView.Parent

local React = require(AppSplitViewParent.React)
local Foundation = require(AppSplitViewParent.Foundation)

local AppComposition = require(AppSplitViewParent.AppComposition)
local Signals = require(AppSplitViewParent.Signals)
local Display = require(AppSplitViewParent.Display)
local FFlagFixSplitPaneGamepadLayoutJitter = require(AppSplitViewParent.SharedFlags).FFlagFixSplitPaneGamepadLayoutJitter

local PaneResizer = require(AppSplitView.Components.PaneResizer)
local useSplitViewResize = require(AppSplitView.Hooks.useSplitViewResize)
local Enums = require(AppSplitView.Common.Enums)

local SignalsReact = require(AppSplitViewParent.SignalsReact)

local View = Foundation.View
local CompositionStyleSheet = AppComposition.CompositionStyleSheet
local CompositionTags = AppComposition.CompositionTags
local getRegionOverrides = AppComposition.getRegionOverrides
local RegionName = AppComposition.RegionName

local function getPlatformScale(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    local displayStore = Display.GetDisplayStore(arg1)
    if displayStore.getPlatformScale then
        return (displayStore.getPlatformScale(arg1))
    end

    return 1
end

local computed = Signals.createComputed(function(arg1)
    local regionOverrides = if getRegionOverrides and RegionName then getRegionOverrides(RegionName.NavigationRegion) else nil
    return (if regionOverrides and regionOverrides.widthScale then regionOverrides.widthScale else 0) * getPlatformScale(arg1)
end)

local computed2 = Signals.createComputed(function(arg1)
    local regionOverrides = if getRegionOverrides and RegionName then getRegionOverrides(RegionName.SupportRegion) else nil
    local var1 = if regionOverrides and regionOverrides.widthScale then regionOverrides.widthScale else 0

    return Display.GetDisplayStore(arg1).getViewportSize(arg1).X * var1
end)

local backgroundStyle = { Transparency = 1 }

return React.memo(function(tbl2) -- name: SplitView
    local xOffset = SignalsReact.useSignalState(computed)
    local xOffset2 = SignalsReact.useSignalState(computed2)

    local variant = tbl2.variant or Enums.SplitVariant.SplitRight

    if tbl2.navigationPane then
        if tbl2.navigationPane.width ~= nil then
            xOffset = tbl2.navigationPane.width
        end
    else
        xOffset = 0
    end
    if tbl2.supportPane then
        if tbl2.supportPane.width ~= nil then
            xOffset2 = tbl2.supportPane.width
        end
    else
        xOffset2 = 0
    end

    local var2 = tbl2.supportPaneMode or Enums.SupportPaneMode.Normal
    local bool1 = var2 == Enums.SupportPaneMode.Expanded
    local bool2 = var2 == Enums.SupportPaneMode.Collapsed
    local bool3 = var2 == Enums.SupportPaneMode.Collapsing
    local bool4 = bool1 or var2 == Enums.SupportPaneMode.Expanding

    local interactable = not bool1
    local bool6 = not (tbl2.supportPane == nil) and not (bool4 or bool2 or bool3)
    local interactive = bool6
        and not (tbl2.supportPane == nil or tbl2.supportPane.resizable ~= Enums.PaneResizable.Horizontal)
        and tbl2.onSupportPaneWidthChanged ~= nil
    local tbl3 = {
        navWidth = xOffset,
        supportWidth = xOffset2,
        variant = variant,
        hasWidthOverride = not (tbl2.supportPane == nil) and tbl2.supportPane.width ~= nil,
        onSupportPaneWidthChanged = tbl2.onSupportPaneWidthChanged
    }

    local var3 = useSplitViewResize(tbl3)

    local onAbsoluteSizeChanged = React.useCallback(function(arg1)
        if not bool4 then
            var3.onSupportAbsoluteSizeChanged(arg1)
        end
        if tbl2.onSupportRegionRectChanged then
            tbl2.onSupportRegionRectChanged(arg1)
        end
    end, { bool4, var3.onSupportAbsoluteSizeChanged, tbl2.onSupportRegionRectChanged })

    local tag = if bool1 then CompositionTags.ContentRegion.Root elseif bool2 then CompositionTags.SupportRegion.Collapsed or CompositionTags.SupportRegion.Root else CompositionTags.SupportRegion.Root
    local var6, var7

    if bool1 then
        var6 = UDim2.fromScale(0, 0)
        var7 = UDim2.fromScale(1, 1)
    else
        var6 = var3.supportPosition
        var7 = var3.supportSize
        if FFlagFixSplitPaneGamepadLayoutJitter and var7 == nil and var2 == Enums.SupportPaneMode.Normal and xOffset2 > 0 then
            var7 = UDim2.new(0, xOffset2, 1, 0)
        end
    end

    local bool8 = tbl2.supportResizerAbovePane == true
    local zIndex = if bool1 then 4 else bool6 and (if interactive then 1 elseif bool8 then 1 else 3) or 1

    local contentPosition = var3.contentPosition
    local contentSize = var3.contentSize

    local createElement = React.createElement
    local fragment = React.Fragment
    local var8 = nil
    local tbl4 = {
        CompositionStyleSheet = React.createElement(CompositionStyleSheet),
        NavigationPane = if tbl2.navigationPane then React.createElement(View, {
            tag = CompositionTags.NavigationRegion.Root,
            Size = UDim2.new(0, xOffset, 1, 0),
            ZIndex = 1,
            Interactable = interactable,
            backgroundStyle = backgroundStyle
        }, {
            Slot = tbl2.navigationPane.element
        }) else nil,
        ContentPane = React.createElement(View, {
            tag = CompositionTags.ContentRegion.Root,
            Position = contentPosition,
            Size = contentSize,
            ZIndex = 1,
            Interactable = interactable,
            backgroundStyle = backgroundStyle,
            onAbsoluteSizeChanged = tbl2.onContentRegionRectChanged,
            onAbsolutePositionChanged = tbl2.onContentRegionRectChanged
        }, tbl2.children),
        SupportPane = if tbl2.supportPane then React.createElement(View, {
            tag = tag,
            Position = var6,
            Size = var7,
            ZIndex = zIndex,
            backgroundStyle = backgroundStyle,
            onAbsoluteSizeChanged = onAbsoluteSizeChanged,
            onAbsolutePositionChanged = tbl2.onSupportRegionRectChanged
        }, {
            Slot = tbl2.supportPane.element
        }) else nil,
        SupportResizer = if bool6 then React.createElement(PaneResizer, {
            Name = "SupportResizer",
            interactive = interactive,
            position = var3.resizerPosition,
            hitWidth = var3.resizerHitWidth,
            ZIndex = if interactive then 3 elseif bool8 then 3 else 2,
            onDrag = if interactive then var3.onResizerDrag else nil,
            onDragEnd = if interactive then var3.onResizerDragEnd else nil
        }) else nil
    }
    return createElement(fragment, var8, tbl4)
end)

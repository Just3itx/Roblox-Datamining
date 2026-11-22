-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T21:31:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SplitPaneParent = script:FindFirstAncestor("SplitPane").Parent

local React = require(SplitPaneParent.React)
local SignalsReact = require(SplitPaneParent.SignalsReact)
local Responsive = require(SplitPaneParent.Responsive)
local AppSplitView = require(SplitPaneParent.AppSplitView)
local Constants = require(SplitPaneParent.NavigationRodux).Constants
local SplitPaneContext = require(script.Parent.Parent.Context.SplitPaneContext)

local SplitPaneStore = require(script.Parent.Parent.Stores.SplitPaneStore)
local isSupportPaneScreen = require(script.Parent.Parent.Utils.isSupportPaneScreen)
local SplitPaneVariant = require(script.Parent.Parent.Utils.SplitPaneVariant)
local SplitPaneTelemetry = require(script.Parent.Parent.Telemetry.SplitPaneTelemetry)
local FFlagEnableSplitPaneTelemetry = require(SplitPaneParent.SharedFlags).FFlagEnableSplitPaneTelemetry
local FFlagAXPauseSceneWhenSplitPaneCollapsed = require(SplitPaneParent.SharedFlags).FFlagAXPauseSceneWhenSplitPaneCollapsed
local FFlagFixSplitPaneGamepadLayoutJitter = require(SplitPaneParent.SharedFlags).FFlagFixSplitPaneGamepadLayoutJitter
local FFlagSplitPaneAvatarOnlyAlwaysExpanded = require(SplitPaneParent.SharedFlags).FFlagSplitPaneAvatarOnlyAlwaysExpanded

local supportPaneInputRules = require(script.Parent.Parent.Utils.supportPaneInputRules)

local usePreferredInput = Responsive.usePreferredInput

local SupportPaneMode = AppSplitView.Enums.SupportPaneMode

local TempRnSwitchNavigatorName = Constants.TempRnSwitchNavigatorName

local function resolveTemporarySupportPaneMode(current: number, num1: number, arg1, bool1: boolean)
    local bool2 = current > 0 and num1 == 0
    local bool3 = current == 0 and num1 > 0
    local bool4 = not bool3 and num1 > 0
    if bool3 then
        if FFlagSplitPaneAvatarOnlyAlwaysExpanded and SplitPaneVariant.isSupportPaneAlwaysExpanded() then
            return SupportPaneMode.Expanded, true
        end

        return if SplitPaneVariant.shouldAutoExpandOnSupportOpen() then supportPaneInputRules.resolveOpenedMode(arg1) else supportPaneInputRules.resolveInputChangedMode(arg1), true
    elseif bool2 then
        return nil, true
    elseif bool1 and bool4 then
        if FFlagSplitPaneAvatarOnlyAlwaysExpanded and SplitPaneVariant.isSupportPaneAlwaysExpanded() then
            return SupportPaneMode.Expanded, true
        end
        return supportPaneInputRules.resolveInputChangedMode(arg1), true
    else
        return nil, false
    end
end

local function useSplitPaneRender(tbl1, tbl2, tbl3, bool1: boolean)
    local store = SplitPaneStore.getStore()

    local num1 = bool1 and #tbl3 or 0
    local isRootAppStack = not (tbl1[1] == nil or tbl1[1].descriptor == nil or tbl1[1].descriptor.state == nil)
        and tbl1[1].descriptor.state.routeName == TempRnSwitchNavigatorName
    local var1 = React.useRef(0)
    local var2 = usePreferredInput()

    if FFlagFixSplitPaneGamepadLayoutJitter and isRootAppStack then
        local current = var1.current
        local bool3 = current > 0 and num1 == 0
        local bool4 = current == 0 and num1 > 0

        if not bool4 and num1 > 0 then
        end

        local expanded, bool5

        if bool4 then
            if FFlagSplitPaneAvatarOnlyAlwaysExpanded and SplitPaneVariant.isSupportPaneAlwaysExpanded() then
                expanded = SupportPaneMode.Expanded
                bool5 = true
            else
                if SplitPaneVariant.shouldAutoExpandOnSupportOpen() then
                    expanded = supportPaneInputRules.resolveOpenedMode(var2)
                else
                    expanded = supportPaneInputRules.resolveInputChangedMode(var2)
                end

                bool5 = true
            end
        elseif bool3 then
            bool5 = true
            expanded = nil
        else
            bool5 = false
            expanded = nil
        end

        if bool5 then
            store.setTemporarySupportPaneMode(expanded)
        end
    end

    local supportPaneMode = SignalsReact.useSignalState(store.getSupportPaneMode)
    local supportWidth = SignalsReact.useSignalState(store.getSupportWidth)
    local isBreakpointEnabled = SignalsReact.useSignalState(store.getIsBreakpointEnabled)

    local var6 = React.useContext(SplitPaneContext)

    local primarySlotChildren = table.clone(tbl2)
    local supportSlotChildren = ({})
    local overlaySlotChildren = ({})
    if bool1 then
        for _, value in tbl3 do
            local key = tbl1[value].descriptor.key
            local var8 = primarySlotChildren[key]
            if var8 ~= nil then
                primarySlotChildren[key] = nil
                supportSlotChildren[key] = var8
            end
        end
    end

    if isBreakpointEnabled then
        local num2 = 0
        for value, value2 in tbl1 do
            local options = value2.descriptor.options
            if options ~= nil and options.splitPaneEligibility ~= nil then
                num2 = value
            end
        end

        for value, value2 in tbl1 do
            local options = value2.descriptor.options

            if options == nil or not options.transparent or options.overlayEnabled or options.splitPaneEligibility ~= nil then
                continue
            end

            local key = value2.descriptor.key
            local var8 = primarySlotChildren[key]
            if var8 == nil then
                continue
            end

            primarySlotChildren[key] = nil
            if num2 < value then
                overlaySlotChildren[key] = var8
            end
        end
    end

    if FFlagAXPauseSceneWhenSplitPaneCollapsed then
        React.useEffect(function()
            if isRootAppStack then
                store.setHasSupportRoute(num1 > 0)
            end
        end, { isRootAppStack, num1, store })
        React.useEffect(function()
            return function()
                if isRootAppStack then
                    store.setHasSupportRoute(false)
                end
            end
        end, { isRootAppStack, store })
    end

    React.useEffect(function()
        local current = var1.current
        var1.current = num1
        if not isRootAppStack then
            return
        end

        local bool3 = current == 0 and num1 > 0

        if bool3 and FFlagEnableSplitPaneTelemetry then
            SplitPaneTelemetry.logSupportRouteOpened()
        end

        local var8, bool4 = resolveTemporarySupportPaneMode(current, num1, var2, true)
        if bool4 then
            store.setTemporarySupportPaneMode(var8)
        end
    end, {
        isRootAppStack,
        num1,
        store,
        supportPaneMode,
        var2
    })

    local var8 = if num1 > 0 then tbl3[num1] else nil
    local var9 = var8 == nil and {} or tbl1[var8].descriptor.options
    local navigation = if var8 == nil then nil else tbl1[var8].descriptor.navigation
    local hasDetailOnTop = var8 ~= nil

    local supportRouteKeys = {}
    if bool1 then
        for _, value in tbl1 do
            if not isSupportPaneScreen(value) then
                continue
            end

            local state = value.descriptor.state
            if state ~= nil and state.key ~= nil then
                table.insert(supportRouteKeys, state.key)
            end
        end
    end

    local supportContentProps = {
        hostNavigation = navigation,
        hasDetailOnTop = hasDetailOnTop,
        paneCount = num1,
        splitPaneExpandable = var9.splitPaneExpandable,
        splitPaneCollapsible = var9.splitPaneCollapsible,
        supportRouteKeys = supportRouteKeys
    }

    local bool4 = (var9.splitPaneCollapsible == true or not hasDetailOnTop) and not (hasDetailOnTop and num1 > 1)

    return {
        primarySlotChildren = primarySlotChildren,
        supportSlotChildren = supportSlotChildren,
        overlaySlotChildren = overlaySlotChildren,
        supportContentProps = supportContentProps,
        supportWidth = supportWidth,
        supportMinWidth = store.getMinSupportWidth(),
        supportMaxWidth = store.getMaxSupportWidth(),
        onSupportPaneWidthChanged = store.setSupportWidth,
        supportPaneMode = supportPaneMode,
        supportPaneResizable = var6.supportPaneResizable == true,
        supportResizerAbovePane = not bool4,
        isBreakpointEnabled = isBreakpointEnabled,
        isRootAppStack = isRootAppStack,
        renderSupportContent = var6.renderSupportContent,
        onContentRegionRectChanged = var6.onContentRegionRectChanged
    }
end

return useSplitPaneRender

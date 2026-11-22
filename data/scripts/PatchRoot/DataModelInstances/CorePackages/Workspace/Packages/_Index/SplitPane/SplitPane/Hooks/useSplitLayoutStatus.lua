-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T21:31:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SplitPaneParent = script:FindFirstAncestor("SplitPane").Parent

local React = require(SplitPaneParent.React)
local FFlagEnableSplitPaneTelemetry = require(SplitPaneParent.SharedFlags).FFlagEnableSplitPaneTelemetry
local FFlagEnableSplitPaneStackFallbackFix = require(SplitPaneParent.SharedFlags).FFlagEnableSplitPaneStackFallbackFix
local RoactNavigation = require(SplitPaneParent.RoactNavigation)
local SignalsReact = require(SplitPaneParent.SignalsReact)
local AppSplitView = require(SplitPaneParent.AppSplitView)
local ViewState = require(SplitPaneParent.Navigation).ViewState
local Constants = require(SplitPaneParent.NavigationRodux).Constants
local SplitPaneContext = require(script.Parent.Parent.Context.SplitPaneContext)

local SplitPaneStore = require(script.Parent.Parent.Stores.SplitPaneStore)
local useInitializeSplitPaneTelemetrySession = require(script.Parent.useInitializeSplitPaneTelemetrySession)
local computeSplitEligibility = require(script.Parent.Parent.Utils.computeSplitEligibility)
local SplitPaneVariant = require(script.Parent.Parent.Utils.SplitPaneVariant)
local SupportPaneMode = AppSplitView.Enums.SupportPaneMode

local SplitPaneSlot = AppSplitView.Enums.SplitPaneSlot
local TempRnSwitchNavigatorName = Constants.TempRnSwitchNavigatorName

local function useSplitLayoutStatus(tbl1, num1: number)
    local store = SplitPaneStore.getStore()
    local var1 = SignalsReact.useSignalState(store.getIsBreakpointEnabled)
    local wasSplitPaneAvailable = if FFlagEnableSplitPaneStackFallbackFix then SignalsReact.useSignalState(store.getWasSplitPaneAvailable) else false
    local supportPaneMode = SignalsReact.useSignalState(store.getSupportPaneMode)

    local var4 = computeSplitEligibility(tbl1)
    local isSplitEnabled = var1 and var4

    local bool1 = React.useContext(SplitPaneContext).renderSupportContent ~= nil
    local isRootAppStack = not (tbl1[1] == nil or tbl1[1].descriptor == nil or tbl1[1].descriptor.state == nil)
        and tbl1[1].descriptor.state.routeName == TempRnSwitchNavigatorName
    local paneIndices = {}
    local var6 = nil
    local bool3 = false

    local var7 = SplitPaneVariant.isPaneCollapsedByDefault()
        and not SplitPaneVariant.shouldAutoExpandOnSupportOpen()
        and supportPaneMode == SupportPaneMode.Collapsed
    if isSplitEnabled then
        for i = #tbl1, 1, -1 do
            local options = tbl1[i].descriptor.options
            local splitPaneEligibility = options.splitPaneEligibility
            if var7 and splitPaneEligibility == SplitPaneSlot.Support then
                splitPaneEligibility = nil
            end

            if splitPaneEligibility == SplitPaneSlot.Support then
                table.insert(paneIndices, 1, i)
            elseif (not (options.transparent or options.overlayEnabled) or splitPaneEligibility ~= nil) and #paneIndices > 0 then
                var6 = i
                break
            end
        end
    elseif not var1 and (not FFlagEnableSplitPaneStackFallbackFix or wasSplitPaneAvailable) then
        for _, value in tbl1 do
            if value.descriptor.options.splitPaneEligibility == SplitPaneSlot.Support and value.viewState ~= ViewState.Closing then
                bool3 = true
                break
            end
        end
    end

    local num2 = #paneIndices
    local isRouteActiveOnPane = not (var6 == nil) and num2 > 0
    local bool5 = num1 >= 1
    local isSplitLayoutEnabled = bool3 or isRouteActiveOnPane or isSplitEnabled and bool1 and bool5

    local var9 = nil
    if isSplitEnabled then
        for i = #tbl1, 1, -1 do
            local options = tbl1[i].descriptor.options
            local splitPaneEligibility = options.splitPaneEligibility
            if var7 and splitPaneEligibility == SplitPaneSlot.Support then
                splitPaneEligibility = nil
            end

            if splitPaneEligibility ~= SplitPaneSlot.Support
                and (not (options.transparent or options.overlayEnabled) or splitPaneEligibility ~= nil)
            then
                var9 = i
                break
            end
        end
    end

    React.useEffect(function()
        if not isRootAppStack then
            return
        end

        local isSplitEligible = store.getIsSplitEligible(false)
        store.setIsSplitEligible(var4)
        if not isSplitEligible or var4 then
            return
        end

        local descriptor = tbl1[1].descriptor
        if descriptor == nil or descriptor.navigation == nil then
            return
        end
        local navigation = descriptor.navigation
        for i = #tbl1, 2, -1 do
            local descriptor2 = tbl1[i].descriptor
            if descriptor2 == nil then
                continue
            end

            local splitPaneEligibility = descriptor2.options.splitPaneEligibility
            if splitPaneEligibility == nil or splitPaneEligibility == SplitPaneSlot.Content then
                continue
            end

            local key = if descriptor2.state == nil then nil else descriptor2.state.key or nil

            if key == nil then
                continue
            end

            navigation.dispatch(RoactNavigation.StackActions.pop({ key = key, prune = false, immediate = true }))
        end
    end, {
        isRootAppStack,
        var4,
        tbl1,
        store
    })
    React.useEffect(function()
        if isSplitLayoutEnabled then
            return
        end
        if isRootAppStack then
            store.setTemporarySupportPaneMode(nil)
        end
        for _, value in tbl1 do
            if value.viewState == ViewState.Closing
                and (not FFlagEnableSplitPaneStackFallbackFix or wasSplitPaneAvailable)
                and value.descriptor.options.splitPaneEligibility == SplitPaneSlot.Support
            then
                value.setClosed()
            end
        end
    end, {
        isRootAppStack,
        isSplitLayoutEnabled,
        tbl1,
        store,
        wasSplitPaneAvailable
    })
    if FFlagEnableSplitPaneTelemetry then
        useInitializeSplitPaneTelemetrySession(isRootAppStack)
    end

    return {
        isSplitLayoutEnabled = isSplitLayoutEnabled,
        isRouteActiveOnPane = isRouteActiveOnPane,
        paneIndices = paneIndices,
        contentTopCandidate = var9,
        splitPrimaryIndex = var6,
        supportPaneMode = supportPaneMode,
        isRootAppStack = isRootAppStack,
        isSplitEnabled = isSplitEnabled,
        wasSplitPaneAvailable = wasSplitPaneAvailable
    }
end

return useSplitLayoutStatus

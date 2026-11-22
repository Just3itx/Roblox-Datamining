-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T21:21:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GuiService = game:GetService("GuiService")

local SplitPaneParent = script:FindFirstAncestor("SplitPane").Parent

local React = require(SplitPaneParent.React)
local Foundation = require(SplitPaneParent.Foundation)
local FocusNavigationUtils = require(SplitPaneParent.FocusNavigationUtils)
local ReactFocusNavigation = require(SplitPaneParent.ReactFocusNavigation)
local Responsive = require(SplitPaneParent.Responsive)
local AppSplitView = require(SplitPaneParent.AppSplitView)
local useLocalization = require(SplitPaneParent.Localization).Hooks.useLocalization
local useSignalState = require(SplitPaneParent.SignalsReact).useSignalState
local useSelector = require(SplitPaneParent.RoactUtils).Hooks.RoactRodux.useSelector
local LocalUserIdStore = require(SplitPaneParent.LocalUserIdStore).LocalUserIdStore

local SplitPaneEducationalTourSteps = require(script.Parent.SplitPaneEducationalTourSteps)
local getSplitPaneEducationalTourPresentation = require(script.Parent.getSplitPaneEducationalTourPresentation)
local useTrackedRect = require(script.Parent.useTrackedRect)
local getSplitPaneEducationalTourTooltipModel = require(script.Parent.getSplitPaneEducationalTourTooltipModel)
local useSplitPaneEducationalTourLifecycle = require(script.Parent.useSplitPaneEducationalTourLifecycle)
local SplitPaneEducationalTourView = require(script.Parent.SplitPaneEducationalTourView)

local FFlagDebugSplitPaneEducationalTourAutoStart = require(script.Parent.Parent.Flags.FFlagDebugSplitPaneEducationalTourAutoStart)

local FIntSplitPaneEducationalTourStartDelayMs = require(script.Parent.Parent.Flags.FIntSplitPaneEducationalTourStartDelayMs)

local FFlagSplitPaneEducationalTourPreloadVideos = require(script.Parent.Parent.Flags.FFlagSplitPaneEducationalTourPreloadVideos)
local useSplitPaneEducationalTourVideoPreload = if FFlagSplitPaneEducationalTourPreloadVideos then require(script.Parent.useSplitPaneEducationalTourVideoPreload) else nil
local FFlagSplitPaneEducationalTourSkipOnDeepLink = require(script.Parent.Parent.Flags.FFlagSplitPaneEducationalTourSkipOnDeepLink)
local DeepLinkLuaReceiverStatusStore = if FFlagSplitPaneEducationalTourSkipOnDeepLink then require(SplitPaneParent.DeepLink).DeepLinkLuaReceiverStatusStore else nil
local FStringSplitPaneEducationalTourKeepOnDeepLinkPatterns = require(script.Parent.Parent.Flags.FStringSplitPaneEducationalTourKeepOnDeepLinkPatterns)

local FFlagSplitPaneEducationalTourTelemetry = require(script.Parent.Parent.Flags.FFlagSplitPaneEducationalTourTelemetry)
local SplitPaneEducationalTourTelemetry = if FFlagSplitPaneEducationalTourTelemetry then require(script.Parent.Parent.Telemetry.SplitPaneEducationalTourTelemetry) else nil
local isSplitPaneEducationalTourGuiObjectVisible = require(script.Parent.isSplitPaneEducationalTourGuiObjectVisible)
local getSplitPaneEducationalTourStore = require(script.Parent.Parent.Stores.getSplitPaneEducationalTourStore)
local SplitPaneStore = require(script.Parent.Parent.Stores.SplitPaneStore)

local Flags = Foundation.Utility.Flags
local useOverlay = Foundation.Hooks.useOverlay
local useScaledValue = Foundation.Hooks.useScaledValue
local useTokens = Foundation.Hooks.useTokens
local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum
local useFocusOnMount = FocusNavigationUtils.useFocusOnMount
local useFocusRoot = FocusNavigationUtils.useFocusRoot
local Input = Responsive.Input
local usePreferredInput = Responsive.usePreferredInput
local useDefaultFocusBehavior = ReactFocusNavigation.useDefaultFocusBehavior

local SupportPaneMode = AppSplitView.Enums.SupportPaneMode

local SplitPaneEducationalTourStepsLen = #SplitPaneEducationalTourSteps

local num1 = math.min(FIntSplitPaneEducationalTourStartDelayMs, 3000)

local holdsInputBeforeTooltip = num1 > 0

local function selectStatusBarHeight(arg1)
    return if arg1.TopBar == nil then 0 else arg1.TopBar.statusBarHeight
end

local function selectIsCentralOverlayOpen(arg1): boolean
    return not (arg1.CentralOverlay == nil) and arg1.CentralOverlay.OverlayType ~= nil
end

local function useAnchorRef(current) -- Luacid: Inlined by compiler; 6 call sites recovered
    return React.useMemo(function(): {current: any}?
        return if current == nil then nil else { current = current }
    end, { current })
end

local function SplitPaneEducationalTourBody(arg1)
    local supportPaneRef = arg1.supportPaneRef
    local supportPaneMode = arg1.supportPaneMode
    local isSupportPaneCollapsed = supportPaneMode == SupportPaneMode.Collapsed
    local isSupportSurfaceEligible = arg1.isSupportSurfaceEligible

    local tourStore = arg1.tourStore
    local splitPaneStore = SplitPaneStore.getStore()
    local stepIndex = arg1.stepIndex
    local shouldDefaultToCollapsed = useSignalState(splitPaneStore.getShouldDefaultToCollapsed)
    local collapsedExpandButtonRect = useSignalState(tourStore.getCollapsedExpandButtonRect)
    local collapsedExpandButton = useAnchorRef((useSignalState(tourStore.getCollapsedExpandButtonInstance)))

    local supportOverlayTopInset = useSelector(selectStatusBarHeight)
    local var5, setBottomPaneTooltipAnchorInstance = React.useState(nil)

    local var7, setGamepadCollapsedTooltipAnchorInstance = React.useState(nil)

    local var9, setGamepadStepTwoTooltipAnchorInstance = React.useState(nil)
    local var11, setGamepadFinalTooltipAnchorInstance = React.useState(nil)
    local var13, setTopRightControlInstance = React.useState(nil)
    local bottomPane = useAnchorRef(var5)
    local gamepadCollapsedStepOne = useAnchorRef(var7)
    local gamepadStepTwo = useAnchorRef(var9)
    local gamepadFinal = useAnchorRef(var11)
    local topRightControl = useAnchorRef(var13)

    local var20, var21 = React.useState(nil)
    React.useLayoutEffect(function()
        var21(if supportPaneRef == nil then nil else supportPaneRef.current)
    end, { supportPaneRef })
    local supportPaneRect = useTrackedRect(var20)

    local overlayInstance = useOverlay()

    local var24 = useTrackedRect(if overlayInstance then if overlayInstance:IsA("GuiObject") then overlayInstance else nil else nil)
    local min = if var24 == nil then nil else var24.Min
    local tokens = useTokens()
    local localized = useLocalization({
        continueButton = "Feature.SplitPane.Tour.Button.Continue",
        finishTourButton = "Feature.SplitPane.Tour.Button.FinishTour",
        skipTourButton = "Feature.SplitPane.Tour.Button.SkipTour",
        stepOneCollapsedDescription = "Feature.SplitPane.Tour.Step1.Description.Collapsed",
        stepOneExpandedDescription = "Feature.SplitPane.Tour.Step1.Description.Expanded",
        stepOneTitle = "Feature.SplitPane.Tour.Step1.Title",
        stepTwoDescription = "Feature.SplitPane.Tour.Step2.Description",
        stepTwoTitle = "Feature.SplitPane.Tour.Step2.Title",
        stepThreeDescription = "Feature.SplitPane.Tour.Step3.Description",
        stepThreeTitle = "Feature.SplitPane.Tour.Step3.Title"
    })

    local mediaWidth = useScaledValue(if Flags.FoundationEducationalTooltipRefresh then 280 else 320)

    local var28 = useFocusRoot(
        {
            surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.PopUp,
            isAutoFocusRoot = true,
            shouldRestoreFocus = false
        }
    )

    local var29, var30 = useDefaultFocusBehavior(var28)
    local setFocusSurfaceRef = React.useCallback(function(current)
        if typeof(var30) == "function" then
            var30(current)
        elseif var30 ~= nil then
            var30.current = current
        end
    end, { var30 })
    local var32 = ReactFocusNavigation.useFocusGuiObject()
    local var33 = usePreferredInput()
    local isDirectionalInput = var33 == Input.Directional
    local var34 = React.useRef(nil)
    local var35, var36 = React.useState(nil)
    local isTooltipContentVisible, var38 = React.useState(false)
    local var39 = useFocusOnMount(var29)
    local setPrimaryActionRef = React.useCallback(function(current)
        var34.current = current
        var39(current)
    end, { var39 })
    local setTooltipContentRef = React.useCallback(function(arg2)
        var36(arg2)
        setFocusSurfaceRef(arg2)
    end, { setFocusSurfaceRef })
    React.useLayoutEffect(function()
        if var35 == nil then
            var38(false)
            return
        end

        local function updateVisibility() -- Luacid: Inlined by compiler; 2 call sites recovered
            var38(isSplitPaneEducationalTourGuiObjectVisible(var35))
        end

        updateVisibility()
        local tbl1 = {}
        local function observeVisibleAncestors()
            for _, value in tbl1 do
                value:Disconnect()
            end
            tbl1 = {}
            local var42 = var35
            while var42 ~= nil do
                if var42:IsA("GuiObject") then
                    table.insert(tbl1, var42:GetPropertyChangedSignal("Visible"):Connect(updateVisibility))
                end
                var42 = var42.Parent
            end

            updateVisibility()
        end

        observeVisibleAncestors()
        local connection = var35.AncestryChanged:Connect(observeVisibleAncestors)
        return function()
            connection:Disconnect()
            for _, value in tbl1 do
                value:Disconnect()
            end
        end
    end, { var35 })
    local overlayOrigin = min or Vector2.zero
    local presentation = getSplitPaneEducationalTourPresentation({
        stepIndex = stepIndex,
        isSupportPaneCollapsed = isSupportPaneCollapsed,
        isDirectionalInput = isDirectionalInput,
        collapsedExpandButtonRect = collapsedExpandButtonRect,
        supportPaneRect = supportPaneRect,
        anchors = {
            gamepadCollapsedStepOne = gamepadCollapsedStepOne,
            collapsedExpandButton = collapsedExpandButton,
            gamepadStepTwo = gamepadStepTwo,
            bottomPane = bottomPane,
            gamepadFinal = gamepadFinal,
            topRightControl = topRightControl,
            supportPane = supportPaneRef
        },
        collapsedSpotlightPadding = 4
    })

    local var43 = useSplitPaneEducationalTourLifecycle({
        isSupportSurfaceEligible = isSupportSurfaceEligible,
        stepIndex = stepIndex,
        totalSteps = SplitPaneEducationalTourStepsLen,
        supportPaneMode = supportPaneMode,
        shouldDefaultToCollapsed = shouldDefaultToCollapsed,
        isSupportPaneCollapsed = isSupportPaneCollapsed,
        tourStore = tourStore,
        splitPaneStore = splitPaneStore
    })

    local var44, var45 = React.useState(not holdsInputBeforeTooltip)
    React.useEffect(function()
        if not holdsInputBeforeTooltip then
            return
        end

        local bool4 = false
        task.delay(num1 / 1000, function()
            if not bool4 then
                var45(true)
            end
        end)
        return function()
            bool4 = true
        end
    end, {})

    React.useEffect(function()
        if isTooltipContentVisible or not var44 then
            return
        end

        local bool4 = false
        task.delay(5, function()
            if bool4 then
                return
            end

            if FFlagSplitPaneEducationalTourTelemetry then
                SplitPaneEducationalTourTelemetry.logAbandoned(
                    SplitPaneEducationalTourTelemetry.EndReason.TooltipHiddenTimeout,
                    tourStore.getStepIndex(false),
                    SplitPaneEducationalTourStepsLen,
                    splitPaneStore.getSupportPaneMode(false) == SupportPaneMode.Collapsed
                )
            end
            var43.endTour()
        end)

        return function()
            bool4 = true
        end
    end, {
        isTooltipContentVisible,
        var44,
        var43.endTour,
        tourStore,
        splitPaneStore
    })

    React.useEffect(function()
        if var34.current ~= nil and (var33 == Input.Directional or GuiService.SelectedCoreObject ~= nil) then
            var32(var34.current)
        end
    end, {
        stepIndex,
        var33,
        var32,
        var44
    })

    local step = SplitPaneEducationalTourSteps[stepIndex]
    local tooltipModel = if var44 then getSplitPaneEducationalTourTooltipModel({
        stepIndex = stepIndex,
        totalSteps = SplitPaneEducationalTourStepsLen,
        step = step,
        isCollapsedStepOne = presentation.isCollapsedStepOne,
        isDirectionalInput = isDirectionalInput,
        localized = localized
    }) else nil
    local hasPresentedTooltip, var47 = React.useState(false)
    React.useEffect(function()
        if isTooltipContentVisible then
            var47(true)
        end
    end, { isTooltipContentVisible })

    local var48 = React.useRef(false)
    React.useEffect(function()
        if not var48.current and step ~= nil and var35 ~= nil and isTooltipContentVisible then
            var48.current = true
            tourStore.notifyTourVisible()
        end
    end, {
        step,
        var35,
        isTooltipContentVisible,
        tourStore.notifyTourVisible
    })
    local var49 = React.useRef(0)
    React.useEffect(function()
        if FFlagSplitPaneEducationalTourTelemetry
            and var49.current ~= stepIndex
            and isTooltipContentVisible
            and var35 ~= nil
            and isSplitPaneEducationalTourGuiObjectVisible(var35)
        then
            var49.current = stepIndex
            SplitPaneEducationalTourTelemetry.logStepShown(stepIndex, SplitPaneEducationalTourStepsLen, isSupportPaneCollapsed)
        end
    end, {
        isTooltipContentVisible,
        var35,
        stepIndex,
        isSupportPaneCollapsed
    })

    local var50 = React.useCallback(function()
        if FFlagSplitPaneEducationalTourTelemetry then
            SplitPaneEducationalTourTelemetry.logStepAdvanced(
                stepIndex,
                SplitPaneEducationalTourStepsLen,
                stepIndex == 1 and isSupportPaneCollapsed
            )
        end

        var43.handleNext()
    end, { var43.handleNext, stepIndex, isSupportPaneCollapsed })

    local isFinal = not (tooltipModel == nil) and tooltipModel.isFinal

    local var51 = React.useCallback(function()
        if FFlagSplitPaneEducationalTourTelemetry then
            SplitPaneEducationalTourTelemetry.logUserEnded(
                isFinal,
                stepIndex,
                SplitPaneEducationalTourStepsLen,
                splitPaneStore.getSupportPaneMode(false) == SupportPaneMode.Collapsed
            )
        end
        var43.endTour()
    end, {
        var43.endTour,
        isFinal,
        stepIndex,
        splitPaneStore
    })
    local createElement = React.createElement
    local var52 = SplitPaneEducationalTourView
    local tbl1 = {
        isTooltipContentVisible = isTooltipContentVisible,
        hasPresentedTooltip = hasPresentedTooltip,
        holdsInputBeforeTooltip = holdsInputBeforeTooltip,
        supportPaneRect = supportPaneRect,
        overlayOrigin = overlayOrigin,
        overlayInstance = overlayInstance,
        supportOverlayTopInset = supportOverlayTopInset,
        presentation = presentation,
        tooltipModel = tooltipModel,
        tokens = tokens,
        mediaWidth = mediaWidth,
        videoAspectRatio = 1.5,
        setPrimaryActionRef = setPrimaryActionRef,
        setTooltipContentRef = setTooltipContentRef,
        setFocusSurfaceRef = setFocusSurfaceRef,
        setGamepadCollapsedTooltipAnchorInstance = setGamepadCollapsedTooltipAnchorInstance,
        setBottomPaneTooltipAnchorInstance = setBottomPaneTooltipAnchorInstance,
        setGamepadStepTwoTooltipAnchorInstance = setGamepadStepTwoTooltipAnchorInstance,
        setGamepadFinalTooltipAnchorInstance = setGamepadFinalTooltipAnchorInstance,
        setTopRightControlInstance = setTopRightControlInstance,
        onNext = 0,
        onEnd = 0
    }

    if not FFlagSplitPaneEducationalTourTelemetry then
        var50 = var43.handleNext
    end

    tbl1.onNext = var50
    if not FFlagSplitPaneEducationalTourTelemetry then
        var51 = var43.endTour
    end

    tbl1.onEnd = var51
    return createElement(var52, tbl1)
end

local tbl1 = {}
for _, value in string.split(FStringSplitPaneEducationalTourKeepOnDeepLinkPatterns, ",") do
    local var1 = string.match(value, "^%s*(.-)%s*$")
    if var1 ~= nil and var1 ~= "" then
        table.insert(tbl1, var1)
    end
end

local function isKeepOnDeepLink(str1: string)
    local str2 = string.split(string.lower(str1), "?")[1]
    for _, value in tbl1 do
        local success, result = pcall(string.find, str2, value)
        if success and result ~= nil then
            return true
        end
    end
    return false
end

local function SplitPaneEducationalTour(tbl2)
    local tourStore = getSplitPaneEducationalTourStore(false)
    local stepIndex = useSignalState(tourStore.getStepIndex)
    local var2 = useSignalState(tourStore.getIsOpen)
    local var3 = useSignalState(tourStore.getPendingUserId)
    local var4 = useSignalState(LocalUserIdStore.getCurrentUserId)
    local var5 = useSelector(selectIsCentralOverlayOpen)

    local isSupportSurfaceEligible = tbl2.isSupportSurfaceEligible and not var5
    if FFlagSplitPaneEducationalTourPreloadVideos then
        useSplitPaneEducationalTourVideoPreload(var2 or FFlagDebugSplitPaneEducationalTourAutoStart)
    end

    local var7 = if FFlagSplitPaneEducationalTourSkipOnDeepLink then useSignalState(DeepLinkLuaReceiverStatusStore(false).getLastDetectedPostAuthUrl) else nil
    local bool2 = not (var7 == nil or var7 == "") and not isKeepOnDeepLink(var7)

    React.useEffect(function()
        if FFlagSplitPaneEducationalTourTelemetry and var2 and var3 == var4 then
            SplitPaneEducationalTourTelemetry.logDelivered(SplitPaneEducationalTourStepsLen)
        end
    end, { var2, var3, var4 })
    local var8 = React.useRef(false)
    React.useEffect(function()
        if var2 and var3 ~= var4 then
            if FFlagSplitPaneEducationalTourTelemetry then
                SplitPaneEducationalTourTelemetry.logAbandoned(
                    if var4 == "" then SplitPaneEducationalTourTelemetry.EndReason.HostUnmounted else SplitPaneEducationalTourTelemetry.EndReason.UserChanged,
                    stepIndex,
                    SplitPaneEducationalTourStepsLen,
                    SplitPaneStore.getStore().getSupportPaneMode(false) == SupportPaneMode.Collapsed
                )
            end
            tourStore.discardPendingTour()
            return
        end

        if bool2 and not tourStore.getHasShownTour(false) and (var2 or stepIndex > 0) then
            if FFlagSplitPaneEducationalTourTelemetry then
                SplitPaneEducationalTourTelemetry.logAbandoned(
                    SplitPaneEducationalTourTelemetry.EndReason.DeepLink,
                    stepIndex,
                    SplitPaneEducationalTourStepsLen,
                    SplitPaneStore.getStore().getSupportPaneMode(false) == SupportPaneMode.Collapsed
                )
            end
            tourStore.discardPendingTour()
            return
        end

        if var2 and stepIndex == 0 then
            var8.current = false
        end
        if var2 and isSupportSurfaceEligible and not var8.current then
            var8.current = true
            tourStore.setStepIndex(1)
        end
        if not var2 then
            var8.current = false
        end
    end, {
        var2,
        var3,
        var4,
        stepIndex,
        isSupportSurfaceEligible,
        bool2,
        tourStore.getHasShownTour,
        tourStore.setStepIndex,
        tourStore.discardPendingTour
    })

    local var9 = React.useRef(false)
    React.useEffect(function()
        if FFlagDebugSplitPaneEducationalTourAutoStart and isSupportSurfaceEligible and not (bool2 or var9.current) then
            var9.current = true
            tourStore.setStepIndex(1)
        end
    end, { isSupportSurfaceEligible, bool2, tourStore.setStepIndex })

    React.useEffect(function()
        return function()
            if FFlagSplitPaneEducationalTourTelemetry then
                local store = SplitPaneStore.getStore()

                SplitPaneEducationalTourTelemetry.logAbandoned(
                    if store.getIsBreakpointEnabled(false) then SplitPaneEducationalTourTelemetry.EndReason.HostUnmounted else SplitPaneEducationalTourTelemetry.EndReason.BreakpointLost,
                    tourStore.getStepIndex(false),
                    SplitPaneEducationalTourStepsLen,
                    store.getSupportPaneMode(false) == SupportPaneMode.Collapsed
                )
            end
            tourStore.discardPendingTour()
        end
    end, { tourStore.discardPendingTour, tourStore.getStepIndex })

    if stepIndex == 0 then
        return nil
    end

    return React.createElement(SplitPaneEducationalTourBody, {
        supportPaneRef = tbl2.supportPaneRef,
        supportPaneMode = tbl2.supportPaneMode,
        isSupportSurfaceEligible = isSupportSurfaceEligible,
        tourStore = tourStore,
        stepIndex = stepIndex
    })
end

return SplitPaneEducationalTour

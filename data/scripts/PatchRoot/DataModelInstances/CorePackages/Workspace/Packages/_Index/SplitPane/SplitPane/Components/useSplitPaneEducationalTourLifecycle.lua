-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T21:30:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SplitPaneParent = script:FindFirstAncestor("SplitPane").Parent

local React = require(SplitPaneParent.React)
local AppSplitView = require(SplitPaneParent.AppSplitView)

local _getSplitPaneEducationalTourStore = require(script.Parent.Parent.Stores.getSplitPaneEducationalTourStore)
local _SplitPaneStore = require(script.Parent.Parent.Stores.SplitPaneStore)

local FFlagSplitPaneEducationalTourTelemetry = require(script.Parent.Parent.Flags.FFlagSplitPaneEducationalTourTelemetry)
local SplitPaneEducationalTourTelemetry = if FFlagSplitPaneEducationalTourTelemetry then require(script.Parent.Parent.Telemetry.SplitPaneEducationalTourTelemetry) else nil
local SupportPaneMode = AppSplitView.Enums.SupportPaneMode

local function useSplitPaneEducationalTourLifecycle(tbl1)
    local var1 = React.useRef(nil)
    local var2 = React.useRef(false)
    local var3 = React.useCallback(function(current)
        var1.current = current
        tbl1.splitPaneStore.setTemporarySupportPaneMode(current)
    end, { tbl1.splitPaneStore })
    local var4 = React.useCallback(function()
        local current = var1.current
        if current ~= nil and tbl1.splitPaneStore.getTemporarySupportPaneMode(false) == current then
            tbl1.splitPaneStore.setTemporarySupportPaneMode(nil)
        end
        var1.current = nil
    end, { tbl1.splitPaneStore })

    local var5 = React.useCallback(function()
        local var5 = if tbl1.splitPaneStore.getSupportPaneMode(false) == SupportPaneMode.Expanded then SupportPaneMode.Expanded else SupportPaneMode.Normal
        var3(var5)
    end, { tbl1.splitPaneStore, var3 })

    React.useEffect(function()
        if tbl1.stepIndex == tbl1.totalSteps then
            var5()
        end
    end, { tbl1.stepIndex, tbl1.totalSteps, var5 })

    local var6 = React.useRef(tbl1.supportPaneMode)

    React.useEffect(function()
        var3(var6.current)
        return function()
            var4()
        end
    end, { var3, var4 })

    React.useEffect(function()
        if tbl1.isSupportSurfaceEligible then
            return
        end

        if FFlagSplitPaneEducationalTourTelemetry then
            SplitPaneEducationalTourTelemetry.logInterrupted(tbl1.tourStore.getStepIndex(false), tbl1.totalSteps)
        end
        var4()
        tbl1.tourStore.reset()
    end, {
        tbl1.isSupportSurfaceEligible,
        var4,
        tbl1.tourStore,
        tbl1.totalSteps
    })

    local var7 = React.useRef(tbl1.shouldDefaultToCollapsed)
    React.useEffect(function()
        local current = var7.current
        var7.current = tbl1.shouldDefaultToCollapsed
        if current and not tbl1.shouldDefaultToCollapsed then
            var5()
        end
    end, { tbl1.shouldDefaultToCollapsed, var5 })

    return {
        endTour = React.useCallback(function()
            local supportPaneMode = tbl1.splitPaneStore.getSupportPaneMode(false)
            if var2.current and supportPaneMode ~= SupportPaneMode.Collapsed then
                tbl1.splitPaneStore.setSupportPaneMode(
                    if supportPaneMode == SupportPaneMode.Expanded then SupportPaneMode.Expanded else SupportPaneMode.Normal
                )
            end

            var4()
            tbl1.tourStore.discardPendingTour()
        end, { tbl1.splitPaneStore, tbl1.tourStore, var4 }),
        handleNext = React.useCallback(function()
            local stepIndex = tbl1.tourStore.getStepIndex(false)
            if stepIndex == 1 and tbl1.isSupportPaneCollapsed then
                var2.current = true
                var3(SupportPaneMode.Normal)
            end
            tbl1.tourStore.setStepIndex(stepIndex + 1)
        end, { tbl1.tourStore, tbl1.isSupportPaneCollapsed, var3 })
    }
end

return useSplitPaneEducationalTourLifecycle

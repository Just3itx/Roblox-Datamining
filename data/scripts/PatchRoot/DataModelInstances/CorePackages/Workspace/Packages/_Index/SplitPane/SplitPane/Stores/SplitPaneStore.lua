-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T21:31:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SplitPaneParent = script:FindFirstAncestor("SplitPane").Parent

local Signals = require(SplitPaneParent.Signals)
local SignalsUtils = require(SplitPaneParent.SignalsUtils)
local AppComposition = require(SplitPaneParent.AppComposition)
local AppSplitView = require(SplitPaneParent.AppSplitView)
local Display = require(SplitPaneParent.Display)
local SharedFlags = require(SplitPaneParent.SharedFlags)
local SplitPaneTelemetry = require(script.Parent.Parent.Telemetry.SplitPaneTelemetry)
local getTelemetrySnapshot = require(script.Parent.Parent.Telemetry.getTelemetrySnapshot)
local createSplitPanePreference = require(script.Parent.createSplitPanePreference)

local EnablePersistSplitPanePreferenceFeature = require(script.Parent.Parent.Flags.EnablePersistSplitPanePreferenceFeature)

local createCurrentScreenOrientationSignal = require(script.Parent.Parent.Utils.createCurrentScreenOrientationSignal)
local supportPaneWidthRules = require(script.Parent.Parent.Utils.supportPaneWidthRules)

local SplitPaneVariant = require(script.Parent.Parent.Utils.SplitPaneVariant)
local getRegionOverrides = AppComposition.getRegionOverrides
local RegionName = AppComposition.RegionName

local SupportPaneMode = AppSplitView.Enums.SupportPaneMode

local FFlagSplitPaneFixClassicThemeHeader = SharedFlags.FFlagSplitPaneFixClassicThemeHeader
local FFlagEnableSplitPaneTelemetry = SharedFlags.FFlagEnableSplitPaneTelemetry
local FFlagEnableSplitPaneStackFallbackFix = SharedFlags.FFlagEnableSplitPaneStackFallbackFix
local FFlagAXPauseSceneWhenSplitPaneCollapsed = SharedFlags.FFlagAXPauseSceneWhenSplitPaneCollapsed

local function getSupportRegionSizing() -- Luacid: unused: defined but never referenced
    local regionOverrides = if getRegionOverrides and RegionName then getRegionOverrides(RegionName.SupportRegion) else nil
    local var1 = if regionOverrides and regionOverrides.widthScale then regionOverrides.widthScale else 0.33
    local var2 = if regionOverrides and regionOverrides.minWidth then regionOverrides.minWidth else 0
    if regionOverrides and regionOverrides.maxWidth then
        return var1, var2, regionOverrides.maxWidth
    end

    return var1, var2, math.huge
end

local function evaluateShouldDefaultToCollapsed(arg1)
    if SplitPaneVariant.isPaneCollapsedByDefault() then
        return true
    end
    local var1 = Display.GetDisplayStore(arg1).getDesignSpaceViewportWidth(arg1)
    return supportPaneWidthRules.shouldDefaultToCollapsed(var1)
end

local effect = nil
local var1 = nil
local effect2 = nil

local function createSplitPaneStore()
    local regionOverrides = if getRegionOverrides and RegionName then getRegionOverrides(RegionName.SupportRegion) else nil
    local var2 = if regionOverrides then if regionOverrides.widthScale then regionOverrides.widthScale else 0.33 else 0.33
    local getMinSupportWidth = if regionOverrides then if regionOverrides.minWidth then regionOverrides.minWidth else 0 else 0
    local getMaxSupportWidth = not regionOverrides and math.huge or not regionOverrides.maxWidth and math.huge or regionOverrides.maxWidth

    local var5, var6 = createCurrentScreenOrientationSignal()
    var1 = var6
    local getCurrentScreenOrientation = var5
    local function evaluateBreakpointEnabled(arg1)
        local var8 = Display.GetDisplayStore(arg1).getDesignSpaceViewportWidth(arg1)
        local var9 = getCurrentScreenOrientation(arg1)
        return (var9 == Enum.ScreenOrientation.LandscapeLeft or var9 == Enum.ScreenOrientation.LandscapeRight)
            and supportPaneWidthRules.isSplitEnabledForWidth(var8)
    end

    local getSupportWidth, var9 = Signals.createSignal(nil)

    local var10, var11 = Signals.createSignal(nil)

    local getTemporarySupportPaneMode, var13 = Signals.createSignal(nil)
    local getShouldDefaultToCollapsed = Signals.createComputed(evaluateShouldDefaultToCollapsed)
    local splitPanePreference = nil
    local var14 = nil
    if EnablePersistSplitPanePreferenceFeature then
        splitPanePreference, var14 = createSplitPanePreference()
    end
    local function computeSupportPaneMode(arg1, bool1: boolean?)
        local var15 = getTemporarySupportPaneMode(arg1)
        if var15 ~= nil then
            return var15
        end
        local var16 = var10(arg1)
        if var16 ~= nil then
            return var16
        end
        if EnablePersistSplitPanePreferenceFeature then
            local var17 = splitPanePreference(arg1)
            if var17 ~= nil then
                return if var17 then SupportPaneMode.Collapsed else SupportPaneMode.Normal
            end
        end
        if bool1 == nil then
            bool1 = getShouldDefaultToCollapsed(arg1)
        end
        return if bool1 then SupportPaneMode.Collapsed else SupportPaneMode.Normal
    end
    local computed2 = Signals.createComputed(function(arg1)
        if FFlagEnableSplitPaneTelemetry then
            return (computeSupportPaneMode(arg1))
        end
        local var15 = getTemporarySupportPaneMode(arg1)
        if var15 ~= nil then
            return var15
        end
        local var16 = var10(arg1)
        if var16 ~= nil then
            return var16
        end
        if EnablePersistSplitPanePreferenceFeature then
            local var17 = splitPanePreference(arg1)
            if var17 ~= nil then
                return if var17 then SupportPaneMode.Collapsed else SupportPaneMode.Normal
            end
        end
        return if getShouldDefaultToCollapsed(arg1) then SupportPaneMode.Collapsed else SupportPaneMode.Normal
    end)
    local function getSupportPaneMode(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
        return (computed2(arg1))
    end

    local getSupportPaneEntryTarget, setSupportPaneEntryTarget = Signals.createSignal(nil)

    local getSupportPaneTopRouteMatcher, var18 = Signals.createSignal(nil)

    local function setSupportPaneTopRouteMatcher(func1: ((...any) -> (...any))?)
        var18(function()
            return func1
        end)
    end
    local getSupportPaneTopRouteKey, setSupportPaneTopRouteKey = Signals.createSignal(nil)
    if not FFlagEnableSplitPaneTelemetry then
        local var21 = getShouldDefaultToCollapsed(false)

        effect = Signals.createEffect(function(arg1)
            local var22 = getShouldDefaultToCollapsed(arg1)
            if var22 ~= var21 then
                var11(nil)
            end
            var21 = var22
        end)
    end

    local getSupportWidthFraction = Signals.createComputed(function(arg1)
        local var21 = Display.GetDisplayStore(arg1).getDesignSpaceViewportWidth(arg1)
        if var21 <= 0 then
            return var2
        end
        local var22 = getSupportWidth(arg1) or math.clamp(var21 * var2, getMinSupportWidth, getMaxSupportWidth)
        return var22 / var21
    end)

    local var21, var22

    if FFlagSplitPaneFixClassicThemeHeader then
        var21, var22 = Signals.createSignal(nil)
    else
        var21 = nil
        var22 = nil
    end

    local var23, var24

    if FFlagAXPauseSceneWhenSplitPaneCollapsed then
        var23, var24 = Signals.createSignal(false)
    else
        var23 = nil
        var24 = nil
    end

    local getIsSplitEligible, setIsSplitEligible = Signals.createSignal(false)
    local var27 = nil
    local var28

    if FFlagEnableSplitPaneTelemetry then
        local var29
        var29, var28 = SignalsUtils.createSessionScopedSignal(false)
        var27 = var29
    else
        var28 = nil
    end

    local function setSupportWidth(num1: number)
        local var29 = Display.GetDisplayStore(false).getPlatformScale(false)
        local var30 = num1 / (var29 and var29 > 0 and var29 or 1)
        var9(math.clamp(var30, getMinSupportWidth, getMaxSupportWidth))
    end

    local computed4 = Signals.createComputed(function(arg1) -- name: evaluateSplitActive
        return evaluateBreakpointEnabled(arg1) and getIsSplitEligible(arg1)
    end)

    local getSupportPaneModeIfActive = Signals.createComputed(function(arg1)
        if not computed4(arg1) then
            return nil
        end

        return (getSupportPaneMode(arg1))
    end)

    local getIsSplitPaneCollapsedOrNotActive = Signals.createComputed(function(arg1): boolean
        local var29 = getSupportPaneModeIfActive(arg1)
        return var29 == nil or var29 == SupportPaneMode.Collapsed
    end)

    local var29

    if FFlagEnableSplitPaneStackFallbackFix then
        local var30
        var29, var30 = Signals.createSignal(false)
        if evaluateBreakpointEnabled(false) then
            var30(true)
        end
        effect2 = Signals.createEffect(function(arg1)
            if evaluateBreakpointEnabled(arg1) then
                var30(true)
            end
        end)
    else
        var29 = function(): boolean
            return false
        end
    end

    local function resetSupportPaneMode()
        var11(nil)
        var13(nil)
    end

    local var30 = nil
    local tbl1 = {
        getCurrentScreenOrientation = getCurrentScreenOrientation,
        getIsTelemetrySessionInitialized = var27,
        setIsTelemetrySessionInitialized = var28,
        getSupportWidth = getSupportWidth,
        getSupportWidthFraction = getSupportWidthFraction,
        setSupportWidth = setSupportWidth,
        resetSupportWidth = function()
            var9(nil)
        end,
        getMinSupportWidth = function()
            return getMinSupportWidth
        end,
        getMaxSupportWidth = function()
            return getMaxSupportWidth
        end
    }
    if not FFlagSplitPaneFixClassicThemeHeader then
        var21 = nil
    end

    tbl1.getContentRegionRect = var21
    if not FFlagSplitPaneFixClassicThemeHeader then
        var22 = nil
    end

    tbl1.setContentRegionRect = var22

    tbl1.getIsBreakpointEnabled = Signals.createComputed(evaluateBreakpointEnabled)
    tbl1.getWasSplitPaneAvailable = var29
    tbl1.getIsSplitPaneActive = computed4
    tbl1.getIsSplitEnabled = computed4
    tbl1.getSupportPaneModeIfActive = getSupportPaneModeIfActive
    tbl1.getIsSplitPaneCollapsedOrNotActive = getIsSplitPaneCollapsedOrNotActive
    if not FFlagAXPauseSceneWhenSplitPaneCollapsed then
        var23 = nil
    end

    tbl1.getHasSupportRoute = var23
    if not FFlagAXPauseSceneWhenSplitPaneCollapsed then
        var24 = nil
    end

    tbl1.setHasSupportRoute = var24
    tbl1.getIsSplitEligible = getIsSplitEligible
    tbl1.setIsSplitEligible = setIsSplitEligible

    tbl1.getSupportPaneMode = getSupportPaneMode
    tbl1.getTemporarySupportPaneMode = getTemporarySupportPaneMode
    tbl1.getShouldDefaultToCollapsed = getShouldDefaultToCollapsed
    function tbl1.setSupportPaneMode(arg1)
        var11(arg1)
    end
    function tbl1.setTemporarySupportPaneMode(arg1)
        var13(arg1)
    end
    tbl1.resetSupportPaneMode = resetSupportPaneMode
    function tbl1.toggleSupportPaneMode(arg1)
        local var31 = if FFlagEnableSplitPaneTelemetry then getIsSplitPaneCollapsedOrNotActive(false) else nil
        local telemetryStateFromMode = if FFlagEnableSplitPaneTelemetry then SplitPaneTelemetry.getTelemetryStateFromMode(getSupportPaneModeIfActive(false)) else nil
        local var32 = if getSupportPaneMode(false) == arg1 then SupportPaneMode.Normal else arg1

        if getTemporarySupportPaneMode(false) ~= nil then
            var13(var32)
        else
            var11(var32)
        end

        if EnablePersistSplitPanePreferenceFeature and (arg1 == SupportPaneMode.Collapsed or arg1 == SupportPaneMode.Normal) then
            var11(var32)
            var14(var32 == SupportPaneMode.Collapsed)
        end
        if not FFlagEnableSplitPaneTelemetry or not var27(false) then
            return
        end
        local telemetryStateFromMode2 = SplitPaneTelemetry.getTelemetryStateFromMode(getSupportPaneModeIfActive(false))
        if telemetryStateFromMode ~= telemetryStateFromMode2 then
            SplitPaneTelemetry.logStateChanged(telemetryStateFromMode2, SplitPaneTelemetry.Action.Toggle)
        end
        if var31 ~= getIsSplitPaneCollapsedOrNotActive(false) then
            SplitPaneTelemetry.logSplitPaneViewChange(getTelemetrySnapshot(var30, false), SplitPaneTelemetry.Action.Toggle)
        end
    end

    tbl1.getSupportPaneEntryTarget = getSupportPaneEntryTarget
    tbl1.setSupportPaneEntryTarget = setSupportPaneEntryTarget
    tbl1.getSupportPaneTopRouteMatcher = getSupportPaneTopRouteMatcher
    tbl1.setSupportPaneTopRouteMatcher = setSupportPaneTopRouteMatcher
    tbl1.getSupportPaneTopRouteKey = getSupportPaneTopRouteKey
    tbl1.setSupportPaneTopRouteKey = setSupportPaneTopRouteKey
    var30 = tbl1

    if FFlagEnableSplitPaneTelemetry then
        local var31 = getShouldDefaultToCollapsed(false)
        local var32 = evaluateBreakpointEnabled(false)

        effect = Signals.createEffect(function(arg1)
            local var33 = getShouldDefaultToCollapsed(arg1)
            local bool1 = var33 ~= var31
            local var34 = evaluateBreakpointEnabled(arg1)
            if bool1 or var34 ~= var32 then
                local var35 = computeSupportPaneMode(false, var31)
                local telemetryStateFromMode = SplitPaneTelemetry.getTelemetryStateFromMode(if var32 and var30.getIsSplitEligible(false) then var35 else nil)

                local bool2 = not var32 or not var30.getIsSplitEligible(false) or var35 == SupportPaneMode.Collapsed
                if bool1 then
                    var11(nil)
                end
                if var30.getIsTelemetrySessionInitialized(false) then
                    local telemetryStateFromMode2 = SplitPaneTelemetry.getTelemetryStateFromMode(getSupportPaneModeIfActive(false))
                    if telemetryStateFromMode ~= telemetryStateFromMode2 then
                        SplitPaneTelemetry.logStateChanged(telemetryStateFromMode2, SplitPaneTelemetry.Action.ViewportChanged)
                    end
                    if bool2 ~= var30.getIsSplitPaneCollapsedOrNotActive(false) then
                        SplitPaneTelemetry.logSplitPaneViewChange(getTelemetrySnapshot(var30, false), SplitPaneTelemetry.Action.ViewportChanged)
                    end
                end
            end

            var31 = var33
            var32 = var34
        end)
    end
    return var30
end

local var2 = nil
local function getStore() -- Luacid: Inlined by compiler; 1 call site recovered
    if var2 == nil then
        var2 = createSplitPaneStore()
    end
    return var2
end

return {
    getStore = getStore,
    isSplitEnabledNow = function()
        local store = getStore()
        return store.getIsBreakpointEnabled(false) and store.getIsSplitEligible(false)
    end
}

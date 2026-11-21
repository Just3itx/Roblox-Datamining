-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T02:20:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalog = script:FindFirstAncestor("AvatarExperienceCatalog")

local AvatarExperienceCatalogParent = AvatarExperienceCatalog.Parent

local AppCommonLib = require(AvatarExperienceCatalogParent.AppCommonLib)
local AvatarExperienceCommon = require(AvatarExperienceCatalogParent.AvatarExperienceCommon)
local Constants = AvatarExperienceCommon.Constants
local Constants2 = require(AvatarExperienceCatalog.Constants)
local sendAXCounterV2 = require(AvatarExperienceCatalogParent.AvatarExperienceAnalytics).sendAXCounterV2

local Signals = require(AvatarExperienceCatalogParent.Signals)
local debounce = AvatarExperienceCommon.Utils.debounce

local getBreakpointFromRowWidth = require(AvatarExperienceCatalog.Utils.getBreakpointFromRowWidth)
local getCameraViewportSize = require(AvatarExperienceCatalog.Utils.getCameraViewportSize)
local WidgetListBreakPointEnum = require(AvatarExperienceCatalog.Components.ResultsList.WidgetListBreakPointEnum)

local FFlagEnableSplitPane = require(AvatarExperienceCatalogParent.SharedFlags).FFlagEnableSplitPane
local AvatarExperienceFlags = require(AvatarExperienceCatalogParent.AvatarExperienceFlags)
local FFlagAXMarketplaceBreakpointEstimateFix = AvatarExperienceFlags.FFlagAXMarketplaceBreakpointEstimateFix
local FFlagAXMarketplaceBreakpointMismatchCounter = AvatarExperienceFlags.FFlagAXMarketplaceBreakpointMismatchCounter

local LANDSCAPE_UI_WIDTH_PERCENTAGE = Constants.LANDSCAPE_UI_WIDTH_PERCENTAGE
local CATALOG_RESULTS_HORIZONTAL_MARGIN = Constants2.CATALOG_RESULTS_HORIZONTAL_MARGIN

local function getInitialScreenSizeEstimate()
    if AppCommonLib.isSpatial() then
        return WidgetListBreakPointEnum.XSmall
    end

    local currentCamera = workspace.CurrentCamera
    if not (currentCamera and currentCamera.ViewportSize) then
        return WidgetListBreakPointEnum.Medium
    end

    local viewportSize = currentCamera.ViewportSize
    local var1 = if viewportSize.X > viewportSize.Y then viewportSize.X * LANDSCAPE_UI_WIDTH_PERCENTAGE - CATALOG_RESULTS_HORIZONTAL_MARGIN * 2 - 10 else viewportSize.X
    return getBreakpointFromRowWidth(var1)
end

local function getSplitPaneCatalogWidthFraction() -- Luacid: Inlined by compiler; 1 call site recovered
    if not FFlagEnableSplitPane then
        return nil
    end
    local var1 = require(AvatarExperienceCatalogParent.SplitPane).SplitPaneStore.getStore()

    if var1.getIsBreakpointEnabled(false) then
        return 1 - var1.getSupportWidthFraction(false)
    end

    return nil
end

local function getScreenSizeEstimate()
    if AppCommonLib.isSpatial() then
        return WidgetListBreakPointEnum.XSmall
    end

    local cameraViewportSize = getCameraViewportSize()
    if cameraViewportSize == nil then
        return WidgetListBreakPointEnum.Medium
    end

    local var1 = require(AvatarExperienceCatalogParent.Display).GetDisplayStore(false)
    local guiInset = var1.getGuiInset(false)
    local var2 = cameraViewportSize.X - guiInset.left - guiInset.right
    local splitPaneCatalogWidthFraction = getSplitPaneCatalogWidthFraction()

    if splitPaneCatalogWidthFraction ~= nil then
        var2 *= splitPaneCatalogWidthFraction
    elseif cameraViewportSize.X > cameraViewportSize.Y then
        var2 *= LANDSCAPE_UI_WIDTH_PERCENTAGE
    end

    local num1 = math.max(var2 - CATALOG_RESULTS_HORIZONTAL_MARGIN * 2, 0)

    return getBreakpointFromRowWidth(num1, var1.getPlatformScale(false))
end

local function getOrientationDimension(): string -- Luacid: Inlined by compiler; 1 call site recovered
    local cameraViewportSize = getCameraViewportSize()

    if cameraViewportSize == nil then
        return "Unknown"
    end

    if cameraViewportSize.X > cameraViewportSize.Y then
        return "Landscape"
    end

    return "Portrait"
end

local function createAXMarketplaceWidgetStore()
    local bool1 = if FFlagAXMarketplaceBreakpointMismatchCounter then getCameraViewportSize() ~= nil else nil
    local var1 = if FFlagAXMarketplaceBreakpointEstimateFix then getScreenSizeEstimate() else getInitialScreenSizeEstimate()
    local getScreenSize, var3 = Signals.createSignal(var1)
    local getDebouncedScreenSize, var5 = Signals.createSignal(var1)
    local bool2 = false

    local getEstimateWriteId = 0
    local getEstimateWriteBreakpoint = nil

    local var7 = debounce(function(arg1)
        var5(arg1)
    end, 0.8)

    return {
        getScreenSize = getScreenSize,
        setScreenSize = function(arg1)
            if FFlagAXMarketplaceBreakpointEstimateFix then
                bool2 = true
            end
            var3(arg1)
            var7(arg1)
        end,
        getDebouncedScreenSize = getDebouncedScreenSize,
        reportMeasuredBreakpoint = function(measured, source: string)
            local fetched = getDebouncedScreenSize(false)

            sendAXCounterV2(Constants2.COUNTERS.MarketplaceBreakpointMeasured, {
                match = tostring(measured == fetched),
                fetched = fetched,
                measured = measured,
                source = source,
                orientation = getOrientationDimension(),
                hadCameraAtCreation = tostring(bool1),
                estimateFix = tostring(FFlagAXMarketplaceBreakpointEstimateFix)
            })
        end,
        refreshEstimate = function()
            if bool2 then
                return
            end
            local screenSizeEstimate = getScreenSizeEstimate()
            if FFlagAXMarketplaceBreakpointEstimateFix and getDebouncedScreenSize(false) ~= screenSizeEstimate then
                getEstimateWriteId += 1
                getEstimateWriteBreakpoint = screenSizeEstimate
            end
            var3(screenSizeEstimate)
            var5(screenSizeEstimate)
        end,
        getEstimateWriteId = function()
            return getEstimateWriteId
        end,
        getEstimateWriteBreakpoint = function()
            return getEstimateWriteBreakpoint
        end,
        wasScreenSizePublishedByEstimateWrite = function(num2: number, arg1): boolean
            return not (getEstimateWriteId == num2) and getEstimateWriteBreakpoint == arg1
        end
    }
end
return createAXMarketplaceWidgetStore

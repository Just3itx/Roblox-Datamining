-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:51:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local ImpressionsTrackerWithoutNavigation = require(script.ImpressionsTrackerWithoutNavigation)

return {
    ["jest.config"] = script["jest.config"],
    Constants = require(script.Constants),
    ImpressionsDetector = require(script.ImpressionsDetector),
    ImpressionsTaggerWrapper = require(script.ImpressionsTaggerWrapper),
    ImpressionsTagUtility = require(script.ImpressionsTagUtility),
    ImpressionsVisualizer = require(script.ImpressionsVisualizer),
    ScreenSizeImpressionsDetector = require(script.ScreenSizeImpressionsDetector),
    useImpressionsTagger = require(script.useImpressionsTagger),
    useBatchedImpressions = require(script.useBatchedImpressions),
    ImpressionsTracker = require(script.ImpressionsTracker),
    ImpressionsTrackerWithoutNavigation = ImpressionsTrackerWithoutNavigation,
    FrameBoundsImpressionsTracker = require(script.FrameBoundsImpressionsTracker),
    ScreenSizeImpressionsTracker = require(script.ScreenSizeImpressionsTracker),
    ContentThresholdImpressionsDetector = require(script.ContentThresholdImpressionsDetector),
    ViewportVisibilityImpressionsDetector = require(script.ViewportVisibilityImpressionsDetector)
}

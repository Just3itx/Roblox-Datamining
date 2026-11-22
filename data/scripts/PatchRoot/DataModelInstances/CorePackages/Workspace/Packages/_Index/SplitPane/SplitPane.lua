-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T21:21:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local AppSplitView = require(script.Parent.AppSplitView)

return {
    SplitPaneStore = require(script.Stores.SplitPaneStore),
    SplitPaneTelemetry = require(script.Telemetry.SplitPaneTelemetry),
    useSplitLayoutStatus = require(script.Hooks.useSplitLayoutStatus),
    useSplitPaneRender = require(script.Hooks.useSplitPaneRender),
    SplitPaneContext = require(script.Context.SplitPaneContext),
    PaneHostContext = require(script.Context.PaneHostContext),
    SplitPaneNavigationLayout = require(script.Components.SplitPaneNavigationLayout),
    isSupportPaneScreen = require(script.Utils.isSupportPaneScreen),
    isSupportPaneTopRoute = require(script.Utils.isSupportPaneTopRoute),
    expandSupportPaneIfCollapsed = require(script.Utils.supportPaneInputRules).expandSupportPaneIfCollapsed,
    routeIdentityMatches = require(script.Utils.routeIdentityMatches),
    SplitPaneVariant = require(script.Utils.SplitPaneVariant),
    getOnScreenContextValue = require(script.Utils.getOnScreenContextValue),
    OnScreenCardProvider = require(script.Components.OnScreenCardProvider),
    OnScreenStore = require(script.Stores.OnScreenStore),
    createNavigationHandle = require(script.Utils.createNavigationHandle),
    routeIdentity = require(script.Utils.routeIdentity),
    NavigateDownWithHandle = require(script.Thunks.NavigateDownWithHandle),
    SplitPaneSlot = AppSplitView.Enums.SplitPaneSlot,
    SplitL3SessionHelper = require(script.Utils.SplitL3SessionHelper),
    SplitL3SessionManager = require(script.Components.SplitL3SessionManager),
    SupportPaneMode = AppSplitView.Enums.SupportPaneMode,
    ["jest.config"] = script["jest.config"],
    getSplitPaneEducationalTourStore = require(script.Stores.getSplitPaneEducationalTourStore),
    SplitPaneEducationalTourCollapsedControl = require(script.Components.SplitPaneEducationalTourCollapsedControl),
    isSplitPaneTourSupported = require(script.Utils.isSplitPaneTourSupported)
}

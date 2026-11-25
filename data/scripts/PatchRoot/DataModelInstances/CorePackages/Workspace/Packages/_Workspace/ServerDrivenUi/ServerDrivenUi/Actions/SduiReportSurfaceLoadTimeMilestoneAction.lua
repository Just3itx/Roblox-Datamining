-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:10:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUiParent = script:FindFirstAncestor("ServerDrivenUi").Parent

local SduiCoreSystem = require(ServerDrivenUiParent.SduiCoreSystem)
local SduiErrorType = SduiCoreSystem.SduiErrors.SduiErrorType
local SduiActionType = SduiCoreSystem.SduiActionType
local SduiSharedUtilities = require(ServerDrivenUiParent.SduiSharedUtilities)
local getSduiClientPageScope = SduiSharedUtilities.getSduiClientPageScope
local SduiSurfaceLoadTimeTracker = SduiSharedUtilities.SduiSurfaceLoadTimeTracker

local Milestone = require(ServerDrivenUiParent.TimeToInteractiveTracker).TimeToInteractiveTracker.Milestone

local function SduiReportSurfaceLoadTimeMilestoneAction(arg1, _, arg2, _)
    local logger = arg2.dependencies and arg2.dependencies.logger
    local configKey = arg2.configKey
    local actionParams = arg1 and arg1.actionParams
    if not (actionParams and configKey) then
        if logger then
            logger.reportError(
                SduiErrorType.InvalidActionParams,
                {
                    name = SduiActionType.ReportSurfaceLoadTimeMilestone,
                    message = "Missing actionParams"
                },
                arg2.appPage
            )
        end

        return
    end

    local var1 = getSduiClientPageScope(configKey).get(SduiSurfaceLoadTimeTracker.SURFACE_LOAD_TIME_PAGE_SCOPE_KEY)
    if not var1 then
        if logger then
            logger.reportError(SduiErrorType.InvalidActionParams, {
                name = SduiActionType.ReportSurfaceLoadTimeMilestone,
                message = `No surface load timer in page scope for configKey={configKey}`
            }, arg2.appPage)
        end
        return
    end

    local milestone = actionParams.milestone
    if typeof(milestone) ~= "string" then
        if logger then
            logger.reportError(SduiErrorType.InvalidActionParams, {
                name = SduiActionType.ReportSurfaceLoadTimeMilestone,
                message = `Missing or invalid milestone param, got {typeof(milestone)}`
            }, arg2.appPage)
        end
        return
    end

    local metadata = if typeof(actionParams.metadata) == "table" then actionParams.metadata else nil

    if milestone == Milestone.SurfaceReady then
        var1.trackSurfaceReady(metadata)
        return
    end
    var1.trackOnce(milestone)
end

return SduiReportSurfaceLoadTimeMilestoneAction

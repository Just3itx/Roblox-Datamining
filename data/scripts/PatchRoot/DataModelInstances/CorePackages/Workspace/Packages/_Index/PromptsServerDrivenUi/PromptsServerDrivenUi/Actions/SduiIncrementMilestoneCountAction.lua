-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T12:50:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PromptsServerDrivenUi = script:FindFirstAncestor("PromptsServerDrivenUi")
local PromptsServerDrivenUiParent = PromptsServerDrivenUi.Parent

local SduiCoreSystem = require(PromptsServerDrivenUiParent.SduiCoreSystem)
local SduiErrorType = SduiCoreSystem.SduiErrors.SduiErrorType
local SduiParseHelpers = SduiCoreSystem.SduiParseHelpers
local incrementMilestoneCount = require(PromptsServerDrivenUi.Actions.incrementMilestoneCount)

local function SduiIncrementMilestoneCountAction(arg1, _, arg2)
    local actionParams = arg1 and arg1.actionParams or nil
    if actionParams == nil then
        arg2.dependencies.logger.reportError(
            SduiErrorType.InvalidActionParams,
            { name = "IncrementMilestoneCount", message = "Missing actionParams" },
            arg2.appPage
        )
        return
    end

    local milestoneId = actionParams.milestoneId
    if typeof(milestoneId) ~= "string" or milestoneId == "" then
        arg2.dependencies.logger.reportError(SduiErrorType.InvalidActionParams, {
            name = "IncrementMilestoneCount",
            message = `Invalid or missing milestoneId: {milestoneId}`,
            propName = "milestoneId"
        }, arg2.appPage)
        return
    end

    incrementMilestoneCount(arg2.dependencies.networking, milestoneId):catch(function(arg3)
        arg2.dependencies.logger.reportError(SduiErrorType.ActionNetworkRequestFailed, {
            name = "IncrementMilestoneCount",
            message = "incrementMilestoneCount failed: " .. SduiParseHelpers.stringifyValue(arg3)
        }, arg2.appPage)
    end)
end

return SduiIncrementMilestoneCountAction

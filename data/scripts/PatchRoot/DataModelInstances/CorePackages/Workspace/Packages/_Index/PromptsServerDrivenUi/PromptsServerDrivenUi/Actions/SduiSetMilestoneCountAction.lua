-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T12:50:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PromptsServerDrivenUi = script:FindFirstAncestor("PromptsServerDrivenUi")
local PromptsServerDrivenUiParent = PromptsServerDrivenUi.Parent

local SduiCoreSystem = require(PromptsServerDrivenUiParent.SduiCoreSystem)
local SduiErrorType = SduiCoreSystem.SduiErrors.SduiErrorType
local SduiParseHelpers = SduiCoreSystem.SduiParseHelpers
local setMilestoneCount = require(PromptsServerDrivenUi.Actions.setMilestoneCount)

local function SduiSetMilestoneCountAction(arg1, _, arg2)
    local actionParams = arg1 and arg1.actionParams or nil
    if actionParams == nil then
        arg2.dependencies.logger.reportError(
            SduiErrorType.InvalidActionParams,
            { name = "SetMilestoneCount", message = "Missing actionParams" },
            arg2.appPage
        )
        return
    end

    local milestoneId = actionParams.milestoneId
    if typeof(milestoneId) ~= "string" or milestoneId == "" then
        arg2.dependencies.logger.reportError(SduiErrorType.InvalidActionParams, {
            name = "SetMilestoneCount",
            message = `Invalid or missing milestoneId: {milestoneId}`,
            propName = "milestoneId"
        }, arg2.appPage)
        return
    end

    local count = actionParams.count
    if typeof(count) ~= "number" or count < 0 or count > 2147483647 or count ~= math.floor(count) then
        arg2.dependencies.logger.reportError(
            SduiErrorType.InvalidActionParams,
            {
                name = "SetMilestoneCount",
                message = `Invalid or missing count: {count}`,
                propName = "count"
            },
            arg2.appPage
        )
        return
    end

    setMilestoneCount(arg2.dependencies.networking, milestoneId, count):catch(function(arg3)
        arg2.dependencies.logger.reportError(
            SduiErrorType.ActionNetworkRequestFailed,
            {
                name = "SetMilestoneCount",
                message = "setMilestoneCount failed: " .. SduiParseHelpers.stringifyValue(arg3)
            },
            arg2.appPage
        )
    end)
end
return SduiSetMilestoneCountAction

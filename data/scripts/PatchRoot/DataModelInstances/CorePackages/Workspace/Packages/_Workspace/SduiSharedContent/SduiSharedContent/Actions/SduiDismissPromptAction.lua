-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T10:50:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedContent = script:FindFirstAncestor("SduiSharedContent")
local SduiSharedContentParent = SduiSharedContent.Parent

local SduiCoreSystem = require(SduiSharedContentParent.SduiCoreSystem)
local SduiErrorType = SduiCoreSystem.SduiErrors.SduiErrorType
local SduiParseHelpers = SduiCoreSystem.SduiParseHelpers

local SduiSharedUtilities = require(SduiSharedContentParent.SduiSharedUtilities)
local getSduiApiStore = SduiSharedUtilities.getSduiApiStore
local SduiLoadTimer = SduiSharedUtilities.SduiLoadTimer
local reportPromptDismiss = require(SduiSharedContent.Actions.reportPromptDismiss)

local function SduiDismissPromptAction(arg1, _, arg2)
    local actionParams = arg1 and arg1.actionParams or nil
    if actionParams == nil then
        arg2.dependencies.logger.reportError(
            SduiErrorType.InvalidActionParams,
            { name = "DismissPrompt", message = "Missing actionParams" },
            arg2.appPage
        )
        return
    end

    assert(actionParams, "actionParams must exist")

    local promptType = actionParams.promptType
    if typeof(promptType) ~= "string" then
        arg2.dependencies.logger.reportError(
            SduiErrorType.InvalidActionParams,
            {
                name = "DismissPrompt",
                message = `Invalid or missing promptType: {promptType}`,
                propName = "promptType"
            },
            arg2.appPage
        )
        return
    end

    local promptId = actionParams.promptId
    if promptId ~= nil and typeof(promptId) ~= "string" then
        arg2.dependencies.logger.reportError(
            SduiErrorType.InvalidActionParams,
            {
                name = "DismissPrompt",
                message = `Invalid promptId: {promptId}`,
                propName = "promptId"
            },
            arg2.appPage
        )
        return
    end

    local sduiApiStore = getSduiApiStore()
    local var1 = sduiApiStore.dismissEntry(promptType)

    local networking = arg2.dependencies.networking

    reportPromptDismiss(networking, promptType, promptId):andThen(function()
        for _, configKey in var1 do
            sduiApiStore.refreshFromApi({ configKey = configKey, loadTimer = SduiLoadTimer.createLoadTimer(configKey) })
        end
    end):catch(function(arg3)
        arg2.dependencies.logger.reportError(
            SduiErrorType.ActionNetworkRequestFailed,
            {
                name = "DismissPrompt",
                message = "reportPromptDismiss failed: " .. SduiParseHelpers.stringifyValue(arg3)
            },
            arg2.appPage
        )
    end)
end
return SduiDismissPromptAction

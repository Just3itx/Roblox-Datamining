-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:21:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CurrencyTransfers = script:FindFirstAncestor("CurrencyTransfers")
local CurrencyTransfersParent = CurrencyTransfers.Parent

local SduiCoreSystem = require(CurrencyTransfersParent.SduiCoreSystem)
local SduiActionType = SduiCoreSystem.SduiActionType
local SduiErrorType = SduiCoreSystem.SduiErrors.SduiErrorType
local SduiParseHelpers = SduiCoreSystem.SduiParseHelpers

local IncomingTransferHomepagePromptDismiss = require(CurrencyTransfers.Utils.IncomingTransferHomepagePromptDismiss)

local AppPage = require(CurrencyTransfersParent.RobloxAppEnums).AppPage
local NavigateDown = require(CurrencyTransfersParent.NavigationRodux).Thunks.NavigateDown
local SharedFlags = require(CurrencyTransfersParent.SharedFlags)
local FFlagSignalsNavP3Dispatch = SharedFlags.FFlagSignalsNavP3Dispatch
local NavigationCommands = if FFlagSignalsNavP3Dispatch then require(CurrencyTransfersParent.RobloxAppNavigation).NavigationCommands else nil
local FFlagSduiDismissPromptPageScope = SharedFlags.FFlagSduiDismissPromptPageScope

local function parseTransferRequestIdFromUrl(url: string)
    local str1 = string.lower(url)

    local var1 = string.find(str1, "transferrequestid=", 1, true)
    if not var1 then
        return nil
    end
    local str2 = string.sub(url, var1 + 18)
    local var2 = string.find(str2, "&", 1, true)
    if var2 then
        str2 = string.sub(str2, 1, var2 - 1)
    end

    return if str2 == "" then nil else str2
end

local function resolveTransferId(tbl1) -- Luacid: Inlined by compiler; 1 call site recovered
    local transferId = tbl1.transferId
    if typeof(transferId) == "string" and transferId ~= "" then
        return transferId
    end
    local url = tbl1.url
    if typeof(url) == "string" and url ~= "" then
        return (parseTransferRequestIdFromUrl(url))
    end
    return nil
end

local function SduiOpenIncomingTransferUpsellAction(arg1, _, arg2)
    local actionParams = if arg1 then arg1.actionParams or nil else nil

    if actionParams == nil then
        arg2.dependencies.logger.reportError(
            SduiErrorType.InvalidActionParams,
            {
                name = SduiActionType.OpenIncomingTransferUpsell,
                message = "Missing actionParams"
            },
            arg2.appPage
        )
        return
    end

    assert(actionParams, "actionParams must exist")
    local transferId = resolveTransferId(actionParams)

    if transferId == nil then
        arg2.dependencies.logger.reportError(SduiErrorType.InvalidActionParams, {
            name = SduiActionType.OpenIncomingTransferUpsell,
            message = "Invalid or missing transferId (set transferId or url with transferrequestid)",
            propName = "transferId"
        }, arg2.appPage)
        return
    end

    local promptType = actionParams.promptType
    if typeof(promptType) ~= "string" then
        arg2.dependencies.logger.reportError(SduiErrorType.InvalidActionParams, {
            name = SduiActionType.OpenIncomingTransferUpsell,
            message = `Invalid or missing promptType: {promptType}`,
            propName = "promptType"
        }, arg2.appPage)
        return
    end

    local promptId = actionParams.promptId
    if promptId ~= nil and typeof(promptId) ~= "string" then
        arg2.dependencies.logger.reportError(SduiErrorType.InvalidActionParams, {
            name = SduiActionType.OpenIncomingTransferUpsell,
            message = `Invalid promptId: {promptId}`,
            propName = "promptId"
        }, arg2.appPage)
        return
    end

    local networking = arg2.dependencies.networking

    local callbacks = IncomingTransferHomepagePromptDismiss.createCallbacks({
        networking = networking,
        promptId = promptId,
        optimisticHidePromptType = promptType,
        onReportPromptDismissFailed = function(arg3)
            arg2.dependencies.logger.reportError(SduiErrorType.ActionNetworkRequestFailed, {
                name = SduiActionType.OpenIncomingTransferUpsell,
                message = "reportPromptDismiss failed: " .. SduiParseHelpers.stringifyValue(arg3)
            }, arg2.appPage)
        end,
        configKey = if FFlagSduiDismissPromptPageScope then arg2.configKey else nil
    })

    local tbl1 = {
        name = AppPage.TransferRobuxFlow,
        extraProps = {
            direction = "receive",
            transferId = transferId,
            onPromptOptimisticHide = callbacks.optimisticHide,
            onPromptDismissCommitted = callbacks.commitDismiss
        }
    }

    if FFlagSignalsNavP3Dispatch then
        NavigationCommands.down(NavigationCommands.fromLegacyPage(tbl1))
        return
    end
    arg2.dependencies.dispatch(NavigateDown(tbl1))
end

return SduiOpenIncomingTransferUpsellAction

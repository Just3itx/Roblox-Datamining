-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:50:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CurrencyTransfersParent = script:FindFirstAncestor("CurrencyTransfers").Parent
local setPromptDismissedInPageScope = require(CurrencyTransfersParent.PromptsServerDrivenUi).setPromptDismissedInPageScope

local FFlagSduiDismissPromptPageScope = require(CurrencyTransfersParent.SharedFlags).FFlagSduiDismissPromptPageScope

local INCOMING_TRANSFER_HOMEPAGE_BANNER_PROMPT_TYPES = { "HomeIncomingRobuxTransferParentalGateBanner", "HomeIncomingRobuxTransferAgeGateBanner" }

local function dismissPromptTypes(dismissEntry: (...any) -> (...any), tbl2)
    local tbl3 = ({})
    local result = {}
    for _, value in tbl2 do
        for _, value2 in (dismissEntry(value)) do
            if not tbl3[value2] then
                tbl3[value2] = true
                table.insert(result, value2)
            end
        end
    end
    return result
end

local var1 = nil
var1 = FFlagSduiDismissPromptPageScope and function(str1: string?, tbl2)
    if typeof(str1) ~= "string" or str1 == "" then
        return
    end

    for _, value in tbl2 do
        setPromptDismissedInPageScope(str1, value)
    end
end or var1

local function reportDismissForAllPromptTypes(reportPromptDismiss: (...any) -> (...any), networking, tbl2, promptId: string?)
    local var2 = nil
    for _, value in tbl2 do
        local var3 = reportPromptDismiss(networking, value, promptId)
        if var2 == nil then
            var2 = var3
        else
            var2 = var2:andThen(function()
                return var3
            end)
        end
    end
    return var2
end

return {
    createCallbacks = function(tbl2)
        local promptId = tbl2.promptId
        local onReportPromptDismissFailed = tbl2.onReportPromptDismissFailed
        local tbl3 = INCOMING_TRANSFER_HOMEPAGE_BANNER_PROMPT_TYPES

        return {
            optimisticHide = function()
                local dismissEntry = require(CurrencyTransfersParent.SduiSharedUtilities).getSduiApiStore().dismissEntry
                if not FFlagSduiDismissPromptPageScope and dismissEntry == nil then
                    return
                end

                local optimisticHidePromptType = tbl2.optimisticHidePromptType
                if typeof(optimisticHidePromptType) == "string" and optimisticHidePromptType ~= "" then
                    if FFlagSduiDismissPromptPageScope then
                        if dismissEntry ~= nil then
                            dismissEntry(optimisticHidePromptType)
                        end
                        var1(tbl2.configKey, { optimisticHidePromptType })
                        return
                    end
                    dismissEntry(optimisticHidePromptType)
                elseif FFlagSduiDismissPromptPageScope then
                    if dismissEntry ~= nil then
                        dismissPromptTypes(dismissEntry, tbl3)
                    end
                    var1(tbl2.configKey, tbl3)
                else
                    dismissPromptTypes(dismissEntry, tbl3)
                end
            end,
            commitDismiss = function()
                local sduiSharedUtilities = require(CurrencyTransfersParent.SduiSharedUtilities)
                local sduiApiStore = sduiSharedUtilities.getSduiApiStore()
                local dismissEntry = sduiApiStore.dismissEntry
                local tbl4 = {}
                if FFlagSduiDismissPromptPageScope then
                    var1(tbl2.configKey, tbl3)
                end
                if dismissEntry ~= nil then
                    tbl4 = dismissPromptTypes(dismissEntry, tbl3)
                end

                local networking = tbl2.networking
                if networking == nil then
                    return
                end

                local reportPromptDismiss = require(CurrencyTransfersParent.SduiSharedContent).reportPromptDismiss

                reportDismissForAllPromptTypes(reportPromptDismiss, networking, tbl3, promptId):andThen(function()
                    if dismissEntry == nil then
                        return
                    end

                    for _, configKey in tbl4 do
                        sduiApiStore.refreshFromApi(
                            {
                                configKey = configKey,
                                loadTimer = sduiSharedUtilities.SduiLoadTimer.createLoadTimer(configKey)
                            }
                        )
                    end
                end):catch(function(arg1)
                    if onReportPromptDismissFailed then
                        onReportPromptDismissFailed(arg1)
                    end
                end)
            end
        }
    end,
    INCOMING_TRANSFER_HOMEPAGE_BANNER_PROMPT_TYPES = INCOMING_TRANSFER_HOMEPAGE_BANNER_PROMPT_TYPES
}

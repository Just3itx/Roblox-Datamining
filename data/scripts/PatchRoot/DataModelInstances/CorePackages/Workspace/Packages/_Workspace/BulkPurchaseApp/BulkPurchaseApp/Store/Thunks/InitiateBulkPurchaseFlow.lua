-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T22:51:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BulkPurchaseApp = script:FindFirstAncestor("BulkPurchaseApp")
local BulkPurchaseAppParent = BulkPurchaseApp.Parent
local Promise = require(BulkPurchaseAppParent.Promise)

local BulkPurchaseRequested = require(BulkPurchaseApp.Store.Actions.BulkPurchaseRequested)
local BulkPurchaseFailed = require(BulkPurchaseApp.Store.Actions.BulkPurchaseFailed)
local BulkPurchaseStarted = require(BulkPurchaseApp.Store.Actions.BulkPurchaseStarted)
local BulkPurchaseCountersEnum = require(BulkPurchaseApp.Enums.BulkPurchaseCountersEnum)
local ErrorCodeEnum = require(BulkPurchaseApp.Enums.ErrorCodeEnum)
local getAccount = require(BulkPurchaseApp.NetworkRequests.getAccount)
local reportBulkPurchaseRequestCounters = require(BulkPurchaseApp.Utils.reportBulkPurchaseRequestCounters)
local _Types = require(BulkPurchaseApp.Store.Types)

local FFlagBulkPurchaseRemoveStartedAction = require(BulkPurchaseApp.Flags.FFlagBulkPurchaseRemoveStartedAction)
local FFlagBulkPurchaseReportCounters = require(BulkPurchaseApp.Flags.FFlagBulkPurchaseReportCounters)
local FFlagAXAddOffersToBulkPurchase = require(BulkPurchaseApp.Flags.FFlagAXAddOffersToBulkPurchase)

local function InitiateBulkPurchaseFlow(arg1, tbl1, arg2, num1: number, num2: number, arg3, arg4, arg5)
    return function(arg6)
        if FFlagAXAddOffersToBulkPurchase then
            arg6:dispatch(BulkPurchaseRequested(tbl1, arg2, num1, num2, arg3, arg4, arg5))
        else
            arg6:dispatch(BulkPurchaseRequested(tbl1, arg2, num1, num2, arg3, arg4))
        end

        if FFlagBulkPurchaseReportCounters then
            reportBulkPurchaseRequestCounters(BulkPurchaseCountersEnum.BulkPurchaseRequestedCounter)
        end
        if FFlagBulkPurchaseRemoveStartedAction then
            return
        end
        local var1, _ = getAccount(arg1)
        return Promise.all({ var1 }):andThen(function(_)
            arg6:dispatch(BulkPurchaseStarted(num1))
        end):catch(function(_)
            arg6:dispatch(BulkPurchaseFailed(ErrorCodeEnum.Generic))
        end)
    end
end

return InitiateBulkPurchaseFlow

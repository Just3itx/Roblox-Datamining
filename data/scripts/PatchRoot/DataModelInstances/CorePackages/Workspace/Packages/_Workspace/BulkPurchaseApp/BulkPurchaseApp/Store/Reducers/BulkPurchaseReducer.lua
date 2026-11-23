-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T22:51:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BulkPurchaseApp = script:FindFirstAncestor("BulkPurchaseApp")
local BulkPurchaseAppParent = BulkPurchaseApp.Parent
local Rodux = require(BulkPurchaseAppParent.Rodux)

local BulkPurchasePromptStateEnum = require(BulkPurchaseApp.Enums.BulkPurchasePromptStateEnum)
local BulkPurchaseEnded = require(BulkPurchaseApp.Store.Actions.BulkPurchaseEnded)
local BulkPurchaseSucceeded = require(BulkPurchaseApp.Store.Actions.BulkPurchaseSucceeded)
local BulkPurchaseFailed = require(BulkPurchaseApp.Store.Actions.BulkPurchaseFailed)
local BulkPurchaseStarted = require(BulkPurchaseApp.Store.Actions.BulkPurchaseStarted)
local BulkPurchaseRequested = require(BulkPurchaseApp.Store.Actions.BulkPurchaseRequested)
local BulkPurchaseRefreshed = require(BulkPurchaseApp.Store.Actions.BulkPurchaseRefreshed)
local BulkPurchaseDisablePurchase = require(BulkPurchaseApp.Store.Actions.BulkPurchaseDisablePurchase)

local _Types = require(BulkPurchaseApp.Store.Types)

local FFlagBulkPurchaseRemoveStartedAction = require(BulkPurchaseApp.Flags.FFlagBulkPurchaseRemoveStartedAction)
local FFlagAXAddPlusUpsellToBulkPurchase = require(BulkPurchaseApp.Flags.FFlagAXAddPlusUpsellToBulkPurchase)
local FFlagAXAddOffersToBulkPurchase = require(BulkPurchaseApp.Flags.FFlagAXAddOffersToBulkPurchase)

local function createInitialState() -- Luacid: Inlined by compiler; 2 call sites recovered
    return {
        promptState = BulkPurchasePromptStateEnum.None
    }
end

local createReducer = Rodux.createReducer
local initialState = createInitialState()
local tbl1 = {}
tbl1[BulkPurchaseEnded.name] = function(_, _)
    return createInitialState()
end

tbl1[BulkPurchaseSucceeded.name] = function(arg1, arg2)
    local var1 = table.clone(arg1)
    var1.itemStatuses = arg2.itemStatuses
    var1.promptState = arg2.promptState
    if FFlagAXAddPlusUpsellToBulkPurchase then
        var1.disablePurchase = false
    end
    return var1
end

tbl1[BulkPurchaseFailed.name] = function(arg1, arg2)
    local var1 = table.clone(arg1)
    var1.errorCode = arg2.errorCode
    var1.promptState = BulkPurchasePromptStateEnum.Error
    var1.errorMetadata = arg2.errorMetadata
    if FFlagAXAddPlusUpsellToBulkPurchase then
        var1.disablePurchase = false
    end
    return var1
end

tbl1[BulkPurchaseRequested.name] = function(arg1, arg2)
    local var1 = table.clone(arg1)
    var1.itemData = arg2.itemData
    var1.options = arg2.options
    var1.orderRequest = arg2.orderRequest
    var1.balance = arg2.balance
    var1.totalCost = arg2.totalCost
    var1.discountInformation = arg2.discountInformation
    if FFlagBulkPurchaseRemoveStartedAction then
        var1.promptState = BulkPurchasePromptStateEnum.Request
    end
    if FFlagAXAddOffersToBulkPurchase then
        var1.offerData = arg2.offerData
    end
    return var1
end

tbl1[BulkPurchaseRefreshed.name] = function(arg1, arg2)
    local var1 = table.clone(arg1)
    var1.itemData = arg2.itemData
    var1.options = arg2.options
    var1.orderRequest = arg2.orderRequest
    var1.balance = arg2.balance
    var1.totalCost = arg2.totalCost
    var1.discountInformation = arg2.discountInformation
    var1.disablePurchase = false
    if FFlagAXAddOffersToBulkPurchase then
        var1.offerData = arg2.offerData
    end
    return var1
end

tbl1[BulkPurchaseDisablePurchase.name] = function(arg1, _)
    local var1 = table.clone(arg1)
    var1.disablePurchase = true
    return var1
end

tbl1[BulkPurchaseStarted.name] = function(arg1, arg2)
    local var1 = table.clone(arg1)
    var1.promptState = BulkPurchasePromptStateEnum.Request
    var1.balance = arg2.balance
    return var1
end

return (createReducer(initialState, tbl1))

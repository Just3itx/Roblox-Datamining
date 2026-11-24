-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:50:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CommercePurchaseApp = script:FindFirstAncestor("CommercePurchaseApp")
local CommercePurchaseAppParent = CommercePurchaseApp.Parent
local Rodux = require(CommercePurchaseAppParent.Rodux)

local CommercePurchasePromptStateEnum = require(CommercePurchaseApp.Enums.CommercePurchasePromptStateEnum)
local CommercePurchaseEnded = require(CommercePurchaseApp.Store.Actions.CommercePurchaseEnded)
local CommercePurchaseFailed = require(CommercePurchaseApp.Store.Actions.CommercePurchaseFailed)
local CommercePurchaseStarted = require(CommercePurchaseApp.Store.Actions.CommercePurchaseStarted)
local CommercePurchaseCheckout = require(CommercePurchaseApp.Store.Actions.CommercePurchaseCheckout)

local _Types = require(CommercePurchaseApp.Store.Types)

local function createInitialState() -- Luacid: Inlined by compiler; 2 call sites recovered
    return {
        promptState = CommercePurchasePromptStateEnum.None
    }
end

local createReducer = Rodux.createReducer
local initialState = createInitialState()
local tbl1 = {}
tbl1[CommercePurchaseEnded.name] = function(_, _)
    return createInitialState()
end

tbl1[CommercePurchaseFailed.name] = function(arg1, arg2)
    local var1 = table.clone(arg1)
    var1.errorCode = arg2.errorCode
    var1.promptState = CommercePurchasePromptStateEnum.Error
    return var1
end

tbl1[CommercePurchaseStarted.name] = function(arg1, arg2)
    local var1 = table.clone(arg1)
    var1.promptState = CommercePurchasePromptStateEnum.Started
    var1.commerceProductId = arg2.commerceProductId
    return var1
end

tbl1[CommercePurchaseCheckout.name] = function(arg1, arg2)
    local var1 = table.clone(arg1)
    var1.promptState = CommercePurchasePromptStateEnum.Checkout
    var1.checkoutSessionId = arg2.checkoutSessionId
    return var1
end

return (createReducer(initialState, tbl1))

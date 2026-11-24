-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:50:39Z
-- Luau bytecode version: 14 | Luau type version: 3
local CommercePurchaseAppParent = script:FindFirstAncestor("CommercePurchaseApp").Parent
local Rodux = require(CommercePurchaseAppParent.Rodux)
local CurrentToastMessagesReducer = require(CommercePurchaseAppParent.ToastLite).Reducers.CurrentToastMessagesReducer

local PromptStateReducer = require(script.Parent.PromptStateReducer)

return Rodux.combineReducers(
    {
        commercePurchaseState = PromptStateReducer,
        currentToastMessages = CurrentToastMessagesReducer
    }
)

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:21:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")
local PurchasePromptParent = PurchasePrompt.Parent
local enumerate = require(PurchasePromptParent.PurchasePromptDeps).enumerate

local addRawValueMethodToEnum = require(PurchasePrompt.Utils.addRawValueMethodToEnum)

local module = {}

local tbl1 = {
    None = "None",
    ConfirmedU13PaymentModal = "ConfirmedU13PaymentModal",
    ConfirmedU13MonthlyThreshold1Modal = "ConfirmedU13MonthlyThreshold1Modal",
    ConfirmedU13MonthlyThreshold2Modal = "ConfirmedU13MonthlyThreshold2Modal",
    ConfirmedParentalConsentWarningPaymentModal13To17 = "ConfirmedParentalConsentWarningPaymentModal13To17"
}

module.UserActionType = enumerate(script.Name, tbl1)
addRawValueMethodToEnum(module.UserActionType, tbl1)

function module.Post(arg1, str1: string)
    local var1 = module.UserActionType.toRawValue(str1)
    return arg1.postPurchaseWarningAcknowledge(var1)
end

return module

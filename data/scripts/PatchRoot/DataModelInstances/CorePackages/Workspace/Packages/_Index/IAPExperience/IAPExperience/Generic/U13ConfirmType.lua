-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:11:08Z
-- Luau bytecode version: 14 | Luau type version: 3
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local addRawValueMethodToEnum = require(scriptParentParent.Utility.addRawValueMethodToEnum)

local tbl1 = {
    None = "None",
    U13PaymentModal = "U13PaymentModal",
    U13MonthlyThreshold1Modal = "U13MonthlyThreshold1Modal",
    U13MonthlyThreshold2Modal = "U13MonthlyThreshold2Modal",
    ParentalConsentWarningPaymentModal13To17 = "ParentalConsentWarningPaymentModal13To17"
}
local var1 = require(scriptParentParentParent.enumerate)(script.Name, tbl1)

addRawValueMethodToEnum(var1, tbl1)

return var1

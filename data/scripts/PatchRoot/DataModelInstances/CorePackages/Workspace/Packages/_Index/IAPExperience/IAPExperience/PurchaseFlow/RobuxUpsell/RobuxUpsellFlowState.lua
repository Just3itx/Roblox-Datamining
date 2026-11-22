-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:21:15Z
-- Luau bytecode version: 14 | Luau type version: 3
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local addRawValueMethodToEnum = require(scriptParentParentParent.Utility.addRawValueMethodToEnum)

local tbl1 = {
    None = "None",
    Loading = "Loading",
    PurchaseModal = "PurchaseModal",
    GenericPurchaseModal = "GenericPurchaseModal",
    LargeRobuxPurchaseModal = "LargeRobuxPurchaseModal",
    PurchaseWarning = "PurchaseWarning",
    TwoStepRequired = "TwoStepRequired",
    RobuxPurchasePending = "RobuxPurchasePending",
    RobuxGrantPending = "RobuxGrantPending",
    ItemPurchasePending = "ItemPurchasePending",
    Success = "Success",
    LeaveRobloxWarning = "LeaveRobloxWarning",
    Error = "Error",
    PurchaseVPCModal = "PurchaseVPCModal"
}
local var1 = require(scriptParentParentParentParent.enumerate)(script.Name, tbl1)

addRawValueMethodToEnum(var1, tbl1)

return var1

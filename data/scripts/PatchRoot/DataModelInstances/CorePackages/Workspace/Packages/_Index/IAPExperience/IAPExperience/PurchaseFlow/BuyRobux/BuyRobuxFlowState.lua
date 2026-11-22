-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:21:09Z
-- Luau bytecode version: 14 | Luau type version: 3
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local addRawValueMethodToEnum = require(scriptParentParentParent.Utility.addRawValueMethodToEnum)

local tbl1 = {
    None = "None",
    Loading = "Loading",
    BuyRobux = "BuyRobux",
    PurchaseWarning = "PurchaseWarning",
    RobuxPurchasePending = "RobuxPurchasePending",
    RobuxGrantPending = "RobuxGrantPending",
    Error = "Error",
    Succeed = "Succeed",
    PurchaseVPC = "PurchaseVPC"
}
local var1 = require(scriptParentParentParentParent.enumerate)(script.Name, tbl1)

addRawValueMethodToEnum(var1, tbl1)

return var1

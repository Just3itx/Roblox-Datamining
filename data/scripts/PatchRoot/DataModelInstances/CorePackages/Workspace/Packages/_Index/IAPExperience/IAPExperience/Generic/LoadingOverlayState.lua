-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:10:49Z
-- Luau bytecode version: 14 | Luau type version: 3
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local addRawValueMethodToEnum = require(scriptParentParent.Utility.addRawValueMethodToEnum)

local tbl1 = {
    None = "None",
    Loading = "Loading",
    PurchasingItem = "PurchasingItem",
    PurchasingRobux = "PurchasingRobux",
    WaitingForPurchase = "WaitingForPurchase",
    WaitingForRobux = "WaitingForRobux"
}
local var1 = require(scriptParentParentParent.enumerate)(script.Name, tbl1)

addRawValueMethodToEnum(var1, tbl1)

return var1

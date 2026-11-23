-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T22:51:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BulkPurchaseApp = script:FindFirstAncestor("BulkPurchaseApp")

local _Types = require(BulkPurchaseApp.Store.Types)

local function convertToDiscountInformationOrNil(arg1): {[any]: any}?
    return if type(arg1) == "table" then if next(arg1) == nil then nil else arg1 else nil
end

return convertToDiscountInformationOrNil

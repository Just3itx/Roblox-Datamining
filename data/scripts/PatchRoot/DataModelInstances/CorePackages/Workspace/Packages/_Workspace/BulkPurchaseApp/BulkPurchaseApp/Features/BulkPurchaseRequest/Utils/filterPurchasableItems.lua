-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T22:41:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BulkPurchaseApp = script:FindFirstAncestor("BulkPurchaseApp")

local _Types = require(BulkPurchaseApp.Store.Types)
local PurchasableStateEnum = require(BulkPurchaseApp.Enums.PurchasableStateEnum)

local function filterPurchasableItems(tbl1)
    local result = {}
    for _, value in tbl1 do
        if value.purchasableState == PurchasableStateEnum.Purchasable then
            table.insert(result, value)
        end
    end
    return result
end

return filterPurchasableItems

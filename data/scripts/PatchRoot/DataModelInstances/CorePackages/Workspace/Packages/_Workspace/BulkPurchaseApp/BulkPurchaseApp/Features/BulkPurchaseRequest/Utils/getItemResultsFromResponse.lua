-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T22:41:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BulkPurchaseApp = script:FindFirstAncestor("BulkPurchaseApp")

local _Types = require(BulkPurchaseApp.Store.Types)
local filterPurchasableItems = require(script.Parent.filterPurchasableItems)
local getLineItemsFromPurchaseResponse = require(script.Parent.getLineItemsFromPurchaseResponse)
local lineItemToStatus = require(script.Parent.lineItemToStatus)

local function getItemResultsFromResponse(tbl1, tbl2)
    local var1 = filterPurchasableItems(tbl2)
    local lineItemsFromPurchaseResponse = getLineItemsFromPurchaseResponse(tbl1)

    local itemResultsFromResponse = {}
    for value, value2 in var1 do
        local var2 = lineItemsFromPurchaseResponse[value]
        if var2 then
            itemResultsFromResponse[value2.id] = lineItemToStatus(var2)
        end
    end
    return itemResultsFromResponse
end

return getItemResultsFromResponse

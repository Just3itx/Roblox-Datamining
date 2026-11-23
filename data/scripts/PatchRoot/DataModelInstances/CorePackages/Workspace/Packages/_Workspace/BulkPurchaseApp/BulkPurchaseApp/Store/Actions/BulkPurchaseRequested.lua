-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T22:51:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BulkPurchaseApp = script:FindFirstAncestor("BulkPurchaseApp")
local BulkPurchaseAppParent = BulkPurchaseApp.Parent
local Rodux = require(BulkPurchaseAppParent.Rodux)

local _Types = require(BulkPurchaseApp.Store.Types)
local FFlagAXAddOffersToBulkPurchase = require(BulkPurchaseApp.Flags.FFlagAXAddOffersToBulkPurchase)

return Rodux.makeActionCreator("BulkPurchaseRequested", function(itemData, orderRequest, balance: number, totalCost: number, options, discountInformation, offerData)
    local tbl1 = {
        itemData = itemData,
        balance = balance,
        totalCost = totalCost,
        orderRequest = orderRequest,
        options = options,
        discountInformation = discountInformation,
        offerData = 0
    }

    if not FFlagAXAddOffersToBulkPurchase then
        offerData = nil
    end

    tbl1.offerData = offerData
    return tbl1
end)

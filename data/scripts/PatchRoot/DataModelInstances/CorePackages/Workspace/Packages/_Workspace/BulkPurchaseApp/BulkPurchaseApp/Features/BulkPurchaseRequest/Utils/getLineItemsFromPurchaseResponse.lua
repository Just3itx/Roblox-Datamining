-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T22:41:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local bool1 = game:DefineFastFlag("BulkPurchaseHandleMissingFulfillmentGroupsKey", false)

local function getLineItemsFromPurchaseResponse(tbl1)
    if bool1 then
        if tbl1.fulfillmentGroups and tbl1.fulfillmentGroups[1] and tbl1.fulfillmentGroups[1].lineItems then
            return tbl1.fulfillmentGroups[1].lineItems
        end

        return {}
    end

    if tbl1.fulfillmentGroups[1] then
        return tbl1.fulfillmentGroups[1].lineItems
    end

    return {}
end

return getLineItemsFromPurchaseResponse

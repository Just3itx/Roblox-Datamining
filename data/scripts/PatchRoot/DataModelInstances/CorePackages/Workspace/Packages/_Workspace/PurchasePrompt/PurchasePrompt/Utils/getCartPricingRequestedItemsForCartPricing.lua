-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:51:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")
local ProductTypeEnum = require(PurchasePrompt.types).ProductTypeEnum

local function buildPermanentRowsFromIds(tbl1)
    local var1 = table.create(#tbl1)
    for _, collectibleItemId in tbl1 do
        if type(collectibleItemId) == "string" and collectibleItemId ~= "" then
            table.insert(var1, { collectibleItemId = collectibleItemId, isPermanent = true })
        end
    end
    return var1
end

local function getCartPricingRequestedItemsForCartPricing(collectibleItemId: string?, arg1, arg2)
    if type(arg1) ~= "table" or arg1.kind ~= ProductTypeEnum.Look then
        if collectibleItemId == nil or collectibleItemId == "" then
            return nil
        end

        local tbl1 = { collectibleItemId = collectibleItemId }
        if type(arg1) == "table" and arg1.kind == ProductTypeEnum.Asset then
            local timedOptionDays = arg1.timedOptionDays
            if type(timedOptionDays) == "number" and timedOptionDays > 0 then
                tbl1.rentalDays = timedOptionDays
            end
        end
        if tbl1.rentalDays == nil then
            tbl1.isPermanent = true
        end

        return { tbl1 }
    end

    local cartPricingRequestedItems = arg1.cartPricingRequestedItems
    if type(cartPricingRequestedItems) ~= "table" or not (#cartPricingRequestedItems > 0) then
        local collectibleItemIds = if type(arg2) == "table" then arg2.collectibleItemIds else nil

        if type(collectibleItemIds) == "table" and #collectibleItemIds > 0 then
            local permanentRowsFromIds = buildPermanentRowsFromIds(collectibleItemIds)
            if #permanentRowsFromIds > 0 then
                return permanentRowsFromIds
            end
        end
        return nil
    end

    local var1 = table.create(#cartPricingRequestedItems)
    for _, cartPricingRequestedItem in cartPricingRequestedItems do
        local rentalDays = cartPricingRequestedItem.rentalDays
        local bool1 = type(rentalDays) == "number" and rentalDays > 0
        local tbl1 = {
            collectibleItemId = cartPricingRequestedItem.collectibleItemId,
            rentalDays = 0,
            isPermanent = 0
        }

        if not bool1 then
            rentalDays = nil
        end

        tbl1.rentalDays = rentalDays
        tbl1.isPermanent = not bool1 or nil
        table.insert(var1, tbl1)
    end

    return var1
end

return getCartPricingRequestedItemsForCartPricing

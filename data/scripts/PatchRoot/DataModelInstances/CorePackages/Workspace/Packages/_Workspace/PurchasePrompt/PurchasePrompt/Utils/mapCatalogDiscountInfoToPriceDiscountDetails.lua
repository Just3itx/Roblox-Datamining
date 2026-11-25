-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T08:00:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function mapCatalogDiscountInfoToPriceDiscountDetails(arg1)
    if type(arg1) ~= "table" or type(arg1.discounts) ~= "table" or #arg1.discounts == 0 then
        return nil
    end

    local result = {}
    for _, discount in ipairs(arg1.discounts) do
        table.insert(result, {
            Type = discount.discountCampaign or "",
            AmountInRobux = discount.robuxDiscountAmount or 0,
            Percent = discount.robuxDiscountPercentage or 0,
            LocalizedDiscountAttribution = discount.localizedDiscountAttribution
        })
    end

    return result
end

return mapCatalogDiscountInfoToPriceDiscountDetails

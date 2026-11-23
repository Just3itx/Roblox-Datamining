-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T12:51:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local tbl1 = {
    sort = "sortEnumValue",
    filterSalesType = "filterSalesTypeEnumValue",
    filterCreators = "filterCreatorsTypeEnumValue",
    filterPrice = "filterPriceEnumValue",
    filterUnavailableItems = "filterUnavailableItemsEnumValue"
}

local function aliasSortAndFiltersToLegacyKeys(arg1)
    if type(arg1) ~= "table" then
        return arg1
    end

    local var1 = table.clone(arg1)
    for value, value2 in tbl1 do
        local var2 = arg1[value]
        if var2 ~= nil then
            var1[value2] = var2
        end
    end

    return var1
end

return aliasSortAndFiltersToLegacyKeys

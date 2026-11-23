-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:00:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceAnalyticsParent = script:FindFirstAncestor("AvatarExperienceAnalytics").Parent

local FFlagAXUnifiedEventStrictPayloads = require(AvatarExperienceAnalyticsParent.AvatarExperienceFlags).FFlagAXUnifiedEventStrictPayloads

local tbl1 = {
    {
        protoKey = "sort",
        aliases = { "sortEnumValue" }
    },
    {
        protoKey = "filterSalesType",
        aliases = { "filterSalesTypeEnumValue" }
    },
    {
        protoKey = "filterCreators",
        aliases = { "filterCreatorsType", "filterCreatorsTypeEnumValue" }
    },
    {
        protoKey = "filterPrice",
        aliases = { "filterPriceEnumValue" }
    },
    {
        protoKey = "filterUnavailableItems",
        aliases = { "filterUnavailableItemsEnumValue" }
    }
}

local tbl2 = ({})
for _, value in tbl1 do
    for _, value2 in value.aliases do
        tbl2[value2] = true
    end
end

local function mapAnalyticsMetadataFields(tbl3, bool1: boolean?)
    local result = ({})
    if tbl3 == nil then
        return result
    end

    for value, value2 in tbl3 do
        if FFlagAXUnifiedEventStrictPayloads and bool1 and tbl2[value] then
            result[value] = value2
        end
        if not tbl2[value] then
            result[value] = value2
        end
    end

    for _, value in tbl1 do
        if result[value.protoKey] ~= nil then
            continue
        end

        for _, value2 in value.aliases do
            if tbl3[value2] ~= nil then
                result[value.protoKey] = tbl3[value2]
                break
            end
        end
    end

    return result
end

return mapAnalyticsMetadataFields

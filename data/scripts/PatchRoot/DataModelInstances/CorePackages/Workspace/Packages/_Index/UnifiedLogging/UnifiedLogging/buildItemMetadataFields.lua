-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T01:20:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UnifiedLoggingParent = script:FindFirstAncestor("UnifiedLogging").Parent

local DiscoveryEventErrorLogger = require(UnifiedLoggingParent.DiscoveryUtils).DiscoveryEventErrorLogger

local FFlagUnifiedLoggingCoerceMetadataFieldValues = require(UnifiedLoggingParent.SharedFlags).FFlagUnifiedLoggingCoerceMetadataFieldValues

local tbl1 = {
    collectionId = true,
    collectionPosition = true,
    contentType = true,
    id = true,
    itemPosition = true,
    itemsPerRow = true,
    rowNumber = true,
    totalNumberOfItems = true
}

local function shouldIgnoreKey(str1: string) -- Luacid: Inlined by compiler; 1 call site recovered
    return tbl1[str1]
end

local function buildItemMetadataFields(tbl2, tbl3, collectionId)
    local tbl4 = ({})

    for value, entryIndex in tbl2 do
        local var1 = if tbl3 then tbl3[entryIndex] or nil else nil

        if var1 ~= nil then
            for value3, value4 in var1 do
                if shouldIgnoreKey(value3) then
                    continue
                end

                if tbl4[value3] == nil then
                    tbl4[value3] = {}
                end
                local var2 = tbl4[value3]
                if FFlagUnifiedLoggingCoerceMetadataFieldValues then
                    var2[value] = tostring(value4)
                else
                    var2[value] = value4
                end
            end
        else
            DiscoveryEventErrorLogger.reportError(
                "buildMetadataFields",
                "Entry was nil when building item metadataFields for collection",
                { entryIndex = entryIndex, collectionId = collectionId }
            )
        end
    end

    for value, _ in tbl4 do
        for i = 1, #tbl2 do
            if tbl4[value][i] == nil then
                tbl4[value][i] = ""
            end
        end
    end

    local itemMetadataFields = {}
    for value, value2 in tbl4 do
        itemMetadataFields[`{value}_arr`] = table.concat(value2, ",")
    end
    return itemMetadataFields
end

return buildItemMetadataFields

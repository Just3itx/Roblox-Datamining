-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T04:30:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function getInvalidAssetIdsToAssetTypeIdMap(tbl1, tbl2)
    local invalidAssetIdsToAssetTypeIdMap = ({})
    for value, value2 in tbl1 do
        if not tbl2[value] then
            invalidAssetIdsToAssetTypeIdMap[value] = value2
        end
    end
    return invalidAssetIdsToAssetTypeIdMap
end

return getInvalidAssetIdsToAssetTypeIdMap

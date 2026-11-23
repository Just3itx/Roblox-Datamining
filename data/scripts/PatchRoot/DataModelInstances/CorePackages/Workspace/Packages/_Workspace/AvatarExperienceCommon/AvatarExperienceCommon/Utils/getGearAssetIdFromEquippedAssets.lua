-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:51:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function getGearAssetIdFromEquippedAssets(tbl1)
    local var1 = nil
    local var2 = tbl1[tostring(Enum.AssetType.Gear.Value)]
    if var2 then
        local var3, _ = next(var2)
        if var3 then
            var1 = tonumber(var3)
        end
    end
    return var1
end

return getGearAssetIdFromEquippedAssets

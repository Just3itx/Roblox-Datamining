-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:51:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommonParent = script:FindFirstAncestor("AvatarExperienceCommon").Parent
local FStringAXBackendDrivenCatalogLayersNames = require(AvatarExperienceCommonParent.AvatarExperienceFlags).FStringAXBackendDrivenCatalogLayersNames

return function()
    local var1 = FStringAXBackendDrivenCatalogLayersNames()

    if not var1 or var1 == "" then
        return nil
    end

    local tbl1 = {}
    for _, value in string.split(var1, ",") do
        local var2 = string.gsub(value, "^%s*(.-)%s*$", "%1")
        if var2 ~= "" and string.len(var2) <= 200 then
            table.insert(tbl1, var2)
        end
    end

    return #tbl1 > 0 and tbl1 or nil
end

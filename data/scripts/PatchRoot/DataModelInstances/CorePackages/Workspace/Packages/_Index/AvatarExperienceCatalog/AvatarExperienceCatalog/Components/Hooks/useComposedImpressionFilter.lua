-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:51:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalogParent = script:FindFirstAncestor("AvatarExperienceCatalog").Parent

local React = require(AvatarExperienceCatalogParent.React)

local function useComposedImpressionFilter(tbl1)
    return React.useCallback(function(num1: number)
        for _, value in tbl1 do
            if not value(num1) then
                return false
            end
        end
        return true
    end, tbl1)
end

return useComposedImpressionFilter

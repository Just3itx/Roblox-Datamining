-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T02:11:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalogParent = script:FindFirstAncestor("AvatarExperienceCatalog").Parent

local React = require(AvatarExperienceCatalogParent.React)
local useDispatch = require(AvatarExperienceCatalogParent.RoactUtils).Hooks.RoactRodux.useDispatch

local function useClearSduiFocusedSort(tbl1)
    local var1 = useDispatch()
    return React.useCallback(function(str1: string?)
        if not str1 then
            return
        end

        var1(tbl1.ClearWidgetInfo(nil, str1))
    end, { var1, tbl1.ClearWidgetInfo })
end

return useClearSduiFocusedSort

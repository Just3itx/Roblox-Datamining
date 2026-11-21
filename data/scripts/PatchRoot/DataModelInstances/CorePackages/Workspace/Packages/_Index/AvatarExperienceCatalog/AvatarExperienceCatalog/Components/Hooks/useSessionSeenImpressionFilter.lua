-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:51:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalogParent = script:FindFirstAncestor("AvatarExperienceCatalog").Parent

local React = require(AvatarExperienceCatalogParent.React)

local SeenImpressionsStore = require(AvatarExperienceCatalogParent.AvatarExperienceAnalytics).Store.SeenImpressionsStore
local Category = SeenImpressionsStore.Category

local function useSessionSeenImpressionFilter(str1: string)
    return React.useCallback(function(num1: number): boolean
        local str2 = "CatalogSort_" .. str1 .. "_" .. num1
        if SeenImpressionsStore.hasSeen(Category.WidgetItems, str2) then
            return false
        end
        SeenImpressionsStore.markSeen(Category.WidgetItems, str2)
        return true
    end, { str1 })
end

return useSessionSeenImpressionFilter

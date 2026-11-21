-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T02:10:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalogParent = script:FindFirstAncestor("AvatarExperienceCatalog").Parent

local Logging = require(AvatarExperienceCatalogParent.AppCommonLib).Logging

local function resolveSduiFocusedSortContext(tbl1)
    local selectedCategoryId = tbl1.selectedCategoryId
    if not selectedCategoryId then
        Logging.warn(
            "resolveSduiFocusedSortContext: nil selectedCategoryId at click time " .. "(sortId=" .. tostring(tbl1.sortId) .. ", route=" .. tostring(tbl1.routeName) .. "); SDUI See All handoff aborted before context lookup."
        )
        return nil
    end
    local contextForWidgetsById = tbl1.getContextForWidgetsById(tbl1.routeName, selectedCategoryId, tbl1.selectedSubcategoryId)
    if contextForWidgetsById then
        return contextForWidgetsById
    end

    Logging.warn(
        "resolveSduiFocusedSortContext: getContextForWidgetsById returned nil "
            .. "(sortId="
                .. tostring(tbl1.sortId)
                    .. ", route="
                        .. tostring(tbl1.routeName)
                            .. ", categoryId=" .. tostring(selectedCategoryId) .. ", subcategoryId=" .. tostring(tbl1.selectedSubcategoryId) .. "); SDUI See All handoff aborted because the reader-aligned ContextWidgetInfo key could not be built."
    )
    return nil
end

return resolveSduiFocusedSortContext

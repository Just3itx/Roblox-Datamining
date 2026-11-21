-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:51:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalog = script:FindFirstAncestor("AvatarExperienceCatalog")
local AvatarExperienceCatalogParent = AvatarExperienceCatalog.Parent

local React = require(AvatarExperienceCatalogParent.React)

local _AvatarExperienceCommon = require(AvatarExperienceCatalogParent.AvatarExperienceCommon)

local ImpressionEnums = require(AvatarExperienceCatalogParent.AvatarExperienceAnalytics).Enums.ImpressionEnums

local useCatalogPageMonolithDependencies = require(AvatarExperienceCatalog.Providers.useCatalogPageMonolithDependencies)

local function useCatalogSortSeeAllLogging(callback: ((...any) -> (...any))?, arg1)
    local catalogAnalytics = useCatalogPageMonolithDependencies().catalogAnalytics

    local var1 = React.useRef(nil)

    local var2 = React.useCallback(function()
        catalogAnalytics.widgetInteractionV2(arg1, ImpressionEnums.ActionType.SEE_ALL)
        if callback then
            callback()
        end
    end, { callback, catalogAnalytics, arg1 })

    if callback then
        return var1, var2
    end

    return var1, nil
end

return useCatalogSortSeeAllLogging

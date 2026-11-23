-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:40:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommon = script:FindFirstAncestor("AvatarExperienceCommon")
local AvatarExperienceCommonParent = AvatarExperienceCommon.Parent
local AvatarScreen = require(AvatarExperienceCommonParent.AvatarExperienceNavigation).Enums.AvatarScreen
local FFlagUseNavigationSelectors = require(AvatarExperienceCommonParent.SharedFlags).FFlagUseNavigationSelectors
local FFlagSignalsNavP3gAvatarExperience = require(AvatarExperienceCommonParent.SharedFlags).FFlagSignalsNavP3gAvatarExperience
local Selectors = require(AvatarExperienceCommonParent.NavigationRodux).Selectors
local GetLegacyNavigationStore = require(AvatarExperienceCommonParent.NavigationRodux).GetLegacyNavigationStore
local selectCurrentAvatarRoute = require(AvatarExperienceCommon.State.Selectors.selectCurrentAvatarRoute)

local function selectSearchKeyword(arg1)
    local var1 = if FFlagSignalsNavP3gAvatarExperience then GetLegacyNavigationStore(false).getCurrentRoute(false) elseif FFlagUseNavigationSelectors then arg1.Navigation and Selectors.selectCurrentRoactNavigationRoute(arg1) else arg1.Navigation and arg1.Navigation.currentRoute
    local searchKeyword = var1 and var1.params and var1.params.searchParams and var1.params.searchParams.searchKeyword
    if searchKeyword then
        return searchKeyword
    end

    local var2 = selectCurrentAvatarRoute(arg1)
    if not var2 or var2.name ~= AvatarScreen.CatalogSearch then
        return nil
    end

    local key = var2.key
    return arg1.Search
        and arg1.Search.SearchesInCatalog
        and arg1.Search.SearchesInCatalog[key]
        and arg1.Search.SearchesInCatalog[key].keyword
end

return selectSearchKeyword

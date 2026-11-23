-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:40:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommonParent = script:FindFirstAncestor("AvatarExperienceCommon").Parent
local FFlagUseNavigationSelectors = require(AvatarExperienceCommonParent.SharedFlags).FFlagUseNavigationSelectors
local FFlagSignalsNavP3gAvatarExperience = require(AvatarExperienceCommonParent.SharedFlags).FFlagSignalsNavP3gAvatarExperience
local Selectors = require(AvatarExperienceCommonParent.NavigationRodux).Selectors
local GetLegacyNavigationStore = require(AvatarExperienceCommonParent.NavigationRodux).GetLegacyNavigationStore

local function selectCurrentAvatarRoute(arg1)
    local var1 = if FFlagSignalsNavP3gAvatarExperience then GetLegacyNavigationStore(false).getCurrentRoute(false) elseif FFlagUseNavigationSelectors then arg1.Navigation and Selectors.selectCurrentRoactNavigationRoute(arg1) else arg1.Navigation and arg1.Navigation.currentRoute
    local fromAvatarRoute = var1 and var1.params and var1.params.fromAvatarRoute
    return fromAvatarRoute and fromAvatarRoute.current
end

return selectCurrentAvatarRoute

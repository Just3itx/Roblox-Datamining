-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T11:11:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DiscoveryUtilsParent = script:FindFirstAncestor("DiscoveryUtils").Parent
local AppPage = require(DiscoveryUtilsParent.RobloxAppEnums).AppPage

local OmniRecommendationsPageType = { PAGE_TYPE_HOME = "Home" }

return {
    toAppPage = function(pageTypeHome: string)
        return if pageTypeHome == OmniRecommendationsPageType.PAGE_TYPE_HOME then AppPage.Home else nil
    end,
    fromAppPage = function(home: string): string?
        return if home == AppPage.Home then OmniRecommendationsPageType.PAGE_TYPE_HOME else nil
    end,
    OmniRecommendationsPageType = OmniRecommendationsPageType
}

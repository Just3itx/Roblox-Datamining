-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:31:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommonParent = script:FindFirstAncestor("AvatarExperienceCommon").Parent
local AppUserLayers = require(AvatarExperienceCommonParent.ExperimentLayers).AppUserLayers
local IXPUtils = require(AvatarExperienceCommonParent.IXPUtils)

game:DefineFastFlag("AXRecentlyViewedSearchItemsEnabled4", false)

game:DefineFastFlag("AXRecentlyViewedSearchItemsEnabledForAll4", false)

game:DefineFastFlag("AXRecentlyViewedSearchItemsPositionTop4", false)
game:DefineFastFlag("AXRecentlyViewedSearchItemsSaveInCatalog4", false)

return IXPUtils.defineIXPTest({
    name = "AvatarMarketplace.UA.RecentlyViewedSearchItems",
    recordExposure = false,
    layer = AppUserLayers.AvatarExperienceUASearchView,
    getIsUserInExperiment = function(arg1): boolean
        return not (arg1.enableRecentlyViewedItems == nil or arg1.recentlyViewedSearchItemsPositionTop == nil)
            and arg1.recentlyViewedSearchItemsSaveInCatalog ~= nil
    end,
    getDependentFlagsEnabled = function(): boolean
        return true
    end,
    getEnabledFlag = function(): boolean
        return game:GetFastFlag("AXRecentlyViewedSearchItemsEnabled4")
    end,
    getEnabledForAllFlag = function(): boolean
        return game:GetFastFlag("AXRecentlyViewedSearchItemsEnabledForAll4")
    end,
    variables = {
        EnabledForUser = function(arg1, arg2)
            return arg2 or arg1.enableRecentlyViewedItems
        end,
        EnabledTopVariant = function(arg1): boolean
            local recentlyViewedSearchItemsPositionTop = arg1.recentlyViewedSearchItemsPositionTop
            return game:GetFastFlag("AXRecentlyViewedSearchItemsPositionTop4") or recentlyViewedSearchItemsPositionTop == true
        end,
        EnabledSaveInCatalog = function(arg1): boolean
            local recentlyViewedSearchItemsSaveInCatalog = arg1.recentlyViewedSearchItemsSaveInCatalog
            return game:GetFastFlag("AXRecentlyViewedSearchItemsSaveInCatalog4") or recentlyViewedSearchItemsSaveInCatalog == true
        end
    }
})

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T02:21:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalogParent = script:FindFirstAncestor("AvatarExperienceCatalog").Parent

local AvatarExperienceFlags = require(AvatarExperienceCatalogParent.AvatarExperienceFlags)
local FFlagAXCatalogCategoriesSDUI = AvatarExperienceFlags.FFlagAXCatalogCategoriesSDUI
local FFlagAXMigrateAllTabToSduiDev = AvatarExperienceFlags.FFlagAXMigrateAllTabToSduiDev
local FFlagAXSortsBodyTabRecExposureLogging = AvatarExperienceFlags.FFlagAXSortsBodyTabRecExposureLogging

local FFlagAXEnableTaxonomyM20ExposureLoggingClothing = AvatarExperienceFlags.FFlagAXEnableTaxonomyM20ExposureLoggingClothing

local FFlagAXEnableTaxonomyM21ExposureLoggingClothing = AvatarExperienceFlags.FFlagAXEnableTaxonomyM21ExposureLoggingClothing
local FStringAXSortsBodyTabRecLayerName = AvatarExperienceFlags.FStringAXSortsBodyTabRecLayerName
local FStringAXTaxonomyM20ExperimentLayerName = AvatarExperienceFlags.FStringAXTaxonomyM20ExperimentLayerName
local FStringAXTaxonomyM21ExperimentLayerName = AvatarExperienceFlags.FStringAXTaxonomyM21ExperimentLayerName

local IXPServiceWrapper = require(AvatarExperienceCatalogParent.IxpServiceWrapper).IXPServiceWrapper

local AvatarExperienceCommon = require(AvatarExperienceCatalogParent.AvatarExperienceCommon)
local CatalogCategories = require(AvatarExperienceCatalogParent.AvatarExperienceModel).Enums.CatalogCategories
local CatalogSDUICategoryIds = AvatarExperienceCommon.Enums.CatalogSDUICategoryIds
local CatalogCategoryKeys = AvatarExperienceCommon.Enums.CatalogCategoryKeys

local function logEditorTaxonomyExposureIfApplicable(str1: string?)
    if FFlagAXEnableTaxonomyM20ExposureLoggingClothing or FFlagAXEnableTaxonomyM21ExposureLoggingClothing then
        local var1 = if FFlagAXMigrateAllTabToSduiDev then CatalogCategoryKeys.Clothing elseif FFlagAXCatalogCategoriesSDUI then CatalogSDUICategoryIds.Clothing:rawValue() else CatalogCategories.Clothing:rawValue()

        if str1 == var1 then
            if FFlagAXEnableTaxonomyM20ExposureLoggingClothing then
                IXPServiceWrapper:LogFlagLinkedUserLayerExposure(FStringAXTaxonomyM20ExperimentLayerName)
            end
            if FFlagAXEnableTaxonomyM21ExposureLoggingClothing then
                IXPServiceWrapper:LogFlagLinkedUserLayerExposure(FStringAXTaxonomyM21ExperimentLayerName)
            end
        end
    end

    if not FFlagAXSortsBodyTabRecExposureLogging then
        return
    end

    local var1 = if FFlagAXMigrateAllTabToSduiDev then CatalogCategoryKeys.Body elseif FFlagAXCatalogCategoriesSDUI then CatalogSDUICategoryIds.Body:rawValue() else CatalogCategories.Body:rawValue()

    if str1 == var1 then
        IXPServiceWrapper:LogFlagLinkedUserLayerExposure(FStringAXSortsBodyTabRecLayerName)
    end
end

return logEditorTaxonomyExposureIfApplicable

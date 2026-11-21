-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T02:10:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalogParent = script:FindFirstAncestor("AvatarExperienceCatalog").Parent

local _AvatarExperienceCommon = require(AvatarExperienceCatalogParent.AvatarExperienceCommon)
local _DataHydration = require(AvatarExperienceCatalogParent.DataHydration)

local AvatarExperienceFlags = require(AvatarExperienceCatalogParent.AvatarExperienceFlags)
local FFlagAXM41AllCategoriesToTaxonomy = AvatarExperienceFlags.FFlagAXM41AllCategoriesToTaxonomy
local FFlagAXSduiCatalogSearchShowWidgets = AvatarExperienceFlags.FFlagAXSduiCatalogSearchShowWidgets
local FFlagAXSduiCatalogTaxonomyFromServer = AvatarExperienceFlags.FFlagAXSduiCatalogTaxonomyFromServer

local HttpService = game:GetService("HttpService")

local tbl1 = { AllAnimations = "AllAnimation", AnimationBundles = "Animation", Emotes = "Emotes" }

local tbl2 = {
    Recommended = {
        Name = "All",
        CategoryFilter = "Recommended",
        ShowWidgets = if FFlagAXSduiCatalogSearchShowWidgets then true else nil,
        ShowSponsored = if FFlagAXSduiCatalogSearchShowWidgets then true else nil,
        ShowTopics = if FFlagAXSduiCatalogSearchShowWidgets then true else nil
    },
    HighDefinition = { CategoryFilter = "HighDefinition" }
}

local function widgetContextFromName(name: string): string -- Luacid: Inlined by compiler; 1 call site recovered
    local var1 = name:gsub(" ", "-"):gsub("%.", "-")
    return `catalog-tab:{string.lower(var1)}`
end

local function createMapMarketplaceCategoryToCatalogCategory()
    local tbl3 = ({})

    local function getOrCreateSearchUuid(id: string) -- Luacid: Inlined by compiler; 1 call site recovered
        local var1 = tbl3[id]
        if var1 then
            return var1
        end
        local str1 = HttpService:GenerateGUID(true)
        tbl3[id] = str1
        return str1
    end

    local function mapInternal(arg1, tbl4, bool1: boolean?, tbl5)
        tbl5[arg1.id] = true
        local tbl6

        if arg1.subcategories and #arg1.subcategories > 0 then
            tbl6 = {}
            for _, value in arg1.subcategories do
                if tbl5[value] then
                    continue
                end

                local var1 = tbl4[value]
                if var1 then
                    table.insert(tbl6, mapInternal(var1, tbl4, true, tbl5))
                end
            end

            if #tbl6 == 0 then
                tbl6 = nil
            end
        else
            tbl6 = nil
        end

        tbl5[arg1.id] = nil

        local var1 = tbl2[arg1.id]
        return {
            Id = arg1.id,
            Name = if var1 and var1.Name then var1.Name else arg1.name,
            CategoryFilter = if var1 then var1.CategoryFilter else nil,
            ShowWidgets = if FFlagAXSduiCatalogSearchShowWidgets and var1 then var1.ShowWidgets else nil,
            ShowSponsored = if FFlagAXSduiCatalogSearchShowWidgets and var1 then var1.ShowSponsored else nil,
            ShowTopics = if FFlagAXSduiCatalogSearchShowWidgets and var1 then var1.ShowTopics else nil,
            Title = arg1.title,
            LocalizedTitle = arg1.title,
            WidgetContext = widgetContextFromName(arg1.name),
            SearchUuid = getOrCreateSearchUuid(arg1.id),
            TaxonomyUuid = if (FFlagAXSduiCatalogTaxonomyFromServer or FFlagAXM41AllCategoriesToTaxonomy)
                and arg1.taxonomyId ~= nil
                and arg1.taxonomyId ~= "" then arg1.taxonomyId else nil,
            AssetTypeIdStrings = arg1.assetTypes,
            BundleTypes = arg1.bundleTypes,
            TileType = arg1.tileType,
            TimeToRefresh = arg1.timeToRefresh,
            CategoryId = arg1.categoryId,
            SubcategoryId = arg1.subcategoryId,
            CameraFocus = arg1.cameraFocus,
            CameraZoomRadius = arg1.cameraZoomRadius,
            CanAnimateCameraBasedMood = arg1.canAnimateCameraBasedMood,
            LooksWidgetContextForOrganicContent = if arg1.looksWidgetContextForOrganicContent == nil or arg1.looksWidgetContextForOrganicContent == "" then nil else arg1.looksWidgetContextForOrganicContent,
            PageType = tbl1[arg1.name],
            Subcategories = tbl6,
            isSubcategory = if bool1 then true else nil
        }
    end

    return {
        map = function(arg1, tbl4, bool1: boolean?)
            return mapInternal(arg1, tbl4, bool1, {})
        end,
        clear = function()
            table.clear(tbl3)
        end
    }
end
return createMapMarketplaceCategoryToCatalogCategory

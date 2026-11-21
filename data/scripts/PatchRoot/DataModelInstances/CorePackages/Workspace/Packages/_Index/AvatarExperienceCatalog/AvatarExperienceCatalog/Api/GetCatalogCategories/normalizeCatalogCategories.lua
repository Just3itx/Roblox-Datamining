-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:40:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalog = script:FindFirstAncestor("AvatarExperienceCatalog")
local AvatarExperienceCatalogParent = AvatarExperienceCatalog.Parent
local normalize = require(AvatarExperienceCatalogParent.AvatarExperienceCommon).Utils.normalize
local normalizeBoolean = normalize.normalizeBoolean
local normalizeString = normalize.normalizeString
local normalizeNumber = normalize.normalizeNumber
local makeNormalizeTableFn = normalize.makeNormalizeTableFn
local normalizeNotEmptyString = normalize.normalizeNotEmptyString

local HttpService = game:GetService("HttpService")

local _CatalogCategories = require(AvatarExperienceCatalog.Models.CatalogCategories)

local FFlagAXCatalogCategoriesSDUI = require(AvatarExperienceCatalogParent.AvatarExperienceFlags).FFlagAXCatalogCategoriesSDUI

local function SearchUuid(): string -- Luacid: Inlined by compiler; 2 call sites recovered
    return HttpService:GenerateGUID(true)
end

local function extractShowCatalogContentActionRequestParams(tbl1)
    local var1 = nil
    if tbl1.props and tbl1.props.OnActivated then
        for _, value in tbl1.props.OnActivated do
            if value.componentType == "ShowCatalogContentAction" then
                return value.props and value.props.requestParams
            end
        end
    end
    return var1
end

local function extractWidgetContext(tbl1)
    local var1 = nil
    if tbl1.props and tbl1.props.OnActivated then
        for _, value in tbl1.props.OnActivated do
            if value.componentType == "ShowWidgetContentAction" then
                return value.props and value.props.requestParams and value.props.requestParams.context
            end
        end
    end
    return var1
end

local function stringToBoolean(arg1) -- Luacid: Inlined by compiler; 4 call sites recovered
    if type(arg1) == "boolean" then
        return arg1, nil
    elseif type(arg1) == "string" then
        if arg1 == "True" then
            return true, nil
        elseif arg1 == "False" then
            return false, nil
        end
        return nil, "Invalid boolean string value, expected \"True\" or \"False\""
    else
        return nil, "Expected boolean or string"
    end
end

local function splitCommaSeparatedString(str1: string?)
    if not str1 or str1 == "" then
        return nil
    end

    local tbl1 = {}

    for _, value in string.split(str1, ",") do
        if value ~= "" then
            table.insert(tbl1, value)
        end
    end

    return #tbl1 > 0 and tbl1 or nil
end

local function normalizeAssetTypeIdStrings(tbl1) -- Luacid: Inlined by compiler; 1 call site recovered
    local var1 = extractShowCatalogContentActionRequestParams(tbl1)
    local assetTypeIds = var1 and var1.assetTypeIds

    if assetTypeIds == nil or assetTypeIds == "" then
        return nil, nil
    end

    local var2, var3 = normalizeString(assetTypeIds)
    if var3 then
        return nil, var3
    end

    return splitCommaSeparatedString(var2), nil
end

local function normalizeBundleTypes(tbl1) -- Luacid: Inlined by compiler; 1 call site recovered
    local var1 = extractShowCatalogContentActionRequestParams(tbl1)
    local bundleTypeIds = var1 and var1.bundleTypeIds

    if bundleTypeIds == nil or bundleTypeIds == "" then
        return nil, nil
    end

    local var2, var3 = normalizeString(bundleTypeIds)
    if var3 then
        return nil, var3
    end

    return splitCommaSeparatedString(var2), nil
end

local function normalizeTaxonomy(tbl1) -- Luacid: Inlined by compiler; 1 call site recovered
    local var1 = extractShowCatalogContentActionRequestParams(tbl1)
    local taxonomyId = var1 and var1.taxonomyId

    local var2, var3 = normalizeNotEmptyString(taxonomyId)
    return var2, var3
end

local function normalizeWidgetContext(tbl1) -- Luacid: Inlined by compiler; 1 call site recovered
    return extractWidgetContext(tbl1), nil
end

local function normalizeSearchUuid() -- Luacid: Inlined by compiler; 1 call site recovered
    return SearchUuid(), nil
end

local function normalizePillTitle(tbl1) -- Luacid: Inlined by compiler; 3 call sites recovered
    local pillTitle = tbl1.props and tbl1.props.pillTitle

    if FFlagAXCatalogCategoriesSDUI then
        local var1, var2 = normalizeNotEmptyString(pillTitle)
        return var1, var2
    end
    local var1, var2 = normalizeString(pillTitle)

    return var1, var2
end

local function normalizePillId(tbl1) -- Luacid: Inlined by compiler; 1 call site recovered
    local pillId = tbl1.props and tbl1.props.pillId

    if FFlagAXCatalogCategoriesSDUI then
        local var1, var2 = normalizeNotEmptyString(pillId)
        return var1, var2
    end
    local var1, var2 = normalizeString(pillId)

    return var1, var2
end

local function normalizeTimeToRefresh(tbl1) -- Luacid: Inlined by compiler; 1 call site recovered
    local timeToRefresh = tbl1.props and tbl1.props.timeToRefresh
    if timeToRefresh == nil or timeToRefresh == "" then
        return nil, nil
    end

    if type(timeToRefresh) == "string" then
        timeToRefresh = tonumber(timeToRefresh)
    end

    if timeToRefresh == nil then
        return nil, nil
    end
    local var1, var2 = normalizeNumber(timeToRefresh)
    return var1, var2
end

local function normalizeCameraFocus(tbl1) -- Luacid: Inlined by compiler; 1 call site recovered
    local cameraFocus = tbl1.props and tbl1.props.cameraFocus
    local var1, var2 = normalizeNotEmptyString(cameraFocus)
    return var1, var2
end

local function normalizeCameraZoomRadius(tbl1) -- Luacid: Inlined by compiler; 1 call site recovered
    local cameraZoomRadius = tbl1.props and tbl1.props.cameraZoomRadius
    if cameraZoomRadius == nil or cameraZoomRadius == "" then
        return nil, nil
    end

    if type(cameraZoomRadius) == "string" then
        cameraZoomRadius = tonumber(cameraZoomRadius)
    end

    if cameraZoomRadius == nil then
        return nil, nil
    end
    local var1, var2 = normalizeNumber(cameraZoomRadius)
    return var1, var2
end

local function normalizeCanAnimateCameraBasedMood(tbl1) -- Luacid: Inlined by compiler; 1 call site recovered
    local canAnimateCameraBasedMood = tbl1.props and tbl1.props.canAnimateCameraBasedMood
    if canAnimateCameraBasedMood == nil or canAnimateCameraBasedMood == "" then
        return nil, nil
    end

    local var1, var2 = stringToBoolean(canAnimateCameraBasedMood)

    if var2 then
        return nil, var2
    end

    local var3, var4 = normalizeBoolean(var1)
    return var3, var4
end

local function normalizeDisableFilters(tbl1) -- Luacid: Inlined by compiler; 1 call site recovered
    local disableFilters = tbl1.props and tbl1.props.disableFilters
    if disableFilters == nil or disableFilters == "" then
        return nil, nil
    end

    local var1, var2 = stringToBoolean(disableFilters)

    if var2 then
        return nil, var2
    end

    local var3, var4 = normalizeBoolean(var1)
    return var3, var4
end

local function normalizePageType(tbl1) -- Luacid: Inlined by compiler; 1 call site recovered
    local pageType = tbl1.props and tbl1.props.pageType
    local var1, var2 = normalizeNotEmptyString(pageType)
    return var1, var2
end

local function normalizeLooksWidgetContextForOrganicContent(tbl1) -- Luacid: Inlined by compiler; 1 call site recovered
    local var1 = extractShowCatalogContentActionRequestParams(tbl1)
    local context = var1 and var1.context

    if context == nil or context == "" then
        return nil, nil
    end

    local var2, var3 = normalizeString(context)
    return var2, var3
end

local function normalizeTooltipKey(tbl1) -- Luacid: Inlined by compiler; 1 call site recovered
    local tooltipKey = tbl1.props and tbl1.props.tooltipKey
    local var1, var2 = normalizeNotEmptyString(tooltipKey)
    return var1, var2
end

local function normalizeTooltipBody(tbl1) -- Luacid: Inlined by compiler; 1 call site recovered
    local tooltipBody = tbl1.props and tbl1.props.tooltipBody
    local var1, var2 = normalizeNotEmptyString(tooltipBody)
    return var1, var2
end

local function normalizeTileType(tbl1) -- Luacid: Inlined by compiler; 1 call site recovered
    local tileType = tbl1.props and tbl1.props.tileType
    local var1, var2 = normalizeNotEmptyString(tileType)
    return var1, var2
end

local var1 = nil

local function func1(tbl1)
    if not tbl1.props or not tbl1.props.Configs or type(tbl1.props.Configs) ~= "table" then
        return nil, nil
    end

    local tbl2 = {}
    local tbl3 = {}
    for _, config in tbl1.props.Configs do
        local var2, var3 = var1(config)
        if var3 then
            table.insert(tbl3, var3)
        end
        if var2 and not var3 then
            table.insert(tbl2, var2)
        end
    end

    return tbl2, if next(tbl3) then table.concat(tbl3, " ") else nil
end

local function normalizeCategoryOrSubcategory(arg1, tbl1)
    if type(arg1) ~= "table" then
        return nil, "Config must be a table"
    end

    local tbl2 = {}
    local id, var3 = normalizePillId(arg1)

    if var3 then
        table.insert(tbl2, "Id: " .. var3)
    end

    local var4, var5 = normalizePillTitle(arg1)

    if var5 then
        table.insert(tbl2, "Name: " .. var5)
    end

    local localizedTitle, var7 = normalizePillTitle(arg1)

    if var7 then
        table.insert(tbl2, "LocalizedTitle: " .. var7)
    end

    local title, var9 = normalizePillTitle(arg1)

    if var9 then
        table.insert(tbl2, "Title: " .. var9)
    end

    local searchUuid, var10 = normalizeSearchUuid()

    if var10 then
        table.insert(tbl2, "SearchUuid: " .. var10)
    end

    local assetTypeIdStrings, var12 = normalizeAssetTypeIdStrings(arg1)

    if var12 then
        table.insert(tbl2, "AssetTypeIdStrings: " .. var12)
    end

    local bundleTypes, var14 = normalizeBundleTypes(arg1)

    if var14 then
        table.insert(tbl2, "BundleTypes: " .. var14)
    end

    local var15

    if FFlagAXCatalogCategoriesSDUI then
        local var16
        var15, var16 = normalizeTaxonomy(arg1)

        if var16 then
            table.insert(tbl2, "Taxonomy: " .. var16)
        end
    else
        var15 = nil
    end

    local widgetContext, var17 = normalizeWidgetContext(arg1)

    if var17 then
        table.insert(tbl2, "WidgetContext: " .. var17)
    end

    local timeToRefresh, var19 = normalizeTimeToRefresh(arg1)

    if var19 then
        table.insert(tbl2, "TimeToRefresh: " .. var19)
    end

    local cameraFocus, var21 = normalizeCameraFocus(arg1)

    if var21 then
        table.insert(tbl2, "CameraFocus: " .. var21)
    end

    local cameraZoomRadius, var23 = normalizeCameraZoomRadius(arg1)

    if var23 then
        table.insert(tbl2, "CameraZoomRadius: " .. var23)
    end

    local var24

    if tbl1.isSubcategory then
        var24 = nil
    else
        local var25
        var24, var25 = func1(arg1)
        if var25 then
            table.insert(tbl2, "Subcategories: " .. var25)
        end
    end

    local canAnimateCameraBasedMood, var26 = normalizeCanAnimateCameraBasedMood(arg1)

    if var26 then
        table.insert(tbl2, "CanAnimateCameraBasedMood: " .. var26)
    end

    local disableFilters, var28 = normalizeDisableFilters(arg1)

    if var28 then
        table.insert(tbl2, "DisableFilters: " .. var28)
    end

    local pageType, var30 = normalizePageType(arg1)

    if var30 then
        table.insert(tbl2, "PageType: " .. var30)
    end

    local looksWidgetContextForOrganicContent, var32 = normalizeLooksWidgetContextForOrganicContent(arg1)

    if var32 then
        table.insert(tbl2, "LooksWidgetContextForOrganicContent: " .. var32)
    end

    local tooltipKey, var34 = normalizeTooltipKey(arg1)

    if var34 then
        table.insert(tbl2, "TooltipKey: " .. var34)
    end

    local tooltipBody, var36 = normalizeTooltipBody(arg1)

    if var36 then
        table.insert(tbl2, "TooltipBody: " .. var36)
    end

    local tileType, var38 = normalizeTileType(arg1)

    if var38 then
        table.insert(tbl2, "TileType: " .. var38)
    end

    if #tbl2 > 0 then
        return nil, (if tbl1.isSubcategory then "Subcategory" else "Category") .. " normalization failed: " .. table.concat(tbl2, "; ")
    end

    local tbl3 = {
        Id = id,
        Name = var4,
        LocalizedTitle = localizedTitle,
        Title = title,
        SearchUuid = searchUuid,
        AssetTypeIdStrings = assetTypeIdStrings,
        BundleTypes = bundleTypes,
        TaxonomyUuid = 0,
        WidgetContext = 0,
        TimeToRefresh = 0,
        CameraFocus = 0,
        CameraZoomRadius = 0,
        CanAnimateCameraBasedMood = 0,
        DisableFilters = 0,
        PageType = 0,
        LooksWidgetContextForOrganicContent = 0,
        TooltipKey = 0,
        TooltipBody = 0,
        TileType = 0
    }

    if not FFlagAXCatalogCategoriesSDUI then
        var15 = nil
    end

    tbl3.TaxonomyUuid = var15
    tbl3.WidgetContext = widgetContext
    tbl3.TimeToRefresh = timeToRefresh
    tbl3.CameraFocus = cameraFocus
    tbl3.CameraZoomRadius = cameraZoomRadius
    tbl3.CanAnimateCameraBasedMood = canAnimateCameraBasedMood
    tbl3.DisableFilters = disableFilters
    tbl3.PageType = pageType
    tbl3.LooksWidgetContextForOrganicContent = looksWidgetContextForOrganicContent
    tbl3.TooltipKey = tooltipKey
    tbl3.TooltipBody = tooltipBody
    tbl3.TileType = tileType

    if tbl1.isSubcategory then
        tbl3.isSubcategory = true
    elseif var24 and #var24 > 0 then
        tbl3.Subcategories = var24
    end

    return tbl3, nil
end

var1 = function(arg1)
    return normalizeCategoryOrSubcategory(arg1, { isSubcategory = true })
end

local function func2(arg1)
    return normalizeCategoryOrSubcategory(arg1, { isSubcategory = false })
end

local normalizeTableFn = makeNormalizeTableFn({
    Configs = {
        fn = function(arg1) -- name: normalizeConfigs
            if type(arg1) ~= "table" then
                return {}, "Configs field must be a table"
            end

            local tbl1 = {}
            local tbl2 = {}
            for _, value in arg1 do
                local var2, var3 = func2(value)
                if var3 then
                    table.insert(tbl2, var3)
                end
                if var2 and not var3 then
                    table.insert(tbl1, var2)
                end
            end

            return tbl1, if next(tbl2) then table.concat(tbl2, " ") else nil
        end
    }
})
return function(arg1)
    if not arg1 or type(arg1.Configs) ~= "table" then
        return {}, "Configs field is required and must be a table"
    end

    local var2, var3 = normalizeTableFn(arg1)

    return var2 and var2.Configs or {}, var3
end

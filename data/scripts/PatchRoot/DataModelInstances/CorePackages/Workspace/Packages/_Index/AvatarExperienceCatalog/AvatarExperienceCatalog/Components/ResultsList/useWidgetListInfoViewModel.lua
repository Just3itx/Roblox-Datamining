-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T02:00:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalog = script:FindFirstAncestor("AvatarExperienceCatalog")
local AvatarExperienceCatalogParent = AvatarExperienceCatalog.Parent

local useSelector = require(AvatarExperienceCatalogParent.RoactUtils).Hooks.RoactRodux.useSelector
local React = require(AvatarExperienceCatalogParent.React)
local Cryo = require(AvatarExperienceCatalogParent.Cryo)
local useTokens = require(AvatarExperienceCatalogParent.Foundation).Hooks.useTokens
local Responsive = require(AvatarExperienceCatalogParent.Responsive)
local inputModeStore = Responsive.GetInputModeStore(false)
local useSignalState = require(AvatarExperienceCatalogParent.SignalsReact).useSignalState
local AvatarExperienceFlags = require(AvatarExperienceCatalogParent.AvatarExperienceFlags)

local FFlagAXNoCarouselsOnCatalogWithGamepad = require(AvatarExperienceCatalog.Flags.FFlagAXNoCarouselsOnCatalogWithGamepad)
local FFlagAXHeroUnitActionButton = AvatarExperienceFlags.FFlagAXHeroUnitActionButton

local _WidgetListInfo = require(AvatarExperienceCatalog.Models.WidgetListInfo)

local _WidgetListInfoViewModel = require(script.Parent.WidgetListInfoViewModel)

local WidgetListBreakPointEnum = require(script.Parent.WidgetListBreakPointEnum)

local itemFooters = {
    { contentType = "ItemName" },
    { contentType = "Price" },
    { contentType = "AgentName" }
}

local tbl2 = {
    type = "Carousel",
    numItemsToShow = 12,
    itemFooters = itemFooters,
    previewRows = { default = 1 },
    previewColumns = { default = 3, medium = 4, large = 5, xLarge = 7, x2Large = 9 }
}

local tbl3 = {
    type = "ItemGroup",
    itemFooters = itemFooters,
    previewRows = { default = 1 },
    previewColumns = { default = 3, medium = 4, large = 5, xLarge = 7, x2Large = 9 }
}

local tbl4 = {
    type = "HeroUnit",
    itemFooters = itemFooters,
    previewRows = { default = 1 },
    previewColumns = { default = 3, medium = 4, large = 5, xLarge = 7, x2Large = 9 }
}

local tbl5 = {
    Default = "default",
    XSmall = "xSmall",
    Small = "small",
    Medium = "medium",
    Large = "large",
    XLarge = "xLarge",
    X2Large = "x2Large",
    Landscape = "landscape",
    Portrait = "portrait"
}

local tbl6 = { Dark = "dark", Light = "light", Default = "default" }

local function getQueryStringForSearchWidgets(searchesParameter)
    if not (searchesParameter and searchesParameter.searchKeyword) then
        return nil
    end

    local tbl7 = { searchesParameter.searchKeyword }
    if searchesParameter.sortAndFilters and searchesParameter.sortAndFilters.SelectedTopics then
        for _, selectedTopic in searchesParameter.sortAndFilters.SelectedTopics do
            table.insert(tbl7, 1, selectedTopic)
        end
    end

    return table.concat(tbl7, " ")
end

local function getDefaultItemGroupTemplate(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    if arg1 and arg1.defaultItemGroupTemplate then
        return Cryo.Dictionary.join(tbl3, arg1.defaultItemGroupTemplate)
    elseif arg1 and arg1.defaultTemplate then
        return Cryo.Dictionary.join(tbl3, arg1.defaultTemplate)
    end
    return tbl3
end

local function getDefaultCarouselTemplate(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    if arg1 and arg1.defaultItemCarouselTemplate then
        return Cryo.Dictionary.join(tbl2, arg1.defaultItemCarouselTemplate)
    end
    return tbl2
end

local function getResponsiveValue(arg1, str1: string?) -- Luacid: Inlined by compiler; 12 call sites recovered
    if not arg1 then
        return nil
    end
    local var1 = if str1 and tbl5[str1] then tbl5[str1] else "default"
    return if arg1[var1] then arg1[var1] else arg1.default
end

local function getThemeValue(backgroundLayers, name: string?) -- Luacid: Inlined by compiler; 1 call site recovered
    if not backgroundLayers then
        return nil
    end
    local var1 = if name and tbl6[name] then tbl6[name] else "default"
    return if backgroundLayers[var1] then backgroundLayers[var1] else backgroundLayers.default
end

local function colorToColor3(color): Color3 -- Luacid: Inlined by compiler; 1 call site recovered
    return Color3.new(color.r, color.g, color.b)
end

local function pointToVector2(arg1): Vector2 -- Luacid: Inlined by compiler; 2 call sites recovered
    return Vector2.new(arg1.x, arg1.y)
end

local function pointToUDim2(arg1): UDim2 -- Luacid: Inlined by compiler; 1 call site recovered
    return UDim2.fromOffset(arg1.x, arg1.y)
end

local function formatResponsivePointToVector(anchorPoint, str1: string?): Vector2 -- Luacid: Inlined by compiler; 1 call site recovered
    local responsiveValue = getResponsiveValue(anchorPoint, str1)
    return pointToVector2(responsiveValue or { x = 0, y = 0 })
end

local function formatResponsivePointToUDim2(position, str1: string?): UDim2 -- Luacid: Inlined by compiler; 1 call site recovered
    local responsiveValue = getResponsiveValue(position, str1)
    return pointToUDim2(responsiveValue or { x = 0, y = 0 })
end

local function formatColorSequence(colorSequence): ColorSequence
    local keypoints = {}
    for _, value in colorSequence do
        table.insert(keypoints, ColorSequenceKeypoint.new(value.time, colorToColor3(value.color)))
    end
    return ColorSequence.new(keypoints)
end

local function formatNumberSequence(transparency)
    if type(transparency) == "number" then
        return NumberSequence.new(transparency)
    end
    if #transparency == 0 then
        return nil
    end
    local keypoints = {}
    for _, value in transparency do
        table.insert(keypoints, NumberSequenceKeypoint.new(value.time, value.number))
    end
    return NumberSequence.new(keypoints)
end

local function formatImageBackground(arg1, str1: string?)
    local anchorPoint = if arg1.anchorPoint then formatResponsivePointToVector(arg1.anchorPoint, str1) else nil
    local position = if arg1.position then formatResponsivePointToUDim2(arg1.position, str1) else nil
    return {
        type = "ImageBackground",
        resourceIdentifier = if arg1.resourceIdentifier then getResponsiveValue(arg1.resourceIdentifier, str1) else nil,
        color = if arg1.color then colorToColor3(arg1.color) else nil,
        anchorPoint = anchorPoint,
        position = position,
        transparency = if arg1.transparency then getResponsiveValue(arg1.transparency, str1) else nil
    }
end

local function formatGradientBackground(arg1)
    return {
        type = "GradientBackground",
        colorSequence = formatColorSequence(arg1.colorSequence),
        rotation = arg1.rotation,
        transparency = if arg1.transparency then formatNumberSequence(arg1.transparency) else nil,
        offset = if arg1.offset then pointToVector2(arg1.offset) else nil
    }
end

local function getFormattedBackgroundLayers(backgroundLayers, str1: string, name: string?)
    local themeValue = getThemeValue(backgroundLayers, name)
    local formattedBackgroundLayers = {}

    for _, value in themeValue or {} do
        if value.type == "ImageBackground" then
            table.insert(formattedBackgroundLayers, (formatImageBackground(value, str1)))
        elseif value.type == "GradientBackground" then
            table.insert(formattedBackgroundLayers, (formatGradientBackground(value)))
        end
    end
    return formattedBackgroundLayers
end

local function formatCardStyle(cardStyle, str1: string, name: string?) -- Luacid: Inlined by compiler; 3 call sites recovered
    return {
        backgroundLayers = if cardStyle.backgroundLayers then getFormattedBackgroundLayers(cardStyle.backgroundLayers, str1, name) else nil,
        thumbnailAspectRatio = cardStyle.thumbnailAspectRatio
    }
end

local function formatWidgetStyle(widgetStyle, str1: string, name: string?) -- Luacid: Inlined by compiler; 3 call sites recovered
    return {
        backgroundLayers = if widgetStyle.backgroundLayers then getFormattedBackgroundLayers(widgetStyle.backgroundLayers, str1, name) else nil
    }
end

local function formatWidgetTemplateAsItemGroup(arg1, str1: string, name: string?)
    local previewColumns = getResponsiveValue(arg1.previewColumns, str1) or 1
    local previewRows = getResponsiveValue(arg1.previewRows, str1) or 1
    return {
        type = "ItemGroup",
        seeAllButton = arg1.seeAllButton,
        title = arg1.title,
        localizedTitle = arg1.localizedTitle,
        description = arg1.description,
        localizedDescription = arg1.localizedDescription,
        itemFooters = arg1.itemFooters,
        widgetStyle = if arg1.widgetStyle then formatWidgetStyle(arg1.widgetStyle, str1, name) else nil,
        cardStyle = if arg1.cardStyle then formatCardStyle(arg1.cardStyle, str1, name) else nil,
        previewRows = previewRows,
        previewColumns = previewColumns
    }
end

local function formatWidgetTemplateAsCarousel(arg1, str1: string, name: string?)
    local previewColumns = getResponsiveValue(arg1.previewColumns, str1) or 1
    local previewRows = getResponsiveValue(arg1.previewRows, str1) or 1
    return {
        type = "Carousel",
        numItemsToShow = arg1.numItemsToShow,
        seeAllButton = arg1.seeAllButton,
        title = arg1.title,
        localizedTitle = arg1.localizedTitle,
        description = arg1.description,
        localizedDescription = arg1.localizedDescription,
        itemFooters = arg1.itemFooters,
        widgetStyle = if arg1.widgetStyle then formatWidgetStyle(arg1.widgetStyle, str1, name) else nil,
        cardStyle = if arg1.cardStyle then formatCardStyle(arg1.cardStyle, str1, name) else nil,
        previewRows = previewRows,
        previewColumns = previewColumns
    }
end

local function formatWidgetTemplateAsHeroUnit(tbl7: {availableUntil: number, button: number, cardStyle: number, description: number, itemFooters: number, localizedDescription: number, localizedTitle: number, numItemsToShow: number, previewColumns: number, previewRows: number, seeAllButton: number, title: number, type: string, widgetStyle: number}, str1: string, name: string?)
    local previewColumns = getResponsiveValue(tbl7.previewColumns, str1) or 1
    local previewRows = getResponsiveValue(tbl7.previewRows, str1) or 1
    return {
        type = "HeroUnit",
        numItemsToShow = tbl7.numItemsToShow,
        seeAllButton = tbl7.seeAllButton,
        title = tbl7.title,
        localizedTitle = tbl7.localizedTitle,
        description = tbl7.description,
        localizedDescription = tbl7.localizedDescription,
        itemFooters = tbl7.itemFooters,
        widgetStyle = if tbl7.widgetStyle then formatWidgetStyle(tbl7.widgetStyle, str1, name) else nil,
        cardStyle = if tbl7.cardStyle then formatCardStyle(tbl7.cardStyle, str1, name) else nil,
        previewRows = previewRows,
        previewColumns = previewColumns,
        availableUntil = tbl7.availableUntil,
        button = if FFlagAXHeroUnitActionButton then tbl7.button else nil
    }
end

local function mergeCardStyle(cardStyle, cardStyle2): {backgroundLayers: number, thumbnailAspectRatio: number}?
    if not (cardStyle or cardStyle2) then
        return nil
    end

    local thumbnailAspectRatio = if cardStyle2 then cardStyle2.thumbnailAspectRatio else nil
    local thumbnailAspectRatio2 = if cardStyle then cardStyle.thumbnailAspectRatio else nil
    local tbl7 = { thumbnailAspectRatio = 0, backgroundLayers = 0 }
    if thumbnailAspectRatio == nil then
        thumbnailAspectRatio = thumbnailAspectRatio2
    end

    tbl7.thumbnailAspectRatio = thumbnailAspectRatio

    tbl7.backgroundLayers = Cryo.Dictionary.join(
        not (cardStyle and cardStyle.backgroundLayers) and {} or cardStyle.backgroundLayers,
        not (cardStyle2 and cardStyle2.backgroundLayers) and {} or cardStyle2.backgroundLayers
    )
    return tbl7
end

local function mergeWidgetStyle(widgetStyle, widgetStyle2)
    if not (widgetStyle or widgetStyle2) then
        return nil
    end

    return {
        backgroundLayers = Cryo.Dictionary.join(
            not (widgetStyle and widgetStyle.backgroundLayers) and {} or widgetStyle.backgroundLayers,
            not (widgetStyle2 and widgetStyle2.backgroundLayers) and {} or widgetStyle2.backgroundLayers
        )
    }
end

local function mergeItemGroupTemplates(defaultItemGroupTemplate, arg1)
    return {
        type = "ItemGroup",
        seeAllButton = if arg1.seeAllButton == nil then defaultItemGroupTemplate.seeAllButton else arg1.seeAllButton,
        title = if arg1.title == nil then defaultItemGroupTemplate.title else arg1.title,
        localizedTitle = if arg1.localizedTitle == nil then defaultItemGroupTemplate.localizedTitle else arg1.localizedTitle,
        description = if arg1.description == nil then defaultItemGroupTemplate.description else arg1.description,
        localizedDescription = if arg1.localizedDescription == nil then defaultItemGroupTemplate.localizedDescription else arg1.localizedDescription,
        itemFooters = if arg1.itemFooters == nil then defaultItemGroupTemplate.itemFooters else arg1.itemFooters,
        widgetStyle = mergeWidgetStyle(defaultItemGroupTemplate.widgetStyle, arg1.widgetStyle),
        cardStyle = mergeCardStyle(defaultItemGroupTemplate.cardStyle, arg1.cardStyle),
        previewRows = Cryo.Dictionary.join(defaultItemGroupTemplate.previewRows or {}, arg1.previewRows or {}),
        previewColumns = Cryo.Dictionary.join(defaultItemGroupTemplate.previewColumns or {}, arg1.previewColumns or {})
    }
end

local function mergeCarouselTemplates(defaultCarouselTemplate, arg1)
    return {
        type = "Carousel",
        numItemsToShow = if arg1.numItemsToShow == nil then defaultCarouselTemplate.numItemsToShow else arg1.numItemsToShow,
        seeAllButton = if arg1.seeAllButton == nil then defaultCarouselTemplate.seeAllButton else arg1.seeAllButton,
        title = if arg1.title == nil then defaultCarouselTemplate.title else arg1.title,
        localizedTitle = if arg1.localizedTitle == nil then defaultCarouselTemplate.localizedTitle else arg1.localizedTitle,
        description = if arg1.description == nil then defaultCarouselTemplate.description else arg1.description,
        localizedDescription = if arg1.localizedDescription == nil then defaultCarouselTemplate.localizedDescription else arg1.localizedDescription,
        itemFooters = if arg1.itemFooters == nil then defaultCarouselTemplate.itemFooters else arg1.itemFooters,
        widgetStyle = mergeWidgetStyle(defaultCarouselTemplate.widgetStyle, arg1.widgetStyle),
        cardStyle = mergeCardStyle(defaultCarouselTemplate.cardStyle, arg1.cardStyle),
        previewRows = Cryo.Dictionary.join(defaultCarouselTemplate.previewRows or {}, arg1.previewRows or {}),
        previewColumns = Cryo.Dictionary.join(defaultCarouselTemplate.previewColumns or {}, arg1.previewColumns or {})
    }
end

local function mergeHeroUnitTemplates(tbl7: {itemFooters: {any}, previewColumns: {default: number, large: number, medium: number, x2Large: number, xLarge: number}, previewRows: {default: number}, type: string}, arg1)
    return {
        type = "HeroUnit",
        numItemsToShow = if arg1.numItemsToShow == nil then tbl7.numItemsToShow else arg1.numItemsToShow,
        seeAllButton = if arg1.seeAllButton == nil then tbl7.seeAllButton else arg1.seeAllButton,
        title = if arg1.title == nil then tbl7.title else arg1.title,
        localizedTitle = if arg1.localizedTitle == nil then tbl7.localizedTitle else arg1.localizedTitle,
        description = if arg1.description == nil then tbl7.description else arg1.description,
        localizedDescription = if arg1.localizedDescription == nil then tbl7.localizedDescription else arg1.localizedDescription,
        itemFooters = if arg1.itemFooters == nil then tbl7.itemFooters else arg1.itemFooters,
        widgetStyle = mergeWidgetStyle(tbl7.widgetStyle, arg1.widgetStyle),
        cardStyle = mergeCardStyle(tbl7.cardStyle, arg1.cardStyle),
        previewRows = Cryo.Dictionary.join(tbl7.previewRows or {}, arg1.previewRows or {}),
        previewColumns = Cryo.Dictionary.join(tbl7.previewColumns or {}, arg1.previewColumns or {}),
        availableUntil = if arg1.availableUntil == nil then tbl7.availableUntil else arg1.availableUntil,
        button = if FFlagAXHeroUnitActionButton then if arg1.button == nil then tbl7.button else arg1.button else nil
    }
end

local function convertCarouselTemplateToItemGroupTemplate(template) -- Luacid: Inlined by compiler; 1 call site recovered
    local var1 = table.clone(template)
    var1.type = "ItemGroup"
    var1.numItemsToShow = nil
    return var1
end

local function formatWidgetListStateToWidgetListInfoViewModel(tbl7, str1: string, name: string?, directional: string?)
    local tbl8 = {
        configuration = {},
        widgets = {}
    }
    local configuration = if tbl7 then tbl7.Configuration else nil
    local bool1 = if FFlagAXNoCarouselsOnCatalogWithGamepad then directional ~= Responsive.Input.Directional else nil
    local defaultCarouselTemplate = getDefaultCarouselTemplate(configuration)
    local defaultItemGroupTemplate = getDefaultItemGroupTemplate(configuration)

    if tbl7 and tbl7.Details then
        for k, detail in tbl7.Details do
            local var1 = if FFlagAXNoCarouselsOnCatalogWithGamepad then if detail.template.type == "Carousel" and not bool1 then convertCarouselTemplateToItemGroupTemplate(detail.template) else detail.template else nil

            if not FFlagAXNoCarouselsOnCatalogWithGamepad then
                var1 = detail.template
            end

            local type = var1.type
            local bool2 = type == "Carousel"
            local template = if type == "HeroUnit" then formatWidgetTemplateAsHeroUnit(mergeHeroUnitTemplates(tbl4, var1), str1, name) elseif bool2 then formatWidgetTemplateAsCarousel(mergeCarouselTemplates(defaultCarouselTemplate, var1), str1, name) else formatWidgetTemplateAsItemGroup(mergeItemGroupTemplates(defaultItemGroupTemplate, var1), str1, name)
            local widgets = tbl8.widgets
            local tbl9 = {
                id = detail.id,
                type = detail.type,
                content = detail.content,
                tagId = detail.tagId,
                template = template,
                requestId = tbl7.RequestId
            }
            widgets[k] = tbl9
        end
    end

    if configuration then
        tbl8.configuration.customizedDataMap = configuration.customizedDataMap
    end

    tbl8.configuration.defaultItemGroupTemplate = formatWidgetTemplateAsItemGroup(defaultItemGroupTemplate, str1, name)

    tbl8.configuration.defaultItemCarouselTemplate = formatWidgetTemplateAsCarousel(defaultCarouselTemplate, str1, name)

    return tbl8
end

local function useWidgetListInfoViewModel(str1: string?, str2: string?, arg1)
    local var1 = arg1 or WidgetListBreakPointEnum.Default
    local var2 = if FFlagAXNoCarouselsOnCatalogWithGamepad then useSignalState(inputModeStore.getLastInputType) else nil

    local var3 = React.useCallback(function(arg2)
        local searchesParameter = arg2.SearchesParameters[str1]
        local var3 = searchesParameter and searchesParameter.searchKeyword ~= nil
        local queryStringForSearchWidgets = getQueryStringForSearchWidgets(searchesParameter)

        if var3 then
            return arg2.AvatarExperience.Common.Widgets.SearchPageWidgetInfo[queryStringForSearchWidgets]
        end

        if str2 then
            return arg2.AvatarExperience.Common.Widgets.ContextWidgetInfo[str2]
        end

        return arg2.AvatarExperience.Common.Widgets.WidgetInfo
    end, { str1, str2 })

    local var4 = useSelector(var3)
    local var5 = useTokens()
    local useMemo = React.useMemo
    local function func1()
        return (formatWidgetListStateToWidgetListInfoViewModel(
            var4,
            var1,
            var5.Config.ColorMode.Name,
            if FFlagAXNoCarouselsOnCatalogWithGamepad then var2 else nil
        ))
    end

    local colorModeName = var5.Config.ColorMode.Name
    local var6 = if FFlagAXNoCarouselsOnCatalogWithGamepad then var2 else nil
    return (useMemo(func1, { colorModeName, var4, var1, var6 }))
end

return useWidgetListInfoViewModel

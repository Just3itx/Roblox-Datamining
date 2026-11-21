-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:41:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalog = script:FindFirstAncestor("AvatarExperienceCatalog")
local AvatarExperienceCatalogParent = AvatarExperienceCatalog.Parent
local AvatarExperienceCommon = require(AvatarExperienceCatalogParent.AvatarExperienceCommon)
local AvatarExperienceFlags = require(AvatarExperienceCatalogParent.AvatarExperienceFlags)
local normalize = AvatarExperienceCommon.Utils.normalize
local normalizeBoolean = normalize.normalizeBoolean
local normalizeString = normalize.normalizeString
local normalizeNotEmptyString = normalize.normalizeNotEmptyString
local normalizeNumber = normalize.normalizeNumber
local normalizeStringToBoolean = normalize.normalizeStringToBoolean
local makeNormalizeTableFn = normalize.makeNormalizeTableFn
local makeNormalizeListFn = normalize.makeNormalizeListFn
local makeNormalizeUnionFn = normalize.makeNormalizeUnionFn
local makeNormalizeValueFn = normalize.makeNormalizeValueFn
local makeRequired = normalize.makeRequired

local FFlagAXHeroUnitActionButton = AvatarExperienceFlags.FFlagAXHeroUnitActionButton

local _WidgetListInfo = require(AvatarExperienceCatalog.Models.WidgetListInfo)

local function makeNormalizeResponsiveValueFn(arg1) -- Luacid: Inlined by compiler; 3 call sites recovered
    return makeNormalizeTableFn({
        default = arg1,
        xSmall = arg1,
        small = arg1,
        medium = arg1,
        large = arg1,
        xLarge = arg1,
        x2Large = arg1,
        landscape = arg1,
        portrait = arg1
    })
end

local function makeNormalizedThemeValueFn(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    return makeNormalizeTableFn({ default = arg1, light = arg1, dark = arg1 })
end

local normalizeResponsiveValueFn = makeNormalizeResponsiveValueFn(normalizeNumber)

local color = makeNormalizeTableFn(
    {
        r = makeRequired(normalizeNumber),
        g = makeRequired(normalizeNumber),
        b = makeRequired(normalizeNumber)
    }
)
local offset = makeNormalizeTableFn({ x = makeRequired(normalizeNumber), y = makeRequired(normalizeNumber) })
local normalizeResponsiveValueFn2 = makeNormalizeResponsiveValueFn(offset)
local normalizeTableFn3 = makeNormalizeTableFn({
    type = makeRequired(makeNormalizeValueFn({ "ImageBackground" })),
    color = color,
    resourceIdentifier = makeNormalizeResponsiveValueFn(normalizeString),
    anchorPoint = normalizeResponsiveValueFn2,
    position = normalizeResponsiveValueFn2,
    transparency = normalizeResponsiveValueFn
})

local normalizeTableFn4 = makeNormalizeTableFn({ time = makeRequired(normalizeNumber), color = makeRequired(color) })

local normalizeTableFn5 = makeNormalizeTableFn({ time = makeRequired(normalizeNumber), number = makeRequired(normalizeNumber) })
local backgroundLayers = makeNormalizedThemeValueFn(
    (makeNormalizeListFn(
        (makeNormalizeUnionFn({ normalizeTableFn3, (makeNormalizeTableFn({
                type = makeRequired(makeNormalizeValueFn({ "GradientBackground" })),
                colorSequence = makeRequired(makeNormalizeListFn(normalizeTableFn4)),
                rotation = normalizeNumber,
                transparency = makeNormalizeUnionFn({ normalizeNumber, makeNormalizeListFn(normalizeTableFn5) }),
                offset = offset
            })) }))
    ))
)
local widgetStyle = makeNormalizeTableFn({ backgroundLayers = backgroundLayers })

local cardStyle = makeNormalizeTableFn({
    backgroundLayers = backgroundLayers,
    thumbnailAspectRatio = makeNormalizeUnionFn({
        makeNormalizeValueFn({ "Wide", "Tall", "Square" }),
        function(arg1)
            if arg1 then
                return tonumber(arg1)
            end
            return nil
        end
    })
})

local itemFooters = makeNormalizeListFn(
    (makeNormalizeTableFn({ contentType = makeNormalizeValueFn({ "ItemName", "AgentName", "Price", "PriceRange" }) }))
)
local customizedDataMap = makeNormalizeTableFn({
    continueBrowsingTitle = normalizeString,
    shouldUseDefaultTemplatesAcrossTabs = normalizeString,
    creatorNameTileFooterEnabled = normalizeString,
    hydrateOnlyVisibleItems = normalizeStringToBoolean,
    disableOrganicContentFetch = normalizeStringToBoolean
})

local defaultItemCarouselTemplate = makeNormalizeTableFn({
    type = makeRequired(makeNormalizeValueFn({ "Carousel" })),
    numItemsToShow = normalizeNumber,
    seeAllButton = normalizeBoolean,
    title = normalizeString,
    localizedTitle = normalizeString,
    description = normalizeString,
    localizedDescription = normalizeString,
    widgetStyle = widgetStyle,
    cardStyle = cardStyle,
    itemFooters = itemFooters,
    previewRows = normalizeResponsiveValueFn,
    previewColumns = normalizeResponsiveValueFn
})

local normalizeTableFn10 = makeNormalizeTableFn({
    type = makeRequired(makeNormalizeValueFn({ "ItemGroup" })),
    seeAllButton = normalizeBoolean,
    title = normalizeString,
    localizedTitle = normalizeString,
    description = normalizeString,
    localizedDescription = normalizeString,
    widgetStyle = widgetStyle,
    cardStyle = cardStyle,
    itemFooters = itemFooters,
    previewRows = normalizeResponsiveValueFn,
    previewColumns = normalizeResponsiveValueFn
})
local button = if FFlagAXHeroUnitActionButton then makeNormalizeTableFn({
    action = makeRequired(makeNormalizeValueFn({ "OpenRobloxPlus", "OpenFreeRobloxPlus" })),
    localizedText = { fn = normalizeNotEmptyString }
}) else nil
local normalizeTableFn12 = makeNormalizeTableFn({
    type = makeRequired(makeNormalizeValueFn({ "HeroUnit" })),
    numItemsToShow = normalizeNumber,
    seeAllButton = normalizeBoolean,
    title = normalizeString,
    localizedTitle = normalizeString,
    description = normalizeString,
    localizedDescription = normalizeString,
    widgetStyle = widgetStyle,
    cardStyle = cardStyle,
    itemFooters = itemFooters,
    previewRows = normalizeResponsiveValueFn,
    previewColumns = normalizeResponsiveValueFn,
    availableUntil = normalizeString,
    button = button
})

local configuration = makeNormalizeTableFn({
    customizedDataMap = customizedDataMap,
    defaultItemCarouselTemplate = defaultItemCarouselTemplate,
    defaultItemGroupTemplate = normalizeTableFn10,
    defaultTemplate = normalizeTableFn10
})

local normalizeListFn2 = makeNormalizeListFn(
    makeNormalizeUnionFn({ makeNormalizeTableFn({ id = makeRequired(normalizeNumber), type = makeRequired(makeNormalizeValueFn({ "Bundle" })) }), makeNormalizeTableFn({ id = makeRequired(normalizeNumber), type = makeRequired(makeNormalizeValueFn({ "Asset" })) }), (makeNormalizeTableFn(
            {
                id = makeRequired(normalizeString),
                type = makeRequired(makeNormalizeValueFn({ "Look" })),
                displayProperties = makeNormalizeTableFn({ animatedAvatarEmoteAssetIds = normalizeString })
            }
        )) })
)
local normalizeTableFn14 = makeNormalizeTableFn({
    id = makeRequired(normalizeString),
    type = makeRequired(normalizeString),
    content = makeRequired(normalizeListFn2),
    template = makeRequired(makeNormalizeUnionFn({ normalizeTableFn10, defaultItemCarouselTemplate, normalizeTableFn12 })),
    tagId = normalizeString
})

return (makeNormalizeTableFn({
    configuration = configuration,
    widgets = function(arg1) -- name: normalizeWidgets
        if typeof(arg1) ~= "table" then
            return nil, nil
        end
        local tbl1 = {}
        local tbl2 = {}
        for value, value2 in arg1 do
            local var1, var2 = normalizeTableFn14(value2)
            table.insert(tbl2, var2)

            local var3 = tonumber(value) + 1
            tbl1[tostring(var3)] = var1
        end

        return tbl1, if next(tbl2) then table.concat(tbl2, " ") else nil
    end
}))

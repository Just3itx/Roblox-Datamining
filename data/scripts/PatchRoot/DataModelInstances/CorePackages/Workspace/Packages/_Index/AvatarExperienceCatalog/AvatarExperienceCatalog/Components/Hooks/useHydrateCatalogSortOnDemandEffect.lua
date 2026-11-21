-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:51:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalog = script:FindFirstAncestor("AvatarExperienceCatalog")
local AvatarExperienceCatalogParent = AvatarExperienceCatalog.Parent

local React = require(AvatarExperienceCatalogParent.React)

local AvatarExperienceCommon = require(AvatarExperienceCatalogParent.AvatarExperienceCommon)
local ItemTypeEnum = require(AvatarExperienceCatalogParent.AvatarExperienceModel).Enums.ItemTypeEnum
local useNetworking = AvatarExperienceCommon.Hooks.useNetworking

local FFlagAXMigrateAllTabToSduiDev = require(AvatarExperienceCatalogParent.AvatarExperienceFlags).FFlagAXMigrateAllTabToSduiDev

local useStore = require(AvatarExperienceCatalogParent.RoactUtils).Hooks.RoactRodux.useStore

local WidgetConstants = require(AvatarExperienceCatalog.WidgetConstants)
local _WidgetListInfoViewModel = require(AvatarExperienceCatalog.Components.ResultsList.WidgetListInfoViewModel)

local selectHydratedWidgetData = require(AvatarExperienceCatalog.State.Selectors.selectHydratedWidgetData)

local useCatalogPageMonolithDependencies = require(AvatarExperienceCatalog.Providers.useCatalogPageMonolithDependencies)

local num1 = game:DefineFastInt("AXCarouselMaxItems", 50)

local function getContentToHydrate(num2: number, arg1, num3: number?)
    local contentToHydrate = {}
    local content = num2 and num2.content
    if not content or #content == 0 then
        return contentToHydrate
    end

    local num4 = num3 or num1
    local contentLen = #content

    local tbl1 = ({})

    for i = 1, math.min(num4, contentLen) do
        local var1 = content[i]
        local type = var1.type

        local var2 = tbl1[type]
        if var2 == nil then
            if arg1 then
                var2 = arg1[type] or false
            else
                var2 = false
            end

            tbl1[type] = var2
        end

        local var3 = var2 and var2[var1.id]
        local bool1 = type == ItemTypeEnum.Look and not FFlagAXMigrateAllTabToSduiDev

        if bool1 or not var3 then
            table.insert(contentToHydrate, var1)
        end
    end

    return contentToHydrate
end

local function useHydrateCatalogSortOnDemandEffect(num2: number, num3: number, num4: number)
    local fetchHydratedWidgetContent = useCatalogPageMonolithDependencies().fetchHydratedWidgetContent

    local var1 = useNetworking()
    local var2 = useStore()

    local var3 = React.useRef(nil)

    React.useEffect(function()
        local id = num2 and num2.id
        if not id or num2.type == WidgetConstants.Types.MySharedAvatarsWidget or var3.current == id then
            return
        end

        local var4 = if num3 and num3.customizedDataMap and num3.customizedDataMap.hydrateOnlyVisibleItems then num4 else nil
        local var5 = selectHydratedWidgetData(var2:getState())

        local contentToHydrate = getContentToHydrate(num2, var5, var4)
        if #contentToHydrate == 0 then
            return
        end

        var3.current = id
        fetchHydratedWidgetContent(var1, contentToHydrate, id)
    end, {
        num2,
        num3,
        num4,
        var1,
        fetchHydratedWidgetContent,
        var2
    })
end

return useHydrateCatalogSortOnDemandEffect

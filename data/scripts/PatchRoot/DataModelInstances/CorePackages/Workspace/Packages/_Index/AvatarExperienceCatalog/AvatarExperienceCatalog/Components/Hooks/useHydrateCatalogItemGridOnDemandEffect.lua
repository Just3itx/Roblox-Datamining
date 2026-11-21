-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:51:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalog = script:FindFirstAncestor("AvatarExperienceCatalog")
local AvatarExperienceCatalogParent = AvatarExperienceCatalog.Parent

local React = require(AvatarExperienceCatalogParent.React)
local useNetworking = require(AvatarExperienceCatalogParent.AvatarExperienceCommon).Hooks.useNetworking
local useStore = require(AvatarExperienceCatalogParent.RoactUtils).Hooks.RoactRodux.useStore
local _WidgetListInfoViewModel = require(AvatarExperienceCatalog.Components.ResultsList.WidgetListInfoViewModel)
local selectHydratedWidgetData = require(AvatarExperienceCatalog.State.Selectors.selectHydratedWidgetData)
local getCatalogContentToHydrate = require(AvatarExperienceCatalog.Utils.getCatalogContentToHydrate)
local useCatalogPageMonolithDependencies = require(AvatarExperienceCatalog.Providers.useCatalogPageMonolithDependencies)

local tbl1 = {}

local function useHydrateCatalogItemGridOnDemandEffect(current: string?, tbl2)
    local fetchHydratedWidgetContent = useCatalogPageMonolithDependencies().fetchHydratedWidgetContent

    local var1 = useNetworking()
    local var2 = useStore()

    local var3 = React.useRef(nil)
    local var4 = React.useRef(nil)

    React.useEffect(function()
        if not current or current == "" then
            return
        end

        local tbl3 = tbl2 or tbl1
        if var3.current == current and var4.current == tbl3 then
            return
        end

        local var5 = selectHydratedWidgetData(var2:getState())

        local catalogContentToHydrate = getCatalogContentToHydrate(tbl3, var5, nil)

        var3.current = current
        var4.current = tbl3

        if #catalogContentToHydrate == 0 then
            return
        end

        fetchHydratedWidgetContent(var1, catalogContentToHydrate, current)
    end, {
        current,
        tbl2,
        var1,
        fetchHydratedWidgetContent,
        var2
    })
end

return useHydrateCatalogItemGridOnDemandEffect

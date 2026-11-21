-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T02:10:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalogParent = script:FindFirstAncestor("AvatarExperienceCatalog").Parent

local React = require(AvatarExperienceCatalogParent.React)
local RoactUtils = require(AvatarExperienceCatalogParent.RoactUtils)
local _AvatarExperienceRodux = require(AvatarExperienceCatalogParent.AvatarExperienceRodux)
local Logging = require(AvatarExperienceCatalogParent.AppCommonLib).Logging

local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch

local FFlagAXSduiSeeAllPageRequestId = require(AvatarExperienceCatalogParent.AvatarExperienceFlags).FFlagAXSduiSeeAllPageRequestId

local buildFocusedSortWidgetInfo = require(script.Parent.buildFocusedSortWidgetInfo)
local hydrateCatalogSortById = require(script.Parent.hydrateCatalogSortById)

local function buildAlreadyHydratedSet(hydratedWidgetData)
    if not hydratedWidgetData then
        return nil
    end
    local tbl1 = {}
    for value, value2 in hydratedWidgetData do
        if typeof(value2) ~= "table" then
            continue
        end

        local tbl2 = {}
        for value3, value4 in value2 do
            if typeof(value4) == "table" and value4.failedToHydrate ~= true then
                tbl2[tostring(value3)] = true
            end
        end

        if next(tbl2) ~= nil then
            tbl1[tostring(value)] = tbl2
        end
    end
    return if next(tbl1) == nil then nil else tbl1
end

local function useApplySduiFocusedSort(tbl1)
    local var1 = useDispatch()
    local useCallback = React.useCallback
    local function func1(tbl2, str1: string?, arg1): boolean
        if not str1 or str1 == "" then
            Logging.warn(
                "useApplySduiFocusedSort: missing context for sortId=" .. tostring(tbl2 and tbl2.sortId) .. "; SDUI catalog isn't propagating context to ResultsList. Verify FFlagAXMigrateAllTabToSduiDev is on."
            )
            return false
        end

        local tbl3 = {
            title = tbl2.title,
            description = tbl2.description,
            tooltipText = tbl2.tooltipText
        }
        local focusedSortWidgetInfo

        if FFlagAXSduiSeeAllPageRequestId then
            local pageRequestId = if tbl1.getPageRequestId then tbl1.getPageRequestId() else nil
            focusedSortWidgetInfo = buildFocusedSortWidgetInfo(tbl2.sortId, str1, tbl3, pageRequestId)
        else
            focusedSortWidgetInfo = buildFocusedSortWidgetInfo(tbl2.sortId, str1, tbl3)
        end
        if not focusedSortWidgetInfo then
            Logging.warn(
                "useApplySduiFocusedSort: synthesizer returned nil for sortId=" .. tostring(tbl2.sortId) .. " context=" .. tostring(str1)
            )
            return false
        end
        var1(tbl1.SetWidgetInfo(focusedSortWidgetInfo.widgetInfo, focusedSortWidgetInfo.requestId, nil, str1))
        local alreadyHydratedSet = if tbl1.getHydratedWidgetData then buildAlreadyHydratedSet(tbl1.getHydratedWidgetData()) else nil
        hydrateCatalogSortById(var1, arg1, tbl1.SetHydratedWidgetData, tbl1.CatalogWebApi, tbl2.sortId, alreadyHydratedSet)

        return true
    end

    local setWidgetInfo = tbl1.SetWidgetInfo
    local setHydratedWidgetData = tbl1.SetHydratedWidgetData
    local catalogWebApi = tbl1.CatalogWebApi
    local getHydratedWidgetData = tbl1.getHydratedWidgetData
    local getPageRequestId = if FFlagAXSduiSeeAllPageRequestId then tbl1.getPageRequestId else nil
    return useCallback(
        func1,
        {
            var1,
            setWidgetInfo,
            setHydratedWidgetData,
            catalogWebApi,
            getHydratedWidgetData,
            getPageRequestId
        }
    )
end

return useApplySduiFocusedSort

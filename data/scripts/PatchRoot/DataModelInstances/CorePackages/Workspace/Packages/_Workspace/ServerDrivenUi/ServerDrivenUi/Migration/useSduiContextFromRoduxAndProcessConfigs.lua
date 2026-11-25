-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:31:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUi = script:FindFirstAncestor("ServerDrivenUi")
local ServerDrivenUiParent = ServerDrivenUi.Parent
local React = require(ServerDrivenUiParent.React)
local tutils = require(ServerDrivenUiParent.tutils)
local RoactUtils = require(ServerDrivenUiParent.RoactUtils)
local _CollectionViews = require(ServerDrivenUiParent.CollectionViews)

local useSelector = RoactUtils.Hooks.RoactRodux.useSelector
local SduiConfigReducer = require(ServerDrivenUi.Rodux.SduiConfigReducer)
local useSduiContext = require(ServerDrivenUi.System.useSduiContext)
local getSduiFeedStore = require(ServerDrivenUi.DataStore.getSduiFeedStore)
local processCollectionConfig = require(ServerDrivenUi.System.processCollectionConfig)
local getItemCollectionKey = require(ServerDrivenUi.DataStore.getItemCollectionKey)

local _SduiCoreSystem = require(ServerDrivenUiParent.SduiCoreSystem)

local FFlagLuaAppLayoutParamsInContext = require(ServerDrivenUiParent.SharedFlags).FFlagLuaAppLayoutParamsInContext

local FFlagLuaAppUseEffectInSignalPreprocessing = require(ServerDrivenUiParent.SharedFlags).FFlagLuaAppUseEffectInSignalPreprocessing

local function useSduiContextFromRoduxAndProcessConfigs(appPage: string, pageLayoutConfig, str1: string?): string
    local str2 = str1 or appPage

    local var1 = useSelector(function(arg2)
        local result = {}
        local var1 = arg2.Personalization[SduiConfigReducer.key][str2]
        if var1 then
            result.templates = if var1.rootConfig then var1.rootConfig.templates or nil else nil
            result.dataUpdatedTimestamp = var1.dataUpdatedTimestamp
            result.itemCollections = var1.itemCollections
        end
        return result
    end, tutils.shallowEqual)

    local var2 = useSduiContext
    local tbl1 = {
        appPage = appPage,
        templates = var1.templates,
        dataUpdatedTimestamp = var1.dataUpdatedTimestamp,
        pageLayoutConfig = 0
    }

    if not FFlagLuaAppLayoutParamsInContext then
        pageLayoutConfig = nil
    end

    tbl1.pageLayoutConfig = pageLayoutConfig
    local var3 = var2(tbl1);

    (if FFlagLuaAppUseEffectInSignalPreprocessing then React.useEffect else React.useLayoutEffect)(function()
        local sduiFeedStore = getSduiFeedStore(str2)
        local itemCollections = ({})
        if var1.itemCollections then
            for _, itemCollection in var1.itemCollections do
                local itemCollectionKey = getItemCollectionKey(itemCollection.topicId, itemCollection.sortIndex)
                itemCollections[itemCollectionKey] = {
                    sduiConfig = processCollectionConfig(itemCollection.sduiConfig, itemCollection.topicId, var3),
                    dataUpdatedTimestamp = itemCollection.dataUpdatedTimestamp
                }
            end
            sduiFeedStore.updateData(
                {
                    templates = var1.templates,
                    itemCollections = itemCollections,
                    dataUpdatedTimestamp = var1.dataUpdatedTimestamp
                }
            )
        end

        return function() end
    end, {
        var3,
        var1.itemCollections,
        var1.templates,
        var1.dataUpdatedTimestamp,
        str2
    })

    return var3
end
return useSduiContextFromRoduxAndProcessConfigs

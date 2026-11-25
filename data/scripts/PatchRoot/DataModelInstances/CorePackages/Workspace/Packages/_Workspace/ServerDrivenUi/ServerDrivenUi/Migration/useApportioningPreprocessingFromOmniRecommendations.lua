-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:31:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUi = script:FindFirstAncestor("ServerDrivenUi")
local ServerDrivenUiParent = ServerDrivenUi.Parent
local React = require(ServerDrivenUiParent.React)
local tutils = require(ServerDrivenUiParent.tutils)
local RoactUtils = require(ServerDrivenUiParent.RoactUtils)
local CollectionViews = require(ServerDrivenUiParent.CollectionViews)
local GameTile = require(ServerDrivenUiParent.GameTile)
local GameTileLayoutType = GameTile.GameTileTypes.GameTileLayoutType
local TopicContentsReducer = require(ServerDrivenUiParent.TopicContentsRodux).TopicContentsReducer
local DiscoveryTypes = require(ServerDrivenUiParent.DiscoveryTypes)

local useSelector = RoactUtils.Hooks.RoactRodux.useSelector
local getGameTileCollectionItemSize = GameTile.getGameTileCollectionItemSize
local OmniFeedTypes = DiscoveryTypes.OmniFeedTypes
local OmniFeedConstants = DiscoveryTypes.OmniFeedConstants

local getSduiFeedStore = require(ServerDrivenUi.DataStore.getSduiFeedStore)
local ApportioningPreprocessingHelpers = require(ServerDrivenUi.DataStore.ApportioningPreprocessingHelpers)

local FFlagLuaAppUseEffectInSignalPreprocessing = require(ServerDrivenUiParent.SharedFlags).FFlagLuaAppUseEffectInSignalPreprocessing

local FFlagLuaAppAddRequestIdToRfySignalApportioning = require(ServerDrivenUiParent.SharedFlags).FFlagLuaAppAddRequestIdToRfySignalApportioning
local FFlagLuaAppCompositionAlways = require(ServerDrivenUiParent.SharedFlags).FFlagLuaAppCompositionAlways

local getMainCollectionLayoutStore = CollectionViews.getMainCollectionLayoutStore

local function useApportioningPreprocessingFromOmniRecommendations(str1: string, arg1, bool1: boolean?)
    local var1 = FFlagLuaAppCompositionAlways or bool1

    local var2 = useSelector(function(arg2)
        local omniRecommendation = arg2.OmniRecommendations[str1]
        return if omniRecommendation then omniRecommendation.sorts else {}
    end, tutils.shallowEqual)

    local var3 = if FFlagLuaAppAddRequestIdToRfySignalApportioning then useSelector(function(arg2)
        local omniRecommendation = arg2.OmniRecommendations[str1]
        return if omniRecommendation then omniRecommendation.recommendationsId else nil
    end) else nil

    local var4 = useSelector(function(arg2)
        return arg2.Personalization[TopicContentsReducer.key]
    end)

    local var5 = if FFlagLuaAppUseEffectInSignalPreprocessing then React.useEffect else React.useLayoutEffect

    local function func1()
        local sduiFeedStore = getSduiFeedStore(str1)
        local apportioningData = {}
        local var6 = if var1 then getMainCollectionLayoutStore(false).getNumItemsForAllCategories(false) else nil

        for value, value2 in var2 do
            local topicId = value2.topicId
            if not topicId or value2.treatmentType ~= OmniFeedTypes.HomeGameGrid then
                continue
            end

            local narrow = GameTileLayoutType.Narrow
            if value2.topicLayoutData then
                local var7 = value2.topicLayoutData[OmniFeedConstants.TopicLayoutDataKeys.ComponentType]
                if var7 then
                    if var7 == OmniFeedConstants.ComponentTypeDataKeys.EventTile then
                        narrow = GameTileLayoutType.Event
                    elseif var7 == OmniFeedConstants.ComponentTypeDataKeys.GridTile then
                        narrow = GameTileLayoutType.Wide
                    end
                end
            end

            local gameTileCollectionItemSize = getGameTileCollectionItemSize(narrow)
            local var7 = if var1 then var6[gameTileCollectionItemSize] else arg1[gameTileCollectionItemSize](false).numColumns
            local numberOfRows = value2.numberOfRows or 99999
            local var8 = var7 * (if numberOfRows == -1 then 99999 else numberOfRows)

            ApportioningPreprocessingHelpers.addToApportioningData(apportioningData, topicId, var8, value)
        end

        ApportioningPreprocessingHelpers.populateStartingItemIndices(apportioningData)

        for value, value2 in apportioningData do
            local var7 = if value then if var4 then var4[value] or nil else nil else nil
            value2.items = not var7 and {} or var7.entries or {}
        end

        sduiFeedStore.updateData(
            { apportioningData = apportioningData },
            if FFlagLuaAppAddRequestIdToRfySignalApportioning then var3 else nil
        )

        return function() end
    end

    local var6 = if FFlagLuaAppCompositionAlways then nil else arg1
    local var7 = if FFlagLuaAppAddRequestIdToRfySignalApportioning then var3 else nil
    var5(func1, { var2, var4, var6, str1, var7, var1 })
end

return useApportioningPreprocessingFromOmniRecommendations

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T10:51:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedContent = script:FindFirstAncestor("SduiSharedContent")
local SduiSharedContentParent = SduiSharedContent.Parent
local FFlagSduiErrorPaths = require(SduiSharedContentParent.SharedFlags).FFlagSduiErrorPaths

local React = require(SduiSharedContentParent.React)
local Cryo = require(SduiSharedContentParent.Cryo)
local DiscoveryTypes = require(SduiSharedContentParent.DiscoveryTypes)
local SduiCoreSystem = require(SduiSharedContentParent.SduiCoreSystem)
local findAnalyticsField = SduiCoreSystem.findAnalyticsField
local getSduiComponentWrapper = SduiCoreSystem.getSduiComponentWrapper
local SduiBuilder = SduiCoreSystem.SduiBuilder
local SduiErrors = SduiCoreSystem.SduiErrors
local addSduiErrorContextFields = SduiCoreSystem.addSduiErrorContextFields

local SduiFeedItem = require(SduiSharedContent.Components.SduiFeedItem)

local SharedFlags = require(SduiSharedContentParent.SharedFlags)
local FFlagSduiCollectionGridRevealRows = SharedFlags.FFlagSduiCollectionGridRevealRows
local FFlagAppPageShellScrollToTopFocus = SharedFlags.FFlagAppPageShellScrollToTopFocus
local FFlagSduiIndividualFeedItemSpacing = SharedFlags.FFlagSduiIndividualFeedItemSpacing
local FFlagSduiSamePoolFeedItemSpacing = SharedFlags.FFlagSduiSamePoolFeedItemSpacing
local bool1 = game:DefineFastFlag("SduiFeedDebugNameWithImpressionsTag", false)

local SORT_INDEX_SELECTION_ORDER_MULTIPLIER = DiscoveryTypes.Constants.SORT_INDEX_SELECTION_ORDER_MULTIPLIER

local tbl1 = {}

local function getSpacingAfterFeedItem(num1: number?, num2: number, num3: number?, num4: number?, arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    if num1 == nil then
        return nil
    end

    if FFlagSduiSamePoolFeedItemSpacing and num4 ~= nil and arg1 ~= nil and arg1.continuesPreviousSection == true then
        return num4
    end

    if num2 == 1 and num3 ~= nil and num3 >= 0 then
        return num3
    end

    return num1
end

local function buildSduiFeedChildren(tbl2)
    local sduiFeedChildren = ({})
    local sduiContext = tbl2.sduiContext

    local startRow = tbl2.extraLocalProps and tbl2.extraLocalProps.startRow
    local var1 = if typeof(startRow) ~= "number" then 1 else startRow

    local maxConfigs = tbl2.maxConfigs
    local gapBetweenFeedItems = if FFlagSduiIndividualFeedItemSpacing then tbl2.gapBetweenFeedItems else nil
    local gapAfterFirstFeedItem = if FFlagSduiIndividualFeedItemSpacing then tbl2.gapAfterFirstFeedItem else nil

    for k, componentConfig in tbl2.configs do
        if maxConfigs ~= nil and maxConfigs < k then
            break
        end

        local var2 = findAnalyticsField("componentType", componentConfig.analyticsData or tbl1)
            or SduiBuilder.getComponentType(componentConfig, sduiContext)

        if not var2 then
            local tbl3 = {
                componentType = tbl2.componentType,
                name = tbl2.debugName,
                message = `Nil componentType in {tbl2.componentType} at index {k}`
            }
            if FFlagSduiErrorPaths then
                addSduiErrorContextFields(tbl3, componentConfig.errorContext)
            end
            sduiContext.dependencies.logger.reportError(SduiErrors.SduiErrorType.NilComponentType, tbl3, sduiContext.appPage)
        else
            local str1 = `{tbl2.componentType}{k}_{var2}`
            local sduiComponentWrapper = getSduiComponentWrapper(componentConfig)

            local localAnalyticsData = {
                feedItemPosition = k,
                itemComponentType = var2,
                componentType = var2,
                collectionPosition = k
            }

            local _extraLocalProps = tbl2.extraLocalProps

            local startRowGetter = componentConfig.startRowGetter
            local extraLocalPropSignals = startRowGetter ~= nil and { startRow = startRowGetter } or nil
            local var3 = if startRowGetter ~= nil then Cryo.None else var1 + k - 1
            local var5 = Cryo.Dictionary.join(tbl2.extraLocalProps or tbl1, {
                startRow = var3,
                setDisplayedRowCount = if FFlagSduiCollectionGridRevealRows then componentConfig.setDisplayedRowCount else nil
            })

            local var6 = Cryo.Dictionary.join(var5, { index = k })

            if FFlagAppPageShellScrollToTopFocus and tbl2.selectionOrderBase ~= nil then
                var6 = Cryo.Dictionary.join(var6, { selectionOrderBase = tbl2.selectionOrderBase + k * SORT_INDEX_SELECTION_ORDER_MULTIPLIER })
            end

            local element = React.createElement(sduiComponentWrapper, {
                debugName = if bool1 and tbl2.impressionsTag ~= nil and tbl2.impressionsTag ~= "" then `{str1}_{tbl2.impressionsTag}` else str1,
                componentConfig = componentConfig,
                sduiContext = sduiContext,
                localAnalyticsData = localAnalyticsData,
                extraLocalProps = var6,
                extraLocalPropSignals = extraLocalPropSignals
            })
            local var7 = if componentConfig.props and componentConfig.props.layoutOrder ~= nil then componentConfig.props.layoutOrder else k
            local zIndex = if componentConfig.props and componentConfig.props.zIndex ~= nil then componentConfig.props.zIndex else -k
            local index = if tbl2.negateImpressionIndex then -k else k
            local var10

            if FFlagSduiIndividualFeedItemSpacing then
                var10 = var7 * 2
                local samePoolFeedItemGap = if FFlagSduiSamePoolFeedItemSpacing then tbl2.samePoolFeedItemGap else nil
                local config2 = if FFlagSduiSamePoolFeedItemSpacing then tbl2.configs[k + 1] else nil
                local spacingAfterFeedItem = getSpacingAfterFeedItem(gapBetweenFeedItems, k, gapAfterFirstFeedItem, samePoolFeedItemGap, config2)

                if spacingAfterFeedItem ~= nil and spacingAfterFeedItem > 0 then
                    local str2 = `{str1}_GapAfter`
                    sduiFeedChildren[str2] = React.createElement("Frame", {
                        Size = UDim2.new(1, 0, 0, spacingAfterFeedItem),
                        BackgroundTransparency = 1,
                        BorderSizePixel = 0,
                        LayoutOrder = var10 + 1
                    })
                end
            else
                var10 = nil
            end

            local createElement = React.createElement
            local var11 = SduiFeedItem
            local tbl4 = {
                layoutOrder = 0,
                zIndex = 0,
                index = 0,
                impressionsTag = 0,
                selectionBehaviorLeft = 0,
                selectionBehaviorRight = 0,
                defaultFocusRef = 0
            }

            if FFlagSduiIndividualFeedItemSpacing then
                var7 = var10
            end

            tbl4.layoutOrder = var7
            tbl4.zIndex = zIndex
            tbl4.index = index
            tbl4.impressionsTag = tbl2.impressionsTag
            tbl4.selectionBehaviorLeft = tbl2.selectionBehaviorLeft
            tbl4.selectionBehaviorRight = tbl2.selectionBehaviorRight
            tbl4.defaultFocusRef = if FFlagAppPageShellScrollToTopFocus and k == 1 then tbl2.defaultFocusRef else nil
            sduiFeedChildren[str1] = createElement(var11, tbl4, { Item = element })
        end
    end
    return sduiFeedChildren
end

return buildSduiFeedChildren

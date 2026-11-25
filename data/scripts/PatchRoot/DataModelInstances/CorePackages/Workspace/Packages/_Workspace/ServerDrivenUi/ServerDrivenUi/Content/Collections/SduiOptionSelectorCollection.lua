-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:20:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUi = script:FindFirstAncestor("ServerDrivenUi")
local ServerDrivenUiParent = ServerDrivenUi.Parent

local React = require(ServerDrivenUiParent.React)
local Cryo = require(ServerDrivenUiParent.Cryo)
local useTokens = require(ServerDrivenUiParent.Foundation).Hooks.useTokens

local SduiCoreSystem = require(ServerDrivenUiParent.SduiCoreSystem)
local SduiComponentType = SduiCoreSystem.SduiComponentType
local SduiErrorType = SduiCoreSystem.SduiErrors.SduiErrorType
local SduiPlaceholderWrapper = require(ServerDrivenUiParent.SduiSharedContent).SduiPlaceholderWrapper

local SduiVariableItemWidthCarousel = require(ServerDrivenUi.Content.Collections.SduiVariableItemWidthCarousel)

local FFlagSduiOptionImpressionsEventName = require(ServerDrivenUiParent.SharedFlags).FFlagSduiOptionImpressionsEventName
local FFlagSduiOptionSelectorHeaderComponent = require(ServerDrivenUiParent.SharedFlags).FFlagSduiOptionSelectorHeaderComponent
local FFlagSduiChartsSortDetailGenreFilter = require(ServerDrivenUiParent.SharedFlags).FFlagSduiChartsSortDetailGenreFilter
local FFlagSduiOptionSelectorAnchorTag = require(ServerDrivenUiParent.SharedFlags).FFlagSduiOptionSelectorAnchorTag

local FFlagSduiOptionSelectorSkipSelectedRefresh = require(ServerDrivenUiParent.SharedFlags).FFlagSduiOptionSelectorSkipSelectedRefresh

return React.memo(function(tbl1) -- name: SduiOptionSelectorCollection
    local sduiContext = tbl1.sduiContext

    local var1 = useTokens()
    local offset = tbl1.paddingBetweenOptionSelectorAndCollection or var1.Size.Size_400

    local var2, var3 = React.useState(nil)

    local var4 = var2 or tbl1.selectedOption

    local var5 = React.useRef(0)

    React.useEffect(function()
        var3(nil)
    end, { tbl1.selectedOption })

    local useCallback = React.useCallback
    local function func1(selectedOption)
        if typeof(selectedOption) ~= "string" or selectedOption == "" then
            sduiContext.dependencies.logger.reportError(SduiErrorType.InvalidActionParams, {
                name = SduiComponentType.OptionSelectorCollection,
                message = `Invalid or missing option id: {selectedOption}`,
                propName = "optionId"
            }, sduiContext.appPage)
            return
        end

        if (if FFlagSduiOptionSelectorSkipSelectedRefresh then var4 else var2) == selectedOption then
            return
        end

        local current = nil
        if not FFlagSduiChartsSortDetailGenreFilter then
            var3(selectedOption)

            local var6 = var5
            var6.current += 1
            current = var5.current
        end

        local var6 = tbl1.onOptionActivated(nil, nil, { selectedOption = selectedOption })

        if FFlagSduiChartsSortDetailGenreFilter then
            if var6 == nil then
                return
            end
            var3(selectedOption)

            local var7 = var5
            var7.current += 1
            current = var5.current
        end

        if typeof(var6) ~= "table" or typeof(var6.finally) ~= "function" then
            sduiContext.dependencies.logger.reportError(SduiErrorType.InvalidActionParams, {
                name = SduiComponentType.OptionSelectorCollection,
                message = "onOptionActivated did not return a refresh promise",
                propName = "onOptionActivated"
            }, sduiContext.appPage)
            var3(nil)
            return
        end

        var6:finally(function()
            if var5.current == current then
                var3(nil)
            end
        end)
    end

    local onOptionActivated = tbl1.onOptionActivated
    local var6 = if FFlagSduiOptionSelectorSkipSelectedRefresh then nil else var2
    local var7 = if FFlagSduiOptionSelectorSkipSelectedRefresh then var4 else nil
    local var8 = useCallback(func1, { onOptionActivated, sduiContext, var6, var5, var7 })

    local items, var10 = React.useMemo(function()
        if not (tbl1.optionItemConfigs and tbl1.optionsData) then
            sduiContext.dependencies.logger.reportError(SduiErrorType.InvalidProps, {
                componentType = SduiComponentType.OptionSelectorCollection,
                message = `Missing {if tbl1.optionItemConfigs then "optionsData" else "optionItemConfigs"} prop`,
                propName = if tbl1.optionItemConfigs then "optionsData" else "optionItemConfigs"
            }, sduiContext.appPage)

            return {}
        end

        local tbl2 = {}
        local var9 = FFlagSduiOptionSelectorAnchorTag and {} or nil

        for k, optionItemConfig in tbl1.optionItemConfigs do
            local var10 = tbl1.optionsData[k]
            local id = if var10 then var10.id else nil

            if FFlagSduiOptionSelectorAnchorTag and var9 then
                local anchorTag = if var10 then var10.anchorTag else nil

                if anchorTag == "" then
                    anchorTag = nil
                end

                var9[k] = anchorTag
            end

            local var11 = table.clone(optionItemConfig)

            local join = Cryo.Dictionary.join
            local var12 = optionItemConfig.props or {}
            local tbl3 = {
                isChecked = not (id == nil) and id == var4,
                onActivated = 0
            }

            function tbl3.onActivated()
                var8(id)
            end

            var11.props = join(var12, tbl3)

            table.insert(tbl2, var11)
        end

        if FFlagSduiOptionSelectorAnchorTag then
            return tbl2, var9
        end

        return tbl2, nil
    end, {
        tbl1.optionItemConfigs,
        tbl1.optionsData,
        var4,
        var8
    })
    local real = React.useMemo(function()
        local var11 = tbl1.collectionComponent.props and tbl1.collectionComponent.props.extraLocalProps or {}

        return React.cloneElement(tbl1.collectionComponent, {
            extraLocalProps = Cryo.Dictionary.join(var11, {
                index = tbl1.index,
                scrollViewPositionChangedSignal = tbl1.scrollViewPositionChangedSignal,
                verticalScrollingFrameRef = tbl1.verticalScrollingFrameRef,
                selectionOrderBase = tbl1.selectionOrderBase,
                startRow = tbl1.startRow,
                numUpdatesToDelayImpressions = tbl1.numUpdatesToDelayImpressions,
                appCompositionEnabled = tbl1.appCompositionEnabled
            })
        })
    end, {
        tbl1.collectionComponent,
        tbl1.index,
        tbl1.scrollViewPositionChangedSignal,
        tbl1.verticalScrollingFrameRef,
        tbl1.selectionOrderBase,
        tbl1.startRow,
        tbl1.numUpdatesToDelayImpressions,
        tbl1.appCompositionEnabled
    })

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        LayoutOrder = tbl1.layoutOrder,
        Size = UDim2.fromScale(1, 0)
    }
    local tbl3 = {
        UIListLayout = React.createElement(
            "UIListLayout",
            {
                FillDirection = Enum.FillDirection.Vertical,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, offset)
            }
        ),
        OptionSelector = 0,
        Collection = 0
    }
    local createElement2 = React.createElement
    local var12 = SduiVariableItemWidthCarousel
    local tbl4 = {
        sduiContext = sduiContext,
        analyticsContext = tbl1.analyticsContext,
        componentConfig = tbl1.componentConfig,
        debugName = if tbl1.debugName then `{tbl1.debugName}.OptionSelector` else nil,
        index = tbl1.index,
        layoutOrder = 1,
        impressionEventName = if FFlagSduiOptionImpressionsEventName then tbl1.optionImpressionEventName else nil,
        skipItemImpressionsLog = if FFlagSduiOptionImpressionsEventName then tbl1.skipOptionItemImpressionsLog else nil,
        scrollViewPositionChangedSignal = tbl1.scrollViewPositionChangedSignal,
        verticalScrollingFrameRef = tbl1.verticalScrollingFrameRef,
        selectionOrderBase = tbl1.selectionOrderBase,
        startRow = tbl1.startRow,
        numUpdatesToDelayImpressions = tbl1.numUpdatesToDelayImpressions,
        appCompositionEnabled = tbl1.appCompositionEnabled,
        items = items,
        itemTags = 0,
        itemHeight = 0,
        itemPadding = 0,
        sideMargin = 0,
        scrollButtonsEnabled = 0,
        headerComponent = 0,
        title = 0
    }

    if not FFlagSduiOptionSelectorAnchorTag then
        var10 = nil
    end

    tbl4.itemTags = var10
    tbl4.itemHeight = tbl1.itemHeight
    tbl4.itemPadding = tbl1.itemPadding

    tbl4.scrollButtonsEnabled = tbl1.scrollButtonsEnabled
    tbl4.headerComponent = if FFlagSduiOptionSelectorHeaderComponent then tbl1.headerComponent else nil
    tbl4.title = tbl1.title
    tbl3.OptionSelector = createElement2(var12, tbl4)

    tbl3.Collection = React.createElement(SduiPlaceholderWrapper, {
        isPlaceholder = var2 ~= nil,
        layoutOrder = 2,
        transitionDurationSeconds = tbl1.placeholderTransitionDurationSeconds,
        mountRealDuringPlaceholder = false,
        real = real,
        placeholder = tbl1.placeholderCollectionComponent
    })
    return createElement(str1, tbl2, tbl3)
end)

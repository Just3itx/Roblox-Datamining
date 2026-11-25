-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:00:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedContentParent = script:FindFirstAncestor("SduiSharedContent").Parent

local Cryo = require(SduiSharedContentParent.Cryo)
local React = require(SduiSharedContentParent.React)
local View = require(SduiSharedContentParent.Foundation).View
local _SduiCompat = require(SduiSharedContentParent.SduiCompat)

local _DiscoveryTypes = require(SduiSharedContentParent.DiscoveryTypes)
local GameFilters = require(SduiSharedContentParent.GameFilters)
local FilterPillCarousel = GameFilters.FilterPillCarousel
local getOptionContextTag = GameFilters.getOptionContextTag

local _UnifiedLogging = require(SduiSharedContentParent.UnifiedLogging)

local SduiCoreSystem = require(SduiSharedContentParent.SduiCoreSystem)
local reportUnifiedLoggingImpressions = SduiCoreSystem.reportUnifiedLoggingImpressions
local SduiComponentType = SduiCoreSystem.SduiComponentType

local useCollectionAnalyticsContext = require(script.Parent.useCollectionAnalyticsContext)

local function buildSelectionsFromGroups(filterGroups)
    local selectionsFromGroups = {}
    if not filterGroups then
        return selectionsFromGroups
    end
    for _, filterGroup in filterGroups do
        if filterGroup.filterType and filterGroup.filterType ~= "" then
            selectionsFromGroups[filterGroup.filterType] = filterGroup.selectedOptionId or filterGroup.defaultOptionId
        end
    end
    return selectionsFromGroups
end

local function convertToFilterModel(tbl1, selectedOptionId: string)
    local displayName = tbl1.displayName
    local filterOptions = {}

    for _, option in tbl1.options do
        table.insert(
            filterOptions,
            {
                optionId = option.optionId,
                optionDisplayName = option.displayName,
                optionContextTag = option.optionContextTag
            }
        )

        if option.optionId == selectedOptionId then
            displayName = option.displayName
        end
    end

    local tbl3

    if tbl1.inactiveOptionIds and #tbl1.inactiveOptionIds > 0 then
        tbl3 = {}
        for _, inactiveOptionId in tbl1.inactiveOptionIds do
            tbl3[inactiveOptionId] = true
        end
    else
        tbl3 = nil
    end

    return {
        filterId = tbl1.filterId,
        filterType = tbl1.filterType or "",
        filterDisplayName = tbl1.displayName,
        filterOptions = filterOptions,
        defaultOptionId = tbl1.defaultOptionId,
        selectedOptionId = selectedOptionId,
        selectedOptionDisplayName = displayName,
        inactiveOptionIds = tbl3
    }
end

return React.memo(function(tbl1) -- name: SduiFilterPillsCarousel
    local filterGroups = tbl1.filterGroups
    local sduiContext = tbl1.sduiContext
    local analyticsContext = tbl1.analyticsContext

    local var1, var2 = React.useState(function()
        return (buildSelectionsFromGroups(filterGroups))
    end)

    React.useEffect(function()
        if filterGroups then
            var2((buildSelectionsFromGroups(filterGroups)))
        end
    end, { filterGroups })

    local containerRef = React.useRef(nil)

    local filters = React.useMemo(function()
        if not filterGroups then
            return {}
        end
        local result = {}
        for _, filterGroup in filterGroups do
            local filterType = filterGroup.filterType or ""
            local var4 = if filterType == "" then nil else var1[filterType]
            table.insert(result, (convertToFilterModel(filterGroup, var4 or filterGroup.defaultOptionId)))
        end
        return result
    end, { filterGroups, var1 })

    local _, var5 = useCollectionAnalyticsContext(
        analyticsContext,
        SduiComponentType.FilterPillsCarousel,
        #filters,
        #filters,
        sduiContext,
        nil
    )

    local var6 = React.useMemo(function()
        local result = {}
        for itemPosition, value2 in filters do
            table.insert(result, {
                id = value2.filterId,
                itemPosition = itemPosition,
                itemComponentType = "FilterPill",
                filterId = value2.filterId,
                selectedOptionId = value2.selectedOptionId or "",
                selectedOptionContextTag = getOptionContextTag(value2, value2.selectedOptionId)
            })
        end

        return result
    end, { filters })

    local sendImpressions = React.useCallback(function(tbl2)
        reportUnifiedLoggingImpressions(
            sduiContext,
            tbl2,
            var6,
            var5.current,
            nil,
            tbl1.impressionEventName,
            tbl1.skipItemImpressionsLog
        )
    end, {
        sduiContext,
        var6,
        var5,
        tbl1.impressionEventName,
        tbl1.skipItemImpressionsLog
    })

    local sendFilterClick = React.useCallback(function(buttonName: string, filterId: string, selectedOptionId: string, previousOptionId: string?, selectedOptionContextTag: string?, previousOptionContextTag: string?, isActive: boolean?)
        if not tbl1.onFilterClick then
            return
        end

        tbl1.onFilterClick(nil, nil, {
            buttonName = buttonName,
            filterId = filterId,
            selectedOptionId = selectedOptionId,
            previousOptionId = previousOptionId,
            selectedOptionContextTag = selectedOptionContextTag,
            previousOptionContextTag = previousOptionContextTag,
            isActive = isActive
        })
    end, { tbl1.onFilterClick })

    local onFilterApplied = React.useCallback(function(str1: string, str2: string)
        var2(function(arg1)
            local filterSelections = Cryo.Dictionary.join(arg1, { [str1] = str2 })

            if tbl1.onFilterApplied then
                tbl1.onFilterApplied(nil, nil, { filterSelections = filterSelections })
            end

            return filterSelections
        end)
    end, { tbl1.onFilterApplied })

    local sortIndex = if var5.current then var5.current.collectionPosition else 0

    if not filterGroups or #filterGroups == 0 then
        return nil
    end

    return React.createElement(View, {
        tag = tbl1.tag,
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        backgroundStyle = tbl1.backgroundStyle
    }, {
        Content = React.createElement(FilterPillCarousel, {
            title = tbl1.title,
            filters = filters,
            sortIndex = sortIndex,
            onFilterApplied = onFilterApplied,
            containerRef = containerRef,
            pageContext = sduiContext.routeName or sduiContext.appPage,
            dataUpdatedTimestamp = sduiContext.dataUpdatedTimestamp,
            scrollViewPositionChangedSignal = tbl1.scrollViewPositionChangedSignal,
            sendImpressions = sendImpressions,
            sendFilterClick = sendFilterClick
        })
    })
end)

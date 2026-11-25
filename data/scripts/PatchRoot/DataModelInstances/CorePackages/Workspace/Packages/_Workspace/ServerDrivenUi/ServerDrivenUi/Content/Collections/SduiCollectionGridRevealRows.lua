-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:20:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUiParent = script:FindFirstAncestor("ServerDrivenUi").Parent

local React = require(ServerDrivenUiParent.React)
local Cryo = require(ServerDrivenUiParent.Cryo)
local CollectionGrid = require(ServerDrivenUiParent.CollectionViews).CollectionGrid

local GuiService = game:GetService("GuiService")
local ReactFocusNavigation = require(ServerDrivenUiParent.ReactFocusNavigation)
local DiscoveryEventErrorLogger = require(ServerDrivenUiParent.DiscoveryUtils).DiscoveryEventErrorLogger
local showMoreClickEvent = require(ServerDrivenUiParent.DiscoveryAnalytics).Events.showMoreClickEvent

local SduiCoreSystem = require(ServerDrivenUiParent.SduiCoreSystem)
local findAnalyticsFieldInAncestors = SduiCoreSystem.findAnalyticsFieldInAncestors
local getSduiComponentWrapper = SduiCoreSystem.getSduiComponentWrapper

local FIntLuaAppGameGridRevealMoreButtonGapPx = require(ServerDrivenUiParent.SharedFlags).FIntLuaAppGameGridRevealMoreButtonGapPx

local function isPositive(num1: number?): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return not (num1 == nil) and num1 > 0
end

local function getTotalRowsInGrid(itemCount: number, itemsPerRow: number, maxNumRows: number?) -- Luacid: Inlined by compiler; 1 call site recovered
    if itemsPerRow <= 0 then
        return nil
    end

    local num1 = math.ceil(itemCount / itemsPerRow)
    if maxNumRows ~= nil and maxNumRows > 0 then
        num1 = math.min(num1, maxNumRows)
    end
    return num1
end

local function getInitialVisibleRowsInGrid(initialFeedVisibleRows: number?, startRow: number?) -- Luacid: Inlined by compiler; 1 call site recovered
    if initialFeedVisibleRows == nil or startRow == nil then
        return nil, false
    end

    local num1 = initialFeedVisibleRows - (startRow - 1)
    if num1 <= 0 then
        return nil, true
    end

    return num1, false
end

return React.memo(function(tbl1) -- name: SduiCollectionGridRevealRows
    local totalNumberOfRows = getTotalRowsInGrid(tbl1.itemCount, tbl1.itemsPerRow, tbl1.maxNumRows)
    local bool1 = isPositive(tbl1.initialFeedVisibleRows) and isPositive(tbl1.visibleRowsPerReveal)

    local var1, bool2 = getInitialVisibleRowsInGrid(tbl1.initialFeedVisibleRows, tbl1.startRow)
    local var2, var3 = React.useState(var1)

    React.useEffect(function()
        var3(var1)
    end, {
        var1,
        tbl1.initialFeedVisibleRows,
        tbl1.visibleRowsPerReveal,
        tbl1.startRow,
        tbl1.sduiContext.dataUpdatedTimestamp
    })

    React.useEffect(function()
        if bool1 and bool2 then
            DiscoveryEventErrorLogger.reportError(
                "SduiCollectionGridRevealRowsInvalidFeedThreshold",
                "Unable to reveal CollectionGrid rows because the grid starts after the feed threshold",
                {
                    initialFeedVisibleRows = tbl1.initialFeedVisibleRows,
                    startRow = tbl1.startRow
                }
            )
        end
    end, {
        bool1,
        bool2,
        tbl1.initialFeedVisibleRows,
        tbl1.startRow
    })

    local bool3 = bool1 and not bool2

    if bool3 then
        if totalNumberOfRows == nil then
            bool3 = false
        else
            bool3 = var2 ~= nil
        end
    end

    local previousVisibleRows = if bool3 then math.min(var2, totalNumberOfRows) else nil
    local bool4 = bool3 and previousVisibleRows < totalNumberOfRows
    local var5 = if bool4 then previousVisibleRows else nil

    React.useLayoutEffect(function()
        tbl1.setDisplayedRowCount(var5)
    end, { tbl1.setDisplayedRowCount, var5 })

    React.useEffect(function()
        local setDisplayedRowCount = tbl1.setDisplayedRowCount
        return function()
            setDisplayedRowCount(nil)
        end
    end, { tbl1.setDisplayedRowCount })

    local containerRef = ReactFocusNavigation.useMostRecentFocusBehavior(tbl1.setContainerFrame)
    local var7 = ReactFocusNavigation.useFocusGuiObject()

    local topicId = findAnalyticsFieldInAncestors("collectionId", tbl1.analyticsContext)
    local sortIndex = findAnalyticsFieldInAncestors("collectionPosition", tbl1.analyticsContext)
    local onActivated = React.useCallback(function()
        if previousVisibleRows == nil or totalNumberOfRows == nil or tbl1.visibleRowsPerReveal == nil then
            return
        end

        if GuiService.SelectedCoreObject ~= nil and tbl1.containerFrame ~= nil then
            var7(tbl1.containerFrame)
        end

        local newVisibleRows = math.min(previousVisibleRows + tbl1.visibleRowsPerReveal, totalNumberOfRows)
        var3(newVisibleRows)

        if typeof(topicId) ~= "string" or typeof(sortIndex) ~= "number" then
            DiscoveryEventErrorLogger.reportError(
                "SduiCollectionGridRevealRowsMissingAnalytics",
                "Revealed CollectionGrid rows without valid collection analytics",
                { topicId = topicId, sortIndex = sortIndex }
            )

            return
        end

        showMoreClickEvent(tbl1.sduiContext.appPage or tbl1.sduiContext.routeName or "", {
            topicId = topicId,
            sortIndex = sortIndex,
            previousVisibleRows = previousVisibleRows,
            newVisibleRows = newVisibleRows,
            visibleRowsPerReveal = tbl1.visibleRowsPerReveal,
            totalNumberOfRows = totalNumberOfRows
        })
    end, {
        totalNumberOfRows,
        var7,
        tbl1.containerFrame,
        tbl1.sduiContext,
        tbl1.visibleRowsPerReveal,
        sortIndex,
        topicId,
        previousVisibleRows
    })

    local element = React.createElement(getSduiComponentWrapper(tbl1.revealRowsComponent), {
        componentConfig = tbl1.revealRowsComponent,
        sduiContext = tbl1.sduiContext,
        debugName = "SduiCollectionGridRevealRows.RevealRowsComponent",
        extraLocalProps = { onActivated = onActivated, layoutOrder = 2, zIndex = 1 }
    })

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        LayoutOrder = tbl1.gridProps.LayoutOrder
    }
    local tbl3 = {
        UIListLayout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, FIntLuaAppGameGridRevealMoreButtonGapPx)
        }),
        CollectionGrid = React.createElement(
            CollectionGrid,
            Cryo.Dictionary.join(tbl1.gridProps, {
                containerRef = containerRef,
                LayoutOrder = 1,
                ZIndex = if bool3 then 2 else tbl1.gridProps.ZIndex,
                maxNumRows = if bool3 then previousVisibleRows else tbl1.gridProps.maxNumRows
            })
        ),
        RevealMoreButton = 0
    }

    if not bool4 then
        element = nil
    end

    tbl3.RevealMoreButton = element
    return createElement(str1, tbl2, tbl3)
end)

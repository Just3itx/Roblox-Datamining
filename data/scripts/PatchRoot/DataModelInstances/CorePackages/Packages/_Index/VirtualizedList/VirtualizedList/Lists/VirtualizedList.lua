-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:51:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local LuauPolyfill = require(scriptParentParentParent.LuauPolyfill)
local SafeFlags = require(scriptParentParentParent.SafeFlags)
local Array = LuauPolyfill.Array
local Boolean = LuauPolyfill.Boolean
local Map = LuauPolyfill.Map
local Object = LuauPolyfill.Object
local Set = LuauPolyfill.Set
local console = LuauPolyfill.console

local var1 = SafeFlags.createGetFFlag("VirtualizedListStableCells")()

local function isIndexTruthy(initialScrollIndex: number?): boolean -- Luacid: Inlined by compiler; 5 call sites recovered
    return not (initialScrollIndex == nil) and initialScrollIndex ~= 1
end

local Batchinator = require(scriptParentParent.Interaction.Batchinator)

local FillRateHelper = require(script.Parent.FillRateHelper)

local tbl1 = {
    findNodeHandle = function(_)
        warn("ReactNative.findNodeHandle is not implemented")
    end
}

local ScrollView = require(scriptParentParent.Components.ScrollView.ScrollView)
local StyleSheet = require(scriptParentParent.StyleSheet.StyleSheet)

local View = require(scriptParentParent.Components.View.View)

local ViewabilityHelper = require(script.Parent.ViewabilityHelper)

local function func1(...)
    return {}
end
local infoLog = require(scriptParentParent.Utilities.infoLog)
local invariant = require(scriptParentParent.jsUtils.invariant)

local VirtualizeUtils = require(script.Parent.VirtualizeUtils)
local keyExtractor = VirtualizeUtils.keyExtractor
local computeWindowedRenderLimits = VirtualizeUtils.computeWindowedRenderLimits

local React = require(scriptParentParentParent.React)

local _ScrollView = require(scriptParentParent.Components.ScrollView.ScrollView)

local VirtualizedListContext = require(script.Parent.VirtualizedListContext)
local VirtualizedListCellContextProvider = VirtualizedListContext.VirtualizedListCellContextProvider
local VirtualizedListContext2 = VirtualizedListContext.VirtualizedListContext
local VirtualizedListContextProvider = VirtualizedListContext.VirtualizedListContextProvider

local describeNestedLists = nil
local var2 = nil
local var3 = nil

local function RefreshControl(arg1)
    return React.createElement("Frame", { Name = "RCTRefreshControl" }, arg1.children)
end

local bool1 = false
local str1 = ""

local function horizontalOrDefault(horizontal: boolean?): boolean? -- Luacid: Inlined by compiler; 9 call sites recovered
    return not (horizontal == nil) and horizontal
end

local function initialNumToRenderOrDefault(initialNumToRender: number?): number -- Luacid: Inlined by compiler; 2 call sites recovered
    return if initialNumToRender == nil then 10 else initialNumToRender
end

local function maxToRenderPerBatchOrDefault(maxToRenderPerBatch: number?): number -- Luacid: Inlined by compiler; 3 call sites recovered
    return if maxToRenderPerBatch == nil then 10 else maxToRenderPerBatch
end

local function onEndReachedThresholdOrDefault(onEndReachedThreshold: number?): number -- Luacid: Inlined by compiler; 2 call sites recovered
    return if onEndReachedThreshold == nil then 2 else onEndReachedThreshold
end

local function scrollEventThrottleOrDefault(scrollEventThrottle: number?): number -- Luacid: Inlined by compiler; 1 call site recovered
    return if scrollEventThrottle == nil then 50 else scrollEventThrottle
end

local function windowSizeOrDefault(windowSize: number?): number -- Luacid: Inlined by compiler; 3 call sites recovered
    return if windowSize == nil then 21 else windowSize
end

local function compareItemDataOrDefault(compareItemData: ((...any) -> (...any))?): (any, any) -> boolean | (...any) -> (...any) -- Luacid: Inlined by compiler; 1 call site recovered
    return if compareItemData == nil then function(arg1, arg2): boolean
        return arg1 == arg2
    end else compareItemData
end

local var4 = React.PureComponent:extend("VirtualizedList")
var4.contextType = VirtualizedListContext2

function var4.init(arg1, props)
    arg1.props = props
    arg1._viewabilityTuples = {}
    arg1._averageCellLength = 0

    arg1._cellKeysToChildListKeys = Map.new()
    arg1._cellRefs = {}
    arg1._cellLayoutHandlers = {}
    arg1._cellRefHandlers = {}
    arg1._frames = {}
    arg1._footerLength = 0
    arg1._hasDoneInitialScroll = false
    arg1._hasInteracted = false
    arg1._hasMore = false
    arg1._hasWarned = {}
    arg1._headerLength = 0
    arg1._hiPriInProgress = false
    arg1._highestMeasuredFrameIndex = 1
    arg1._indicesToKeys = Map.new()
    arg1._nestedChildLists = Map.new()

    arg1._offsetFromParentVirtualizedList = 0
    arg1._prevParentOffset = 0
    arg1._scrollMetrics = {
        contentLength = 0,
        dOffset = 0,
        dt = 10,
        offset = 0,
        timestamp = 0,
        velocity = 0,
        visibleLength = 0
    }

    arg1._scrollRef = nil
    arg1._sentEndForContentLength = 0
    arg1._totalCellLength = 0
    arg1._totalCellsMeasured = 0

    arg1._canvasPosition = Vector2.new(0, 0)
    arg1._canvasSize = UDim2.new(0, 0, 0, 0)

    arg1._invertedCanvasLength = if arg1.props.getItemLayout then 0 else arg1.props.invertedCanvasLength or 1000

    function arg1._getFrameMetrics(index: number)
        local data = arg1.props.data
        local getItem = arg1.props.getItem
        local getItemCount = arg1.props.getItemCount
        local getItemLayout = arg1.props.getItemLayout
        invariant(index <= getItemCount(data), "Tried to get frame for out of range index " .. tostring(index))

        local item = getItem(data, index)
        if item ~= nil then
            item = arg1._frames[arg1:_keyExtractor(item, index)]
        end

        if (not item or item.index ~= index) and getItemLayout then
            item = getItemLayout(data, index)
        end

        return item
    end

    invariant(
        windowSizeOrDefault(props.windowSize) > 0,
        "VirtualizedList: The windowSize prop must be present and set to a value greater than 0."
    )

    arg1._fillRateHelper = FillRateHelper.new(arg1._getFrameMetrics)
    function arg1._updateCellsToRender()
        local data = arg1.props.data
        local getItemCount = arg1.props.getItemCount
        local num1 = onEndReachedThresholdOrDefault(arg1.props.onEndReachedThreshold)

        local var5 = arg1:_isVirtualizationDisabled()
        arg1:_updateViewableItems(data)
        if not Boolean.toJSBoolean(data) then
            return
        end
        arg1:setState(function(arg2)
            local var6 = nil

            local contentLength = arg1._scrollMetrics.contentLength
            local offset = arg1._scrollMetrics.offset
            local visibleLength = arg1._scrollMetrics.visibleLength
            if var5 then
                local num2 = if contentLength - visibleLength - offset < num1 * visibleLength then maxToRenderPerBatchOrDefault(arg1.props.maxToRenderPerBatch) else 0

                var6 = { first = 1, last = 0 }

                local var7 = arg2.last + num2
                var6.last = math.min(var7, getItemCount(data))
            elseif visibleLength > 0
                and contentLength > 0
                and (not isIndexTruthy(arg1.props.initialScrollIndex) or Boolean.toJSBoolean(arg1._scrollMetrics.offset))
            then
                var6 = computeWindowedRenderLimits(
                    arg1.props.data,
                    arg1.props.getItemCount,
                    maxToRenderPerBatchOrDefault(arg1.props.maxToRenderPerBatch),
                    windowSizeOrDefault(arg1.props.windowSize),
                    arg2,
                    arg1._getFrameMetricsApprox,
                    arg1._scrollMetrics
                )
            end
            if var6 ~= nil and arg1._nestedChildLists.size > 0 then
                local first = var6.first
                local last = var6.last

                while first <= last do
                    local var7 = arg1._indicesToKeys:get(first)
                    if Boolean.toJSBoolean(var7) then
                        var7 = arg1._cellKeysToChildListKeys:get(var7)
                    end
                    if not Boolean.toJSBoolean(var7) then
                        continue
                    end

                    local bool2 = false

                    for _, value in ipairs(var7) do
                        local var8 = arg1._nestedChildLists:get(value)
                        if var8 and var8.ref and var8.ref:hasMore() then
                            bool2 = true
                            break
                        end
                    end

                    if bool2 then
                        var6.last = first
                        break
                    end

                    first += 1
                end
            end
            if var6 ~= nil and var6.first == arg2.first and var6.last == arg2.last then
                var6 = nil
            end

            return var6
        end)
    end
    arg1._updateCellsToRenderBatcher = Batchinator.new(
        arg1._updateCellsToRender,
        if arg1.props.updateCellsBatchingPeriod == nil then 50 else arg1.props.updateCellsBatchingPeriod
    )

    if arg1.props.viewabilityConfigCallbackPairs then
        arg1._viewabilityTuples = Array.map(arg1.props.viewabilityConfigCallbackPairs, function(arg2)
            return {
                viewabilityHelper = ViewabilityHelper.new(arg2.viewabilityConfig),
                onViewableItemsChanged = arg2.onViewableItemsChanged
            }
        end)
    else
        local onViewableItemsChanged = arg1.props.onViewableItemsChanged
        local viewabilityConfig = arg1.props.viewabilityConfig
        if onViewableItemsChanged then
            table.insert(
                arg1._viewabilityTuples,
                {
                    viewabilityHelper = ViewabilityHelper.new(viewabilityConfig),
                    onViewableItemsChanged = onViewableItemsChanged
                }
            )
        end
    end

    local tbl2 = {
        first = if isIndexTruthy(arg1.props.initialScrollIndex) then arg1.props.initialScrollIndex else 1,
        last = 0,
        firstItemTracked = 0,
        scrollPositionDelta = 0
    }
    local var5 = arg1.props.getItemCount(arg1.props.data) + 1
    local var6 = (if isIndexTruthy(arg1.props.initialScrollIndex) then arg1.props.initialScrollIndex else 1) + initialNumToRenderOrDefault(arg1.props.initialNumToRender)
    tbl2.last = math.min(var5, var6) - 1
    local firstItemTracked = if arg1.props.data and arg1.props.getItemCount(arg1.props.data) > 0 then arg1.props.getItem(arg1.props.data, 1) else Object.None
    tbl2.firstItemTracked = firstItemTracked

    if arg1:_isNestedWithSameOrientation() then
        local state = arg1.context.getNestedChildState(arg1:_getListKey())
        if Boolean.toJSBoolean(state) then
            arg1.state = state
            arg1._frames = state.frames
            tbl2 = state
        end
    end

    arg1.state = tbl2

    function arg1._getScrollMetrics()
        return arg1._scrollMetrics
    end

    function arg1._getOutermostParentListRef()
        if arg1:_isNestedWithSameOrientation() then
            return arg1.context.getOutermostParentListRef()
        end
        return arg1
    end

    function arg1._getNestedChildState(str2: string)
        local var8 = arg1._nestedChildLists:get(str2)
        return var8 and var8.state
    end

    function arg1._registerAsNestedChild(tbl3)
        local var8 = arg1._cellKeysToChildListKeys:get(tbl3.cellKey) or Set.new()
        var8:add(tbl3.key)
        arg1._cellKeysToChildListKeys:set(tbl3.cellKey, var8)
        local var9 = arg1._nestedChildLists:get(tbl3.key)
        if var9 and var9.ref ~= nil then
            console.error(
                "A VirtualizedList contains a cell which itself contains "
                    .. "more than one VirtualizedList of the same orientation as the parent "
                        .. "list. You must pass a unique listKey prop to each sibling list.\n\n" .. describeNestedLists(Object.assign({}, tbl3, { horizontal = Boolean.toJSBoolean(tbl3.ref.props.horizontal) }))
            )
        end

        arg1._nestedChildLists:set(tbl3.key, { ref = tbl3.ref, state = nil })
        if arg1._hasInteracted then
            tbl3.ref:recordInteraction()
        end
        return nil
    end

    function arg1._unregisterAsNestedChild(tbl3)
        arg1._nestedChildLists:set(tbl3.key, { ref = nil, state = tbl3.state })
    end

    function arg1._onUpdateSeparators(arg2, arg3)
        Array.forEach(arg2, function(arg4)
            local _cellRef = not (arg4 == nil) and arg1._cellRefs[tostring(arg4)]

            if Boolean.toJSBoolean(_cellRef) then
                return _cellRef:updateSeparatorProps(arg3)
            end
        end)
    end

    function arg1._getSpacerKey(bool2: boolean): string
        return if bool2 then "height" else "width"
    end

    function arg1._captureScrollRef(_scrollRef)
        arg1._scrollRef = _scrollRef
    end

    function arg1._defaultRenderScrollComponent(arg2)
        local onRefresh = arg2.onRefresh
        if arg1:_isNestedWithSameOrientation() then
            return React.createElement(View, arg2)
        end

        if not onRefresh then
            return React.createElement(ScrollView, arg2)
        end

        local var8 = invariant
        local bool2 = typeof(arg2.refreshing) == "boolean"
        local str2 = "`refreshing` prop must be set as a boolean in order to use `onRefresh`, but got `"
        local var9 = if arg2.refreshing == nil then "undefined" else tostring(arg2.refreshing) .. "`"
        var8(bool2, str2 .. var9)

        return React.createElement(
            ScrollView,
            Object.assign(table.clone(arg2), {
                refreshControl = if arg2.refreshControl == nil then React.createElement(
                    RefreshControl,
                    {
                        refreshing = arg2.refreshing,
                        onRefresh = onRefresh,
                        progressViewOffset = arg2.progressViewOffset
                    }
                ) else arg2.refreshControl
            })
        )
    end
    function arg1._onCellUnmount(str2: string)
        local var8 = arg1._frames[str2]
        if var8 ~= nil then
            arg1._frames[str2] = Object.assign({}, var8, { inLayout = false })
        end
        if var1 then
            arg1._cellLayoutHandlers[str2] = nil
            arg1._cellRefHandlers[str2] = nil
        end
    end

    function arg1._onLayout(arg2)
        if arg1:_isNestedWithSameOrientation() then
            arg1:measureLayoutRelativeToContainingList()
        else
            arg1._scrollMetrics.visibleLength = arg1:_selectLength({ width = arg2.AbsoluteSize.X, height = arg2.AbsoluteSize.Y })
        end

        if arg1.props.onLayout then
            arg1.props.onLayout(arg2)
        end
        arg1:_scheduleCellsToRenderUpdate()
        arg1:_maybeCallOnEndReached()
    end

    function arg1._onLayoutEmpty(arg2)
        if arg1.props.onLayout then
            arg1.props.onLayout(arg2)
        end
    end

    function arg1._onLayoutFooter(arg2)
        arg1:_triggerRemeasureForChildListsInCell(arg1:_getFooterCellKey())
        arg1._footerLength = arg1:_selectLength({ height = arg2.AbsoluteSize.Y, width = arg2.AbsoluteSize.X })
    end

    function arg1._onLayoutHeader(arg2)
        arg1._headerLength = arg1:_selectLength({ height = arg2.AbsoluteSize.Y, width = arg2.AbsoluteSize.X })
    end

    function arg1._onContentSizeChange(width: number, height: number)
        if width > 0
            and height > 0
            and arg1.props.initialScrollIndex ~= nil
            and arg1.props.initialScrollIndex > 1
            and not arg1._hasDoneInitialScroll
        then
            if arg1.props.contentOffset == nil then
                arg1:scrollToIndex({ animated = false, index = arg1.props.initialScrollIndex })
            end
            arg1._hasDoneInitialScroll = true
        elseif arg1.props.inverted and width > 0 and height > 0 and not arg1._hasDoneInitialScroll then
            arg1._hasDoneInitialScroll = true
            task.defer(function()
                while arg1:getScrollRef() == nil do
                    task.wait()
                end
                if arg1.props.contentOffset ~= nil then
                    return
                end

                local current = arg1:getScrollRef()._nativeRef.current
                if arg1.props.horizontal then
                    current.CanvasPosition = Vector2.new(current.AbsoluteCanvasSize.X, current.CanvasPosition.Y)
                    return
                end
                current.CanvasPosition = Vector2.new(current.CanvasPosition.X, current.AbsoluteCanvasSize.Y)
            end)
        end

        if arg1.props.onContentSizeChange then
            arg1.props.onContentSizeChange(width, height)
        end
        arg1._scrollMetrics.contentLength = arg1:_selectLength({ height = height, width = width })
        arg1:_scheduleCellsToRenderUpdate()
        arg1:_maybeCallOnEndReached()
    end

    function arg1._convertParentScrollMetrics(tbl3)
        local offset = tbl3.offset - arg1._offsetFromParentVirtualizedList

        local visibleLength = tbl3.visibleLength
        local dOffset = offset - arg1._scrollMetrics.offset
        return {
            visibleLength = visibleLength,
            contentLength = arg1._scrollMetrics.contentLength,
            offset = offset,
            dOffset = dOffset
        }
    end
    function arg1._onScroll(arg2)
        arg1._nestedChildLists:forEach(function(arg3)
            if arg3.ref then
                arg3.ref._onScroll(arg2)
            end
        end)
        if arg1.props.onScroll then
            arg1.props.onScroll(arg2)
        end
        local timestamp = os.clock()
        local var8 = arg2:GetChildren()[1]
        local var9 = arg1:_selectLength({ height = arg2.AbsoluteSize.Y, width = arg2.AbsoluteSize.X })
        local var10 = arg1:_selectLength({ height = var8.AbsoluteSize.Y, width = var8.AbsoluteSize.X })
        local offset

        if arg1.props.inverted then
            offset = arg1:_selectOffset({
                x = arg2.AbsoluteCanvasSize.X - arg2.CanvasPosition.X - var9,
                y = arg2.AbsoluteCanvasSize.Y - arg2.CanvasPosition.Y - var9
            })
        else
            offset = arg1:_selectOffset({ x = arg2.CanvasPosition.X, y = arg2.CanvasPosition.Y })
        end

        local var11 = offset - arg1._scrollMetrics.offset
        if arg1:_isNestedWithSameOrientation() then
            if arg1._scrollMetrics.contentLength == 0 then
                return
            end

            local var12 = arg1._convertParentScrollMetrics({ var9, offset })

            var9 = var12.visibleLength
            var10 = var12.contentLength
            offset = var12.offset
            var11 = var12.dOffset
        end

        local var12 = if Boolean.toJSBoolean(arg1._scrollMetrics.timestamp) then math.max(1, (timestamp - arg1._scrollMetrics.timestamp) * 1000) else 1
        local velocity = var11 / var12

        if var12 > 500 and arg1._scrollMetrics.dt > 500 and 5 * var9 < var10 and not arg1._hasWarned.perf then
            infoLog(
                "VirtualizedList: You have a large list that is slow to update - make sure your renderItem function renders components that follow React performance best practices like PureComponent, shouldComponentUpdate, etc.",
                {
                    dt = var12,
                    prevDt = arg1._scrollMetrics.dt,
                    contentLength = var10
                }
            )
            arg1._hasWarned.perf = true
        end
        arg1._scrollMetrics = {
            contentLength = var10,
            dt = var12,
            dOffset = var11,
            offset = offset,
            timestamp = timestamp,
            velocity = velocity,
            visibleLength = var9
        }

        local scrollPositionDelta = arg1.state.scrollPositionDelta
        if scrollPositionDelta > 0 then
            arg1:setState(function(tbl3)
                return {
                    scrollPositionDelta = 0,
                    first = tbl3.first + scrollPositionDelta,
                    last = tbl3.last + scrollPositionDelta
                }
            end)
        end
        arg1:_updateViewableItems(arg1.props.data)
        if not arg1.props then
            return
        end
        arg1:_maybeCallOnEndReached()
        if velocity ~= 0 then
            arg1._fillRateHelper:activate()
        end
        arg1:_computeBlankness()
        arg1:_scheduleCellsToRenderUpdate()
    end

    function arg1._onScrollBeginDrag(arg2)
        arg1._nestedChildLists:forEach(function(arg3)
            if arg3.ref then
                arg3.ref._onScrollBeginDrag(arg2)
            end
        end)
        Array.forEach(arg1._viewabilityTuples, function(arg3)
            arg3.viewabilityHelper:recordInteraction()
        end)
        arg1._hasInteracted = true
        if arg1.props.onScrollBeginDrag then
            arg1.props.onScrollBeginDrag(arg2)
        end
    end

    function arg1._onScrollEndDrag(arg2)
        arg1._nestedChildLists:forEach(function(arg3)
            if arg3.ref then
                arg3.ref._onScrollEndDrag(arg2)
            end
        end)

        if Boolean.toJSBoolean(nil) then
            arg1._scrollMetrics.velocity = arg1:_selectOffset(nil)
        end
        arg1:_computeBlankness()
        if arg1.props.onScrollEndDrag then
            arg1.props.onScrollEndDrag(arg2)
        end
    end

    function arg1._onMomentumScrollBegin(arg2)
        arg1._nestedChildLists:forEach(function(arg3)
            if arg3.ref then
                arg3.ref._onMomentumScrollBegin(arg2)
            end
        end)
        if arg1.props.onMomentumScrollBegin then
            arg1.props.onMomentumScrollBegin(arg2)
        end
    end

    function arg1._onMomentumScrollEnd(arg2)
        arg1._nestedChildLists:forEach(function(arg3)
            if arg3.ref then
                arg3.ref._onMomentumScrollEnd(arg2)
            end
        end)
        arg1._scrollMetrics.velocity = 0
        arg1:_computeBlankness()
        if arg1.props.onMomentumScrollEnd then
            arg1.props.onMomentumScrollEnd(arg2)
        end
    end

    function arg1._createViewToken(index: number, isViewable: boolean)
        local data = arg1.props.data
        local item = arg1.props.getItem(data, index)
        return {
            index = index,
            item = item,
            key = arg1:_keyExtractor(item, index),
            isViewable = isViewable
        }
    end
    function arg1._getFrameMetricsApprox(index: number)
        local var8 = arg1._getFrameMetrics(index)
        if var8 ~= nil and var8.index == index then
            return var8
        end
        local getItemLayout = arg1.props.getItemLayout

        invariant(not getItemLayout, "Should not have to estimate frames when a measurement metrics function is provided")

        return {
            length = arg1._averageCellLength,
            offset = arg1._averageCellLength * (index - 1)
        }
    end
end

function var4.scrollToEnd(tbl2, tbl3)
    local animated = tbl3 == nil or tbl3.animated
    local itemCount = tbl2.props.getItemCount(tbl2.props.data)
    local var6 = tbl2._getFrameMetricsApprox(itemCount)
    local var7 = if tbl2.props.inverted then 0 else math.max(0, var6.offset + var6.length + tbl2._footerLength - tbl2._scrollMetrics.visibleLength)

    if tbl2._scrollRef == nil then
        return
    end

    if tbl2._scrollRef.scrollTo == nil then
        console.warn(
            "No scrollTo method provided. This may be because you have two nested VirtualizedLists with the same orientation, or because you are using a custom component that does not implement scrollTo."
        )
        return
    end

    tbl2._scrollRef.scrollTo(
        horizontalOrDefault(tbl2.props.horizontal) and { x = var7, animated = animated } or {
            y = var7,
            animated = animated
        }
    )
end

function var4.scrollToIndex(tbl2, tbl3)
    local data = tbl2.props.data
    local horizontal = tbl2.props.horizontal
    local getItemCount = tbl2.props.getItemCount
    local getItemLayout = tbl2.props.getItemLayout
    local onScrollToIndexFailed = tbl2.props.onScrollToIndexFailed

    local animated = tbl3.animated
    local index = tbl3.index
    local viewOffset = tbl3.viewOffset
    local viewPosition = tbl3.viewPosition
    invariant(index >= 1, ("scrollToIndex out of range: requested index %d but minimum is 1"):format(index))

    invariant(
        getItemCount(data) >= 1,
        ("scrollToIndex out of range: item length %d but minimum is 1"):format(getItemCount(data))
    )
    invariant(
        index <= getItemCount(data),
        ("scrollToIndex out of range: requested index %d is out of 1 to %d"):format(index, getItemCount(data))
    )
    if not getItemLayout and tbl2._highestMeasuredFrameIndex < index then
        invariant(
            Boolean.toJSBoolean(onScrollToIndexFailed),
            "scrollToIndex should be used in conjunction with getItemLayout or onScrollToIndexFailed, otherwise there is no way to know the location of offscreen indices or handle failures."
        )

        onScrollToIndexFailed({
            averageItemLength = tbl2._averageCellLength,
            highestMeasuredFrameIndex = tbl2._highestMeasuredFrameIndex,
            index = index
        })
        return
    end

    local current = if tbl2:getScrollRef() then tbl2:getScrollRef()._nativeRef.current else nil

    if current == nil then
        return
    end
    local absoluteCanvasSize = current.AbsoluteCanvasSize
    local absoluteSize = current.AbsoluteSize

    local var5 = tbl2._getFrameMetricsApprox(index)

    local num1 = 0
    local var6

    if tbl2.props.inverted then
        var6 = (if horizontal then absoluteCanvasSize.X else absoluteCanvasSize.Y)
            - (if horizontal then absoluteSize.X else absoluteSize.Y)
            - var5.offset
            - (Boolean.toJSBoolean(viewPosition) and viewPosition or 0) * (tbl2._scrollMetrics.visibleLength - var5.length)
    else
        var6 = var5.offset - (Boolean.toJSBoolean(viewPosition) and viewPosition or 0) * (tbl2._scrollMetrics.visibleLength - var5.length)
    end

    local var7 = math.max(num1, var6) - (Boolean.toJSBoolean(viewOffset) and viewOffset or 0)

    if tbl2._scrollRef == nil then
        return
    end

    if tbl2._scrollRef.scrollTo == nil then
        console.warn(
            "No scrollTo method provided. This may be because you have two nested VirtualizedLists with the same orientation, or because you are using a custom component that does not implement scrollTo."
        )
        return
    end

    tbl2._scrollRef.scrollTo(horizontal and { x = var7, animated = animated } or { y = var7, animated = animated })
end

function var4.scrollToItem(tbl2, tbl3)
    local item = tbl3.item
    local data = tbl2.props.data
    local getItem = tbl2.props.getItem
    local itemCount = tbl2.props.getItemCount(data)
    local num1 = 1

    while num1 <= itemCount do
        if getItem(data, num1) == item then
            tbl2:scrollToIndex(Object.assign({}, tbl3, { index = num1 }))
            return
        end
        num1 += 1
    end
end

function var4.scrollToOffset(tbl2, tbl3)
    local current = if tbl2:getScrollRef() then tbl2:getScrollRef()._nativeRef.current else nil

    if current == nil then
        return
    end

    local animated = tbl3.animated
    local offset = tbl3.offset
    if tbl2._scrollRef == nil then
        return
    end

    if tbl2.props.inverted then
        local absoluteCanvasSize = current.AbsoluteCanvasSize
        local absoluteSize = current.AbsoluteSize
        offset = (if tbl2.props.horizontal then absoluteCanvasSize.X else absoluteCanvasSize.Y) - offset - (if tbl2.props.horizontal then absoluteSize.X else absoluteSize.Y)
    end

    if tbl2._scrollRef.scrollTo == nil then
        console.warn(
            "No scrollTo method provided. This may be because you have two nested VirtualizedLists with the same orientation, or because you are using a custom component that does not implement scrollTo."
        )

        return
    end

    tbl2._scrollRef.scrollTo(
        horizontalOrDefault(tbl2.props.horizontal) and { x = offset, animated = animated }
            or { y = offset, animated = animated }
    )
end

function var4.recordInteraction(arg1)
    arg1._nestedChildLists:forEach(function(arg2)
        if arg2.ref then
            arg2.ref:recordInteraction()
        end
    end)
    Array.forEach(arg1._viewabilityTuples, function(arg2)
        arg2.viewabilityHelper:recordInteraction()
    end)
    arg1:_updateViewableItems(arg1.props.data)
end

function var4.flashScrollIndicators(arg1)
    if arg1._scrollRef == nil then
        return
    end

    arg1._scrollRef:flashScrollIndicators()
end

function var4.getScrollResponder(arg1)
    if arg1._scrollRef and arg1._scrollRef.getScrollResponder then
        return arg1._scrollRef:getScrollResponder()
    end

    return nil
end

function var4.getScrollableNode(arg1)
    if arg1._scrollRef and arg1._scrollRef.getScrollableNode then
        return arg1._scrollRef:getScrollableNode()
    end
    return tbl1.findNodeHandle(arg1._scrollRef)
end

function var4.getScrollRef(arg1)
    if arg1._scrollRef and arg1._scrollRef.getScrollRef then
        return arg1._scrollRef:getScrollRef()
    end
    return arg1._scrollRef
end

function var4.setNativeProps(arg1, arg2)
    if arg1._scrollRef then
        arg1._scrollRef:setNativeProps(arg2)
    end
end

function var4._getCellKey(arg1)
    return if arg1.context and arg1.context.cellKey then arg1.context.cellKey else "rootList"
end

function var4._getListKey(arg1)
    if Boolean.toJSBoolean(arg1.props.listKey) then
        return arg1.props.listKey
    end

    return (arg1:_getCellKey())
end

function var4._getDebugInfo(arg1)
    return {
        listKey = arg1:_getListKey(),
        cellKey = arg1:_getCellKey(),
        horizontal = horizontalOrDefault(arg1.props.horizontal),
        parent = if arg1.context then arg1.context.debugInfo else nil
    }
end

function var4.hasMore(arg1)
    return arg1._hasMore
end

function var4.componentDidMount(ref)
    if not ref:_isNestedWithSameOrientation() then
        return
    end

    ref.context.registerAsNestedChild(
        {
            cellKey = ref:_getCellKey(),
            key = ref:_getListKey(),
            ref = ref,
            parentDebugInfo = ref.context.debugInfo
        }
    )
end

function var4.componentWillUnmount(arg1)
    if arg1:_isNestedWithSameOrientation() then
        arg1.context.unregisterAsNestedChild(
            {
                key = arg1:_getListKey(),
                state = {
                    first = arg1.state.first,
                    last = arg1.state.last,
                    frames = arg1._frames
                }
            }
        )
    end

    arg1:_updateViewableItems(nil)
    arg1._updateCellsToRenderBatcher:dispose({ abort = true })
    Array.forEach(arg1._viewabilityTuples, function(arg2)
        arg2.viewabilityHelper:dispose()
    end)
    arg1._fillRateHelper:deactivateAndFlush()
end

function var4.getDerivedStateFromProps(arg1, tbl2)
    local data = arg1.data
    local getItemCount = arg1.getItemCount
    local maintainVisibleContentPosition = arg1.maintainVisibleContentPosition
    local firstItemTracked = tbl2.firstItemTracked
    local scrollPositionDelta = tbl2.scrollPositionDelta
    local var5 = compareItemDataOrDefault(arg1.compareItemData)
    local item = if data and getItemCount(data) > 0 then arg1.getItem(data, 1) else nil

    local function findItem(data2, firstItemTracked2)
        local var6 = nil
        for i = 1, #data2 do
            if var5(data2[i], firstItemTracked2) then
                var6 = i
                break
            end
        end

        return if var6 == nil then 1 else var6
    end
    if maintainVisibleContentPosition and scrollPositionDelta == 0 and firstItemTracked ~= nil and item ~= nil then
        scrollPositionDelta = if var5(firstItemTracked, item) then 0 else findItem(data, firstItemTracked) - 1
    end

    local itemCount = getItemCount(data)
    local num1 = maxToRenderPerBatchOrDefault(arg1.maxToRenderPerBatch)
    local first = math.max(1, math.min(tbl2.first, itemCount - num1))

    if itemCount > 0 and itemCount < first + scrollPositionDelta then
        console.warn(
            "WARNING: maintainVisibleContentPosition failed because scrollPositionDelta was out of bounds. This could indicate that items in `data` are getting removed, items are getting added to the middle of `data`, or a different `data` array is getting passed in. Consider changing the `key` prop of the List if the `data` prop is significantly altered."
        )
        scrollPositionDelta = 0
    end

    if scrollPositionDelta > 0 then
        for i = 1, math.min(scrollPositionDelta, itemCount) do
            arg1.getItem(data, i).shouldResizeOnMount = true
        end
    end

    return {
        first = first,
        last = math.max(1, math.min(tbl2.last, itemCount)),
        firstItemTracked = item or Object.None,
        scrollPositionDelta = scrollPositionDelta
    }
end

function var4._pushCells(tbl2, tbl3: {any}, tbl4: {number}, arg1, num1: number, num2: number, inversionStyle)
    local cellRendererComponent = tbl2.props.CellRendererComponent
    local itemSeparatorComponent = tbl2.props.ItemSeparatorComponent
    local data = tbl2.props.data
    local getItem = tbl2.props.getItem
    local getItemCount = tbl2.props.getItemCount
    local horizontal = tbl2.props.horizontal
    local num3 = if tbl2.props.ListHeaderComponent then 1 else 0
    local itemCount = getItemCount(data)

    num2 = math.min(itemCount, num2)
    local var5 = nil

    while true do
        local index = num1

        if not (index <= num2) then
            break
        end

        local item = getItem(data, index)

        local var6 = tbl2:_keyExtractor(item, index)
        tbl2._indicesToKeys:set(index, var6)
        if arg1:has(index + num3) then
            table.insert(tbl4, #tbl3)
        end

        table.insert(
            tbl3,
            React.createElement(var3, {
                CellRendererComponent = cellRendererComponent,
                ItemSeparatorComponent = if index < itemCount then itemSeparatorComponent else nil,
                cellKey = var6,
                fillRateHelper = tbl2._fillRateHelper,
                horizontal = horizontal,
                index = index,
                inversionStyle = inversionStyle,
                item = item,
                key = var6,
                prevCellKey = var5,
                onUpdateSeparators = tbl2._onUpdateSeparators,
                onLayout = not var1 and function(arg2)
                    return tbl2:_onCellLayout(arg2, var6, index)
                end or tbl2:_getCellLayoutHandler(var6, index),
                onUnmount = tbl2._onCellUnmount,
                parentProps = tbl2.props,
                ref = not var1 and function(arg2)
                    tbl2._cellRefs[tostring(var6)] = arg2
                end or tbl2:_getCellRefHandler(var6),
                isSequentiallySelectable = tbl2.props.isSequentiallySelectable
            })
        )

        num1 = index + 1
        var5 = var6
    end
end

function var4._isVirtualizationDisabled(arg1)
    return not (arg1.props.disableVirtualization == nil) and arg1.props.disableVirtualization
end

function var4._isNestedWithSameOrientation(arg1): boolean
    local context = arg1.context
    return not (context == nil) and Boolean.toJSBoolean(context.horizontal) == horizontalOrDefault(arg1.props.horizontal)
end

function var4._keyExtractor(tbl2, arg1, num1: number)
    if tbl2.props.keyExtractor ~= nil then
        return tbl2.props.keyExtractor(arg1, num1)
    end

    local var5 = keyExtractor(arg1, num1)
    if var5 == tostring(num1) then
        bool1 = true
        if arg1.type ~= nil and Boolean.toJSBoolean(arg1.type.displayName) then
            str1 = arg1.type.displayName
        end
    end
    return var5
end

function var4.render(arg1)
    if _G.__DEV__ then
        local tbl2 = func1(arg1.props.contentContainerStyle)
        if tbl2 ~= nil and tbl2.flexWrap == "wrap" then
            console.warn(
                "`flexWrap: `wrap`` is not supported with the `VirtualizedList` components.Consider using `numColumns` with `FlatList` instead."
            )
        end
    end

    local listEmptyComponent = arg1.props.ListEmptyComponent
    local listFooterComponent = arg1.props.ListFooterComponent
    local listHeaderComponent = arg1.props.ListHeaderComponent
    local data = arg1.props.data
    local horizontal = arg1.props.horizontal

    local var5 = arg1:_isVirtualizationDisabled()
    local layoutStyle = if arg1.props.inverted then if horizontalOrDefault(arg1.props.horizontal) then var2.horizontallyInverted else var2.verticallyInverted else nil
    local tbl2 = {}
    local set = Set.new(arg1.props.stickyHeaderIndices)
    local stickyHeaderIndices = {}
    if listHeaderComponent then
        if set:has(0) then
            table.insert(stickyHeaderIndices, 0)
        end

        local var7 = if React.isValidElement(listHeaderComponent) then listHeaderComponent else React.createElement(listHeaderComponent, nil)
        table.insert(
            tbl2,
            React.createElement(
                VirtualizedListCellContextProvider,
                {
                    cellKey = arg1:_getCellKey() .. "-header",
                    key = "$header",
                    Name = "$header"
                },
                React.createElement(View, {
                    Name = "ListHeaderComponent",
                    onLayout = arg1._onLayoutHeader,
                    style = StyleSheet.compose(layoutStyle, arg1.props.ListHeaderComponentStyle),
                    LayoutOrder = if arg1.props.inverted then 999999998 else -999999998,
                    AutomaticSize = if horizontal then Enum.AutomaticSize.X else Enum.AutomaticSize.Y,
                    Size = if horizontal then UDim2.new(0, 0, 1, 0) else UDim2.new(1, 0, 0, 0)
                }, var7)
            )
        )
    end

    local itemCount = arg1.props.getItemCount(data)
    if itemCount > 0 then
        bool1 = false
        str1 = ""
        local var7 = arg1._getSpacerKey(not horizontal)
        local num1 = (if isIndexTruthy(arg1.props.initialScrollIndex) then -1 else initialNumToRenderOrDefault(arg1.props.initialNumToRender) - 1) + 1

        local first = arg1.state.first
        local last = arg1.state.last
        local scrollPositionDelta = arg1.state.scrollPositionDelta
        if scrollPositionDelta > 0 then
            first += scrollPositionDelta
            last += scrollPositionDelta
        end
        arg1:_pushCells(tbl2, stickyHeaderIndices, set, 1, num1, layoutStyle)
        local num2 = math.max(num1 + 1, first)

        if not var5 and num1 + 1 < first then
            local bool2 = false
            if set.size > 0 then
                local num3 = num2 - 1
                local num4 = if listHeaderComponent then 1 else 0

                while num1 < num3 do
                    if set:has(num3 + num4) then
                        local var8 = arg1._getFrameMetricsApprox(num1)
                        local var9 = arg1._getFrameMetricsApprox(num3)
                        local var10 = var9.offset - var8.offset - (if isIndexTruthy(arg1.props.initialScrollIndex) then 0 else var8.length)
                        table.insert(
                            tbl2,
                            React.createElement(View, {
                                key = "$sticky_lead",
                                Name = "$sticky_lead",
                                style = {
                                    Size = if var7 == "height" then UDim2.new(1, 0, 0, var10) else UDim2.new(0, var10, 1, 0)
                                }
                            })
                        )

                        arg1:_pushCells(tbl2, stickyHeaderIndices, set, num3, num3, layoutStyle)
                        local var11 = arg1._getFrameMetricsApprox(first).offset - var9.offset + var9.length
                        table.insert(
                            tbl2,
                            React.createElement(View, {
                                key = "$sticky_trail",
                                Name = "$sticky_trail",
                                style = {
                                    Size = if var7 == "height" then UDim2.new(1, 0, 0, var11) else UDim2.new(0, var11, 1, 0)
                                }
                            })
                        )
                        bool2 = true
                        break
                    end

                    num3 -= 1
                end
            end
            if not bool2 then
                local var8 = arg1._getFrameMetricsApprox(num1)
                local var9 = arg1._getFrameMetricsApprox(first).offset - (var8.offset + var8.length)
                table.insert(
                    tbl2,
                    React.createElement(View, {
                        key = "$lead_spacer",
                        Name = "$lead_spacer",
                        style = {
                            Size = if var7 == "height" then UDim2.new(1, 0, 0, var9) else UDim2.new(0, var9, 1, 0)
                        },
                        LayoutOrder = if arg1.props.inverted then 999999999 else -999999999
                    })
                )
            end
        end
        arg1:_pushCells(tbl2, stickyHeaderIndices, set, num2, last, layoutStyle)
        if not arg1._hasWarned.keys and bool1 then
            console.warn(
                "VirtualizedList: missing keys for items, make sure to specify a key or id property on each item or provide a custom keyExtractor.",
                str1
            )
            arg1._hasWarned.keys = true
        end
        if not var5 and last < itemCount then
            local var8 = arg1._getFrameMetricsApprox(last)
            local var9 = if arg1.props.getItemLayout then itemCount else math.min(itemCount, arg1._highestMeasuredFrameIndex)
            local var10 = arg1._getFrameMetricsApprox(var9)

            local var11 = var10.offset + var10.length - (var8.offset + var8.length)
            table.insert(
                tbl2,
                React.createElement(View, {
                    key = "$tail_spacer",
                    Name = "$tail_spacer",
                    style = {
                        Size = if var7 == "height" then UDim2.new(1, 0, 0, var11) else UDim2.new(0, var11, 1, 0)
                    },
                    LayoutOrder = if arg1.props.inverted then -999999999 else 999999999
                })
            )
        end
    elseif listEmptyComponent then
        if not React.isValidElement(listEmptyComponent) then
            listEmptyComponent = React.createElement(listEmptyComponent, nil)
        end

        table.insert(
            tbl2,
            React.cloneElement(listEmptyComponent, {
                key = "$empty",
                Name = "$empty",
                onLayout = function(arg2)
                    arg1._onLayoutEmpty(arg2)
                    if listEmptyComponent.props.onLayout then
                        listEmptyComponent.props.onLayout(arg2)
                    end
                end,
                style = StyleSheet.compose(layoutStyle, listEmptyComponent.props.style)
            })
        )
    end

    if listFooterComponent then
        if not React.isValidElement(listFooterComponent) then
            listFooterComponent = React.createElement(listFooterComponent, nil)
        end

        table.insert(
            tbl2,
            React.createElement(
                VirtualizedListCellContextProvider,
                {
                    cellKey = arg1:_getFooterCellKey(),
                    key = "$footer",
                    Name = "$footer"
                },
                React.createElement(View, {
                    Name = "ListFooterComponent",
                    onLayout = arg1._onLayoutFooter,
                    style = StyleSheet.compose(layoutStyle, arg1.props.ListFooterComponentStyle),
                    LayoutOrder = if arg1.props.inverted then -999999998 else 999999998,
                    AutomaticSize = if horizontal then Enum.AutomaticSize.X else Enum.AutomaticSize.Y,
                    Size = if horizontal then UDim2.new(0, 0, 1, 0) else UDim2.new(1, 0, 0, 0)
                }, listFooterComponent)
            )
        )
    end

    if arg1.props.inverted and not arg1.props.getItemLayout then
        if arg1:getScrollRef() ~= nil and arg1:getScrollRef()._nativeRef.current ~= nil then
            local current = arg1:getScrollRef()._nativeRef.current
            local canvasPosition = current.CanvasPosition
            local var7 = arg1._getFrameMetricsApprox(math.min(arg1._highestMeasuredFrameIndex, itemCount))
            local var8 = var7.offset + var7.length
            local bool2 = if arg1.props.optimizeInvertedCanvasResize then arg1._invertedCanvasLength - arg1._footerLength < var8 else var8 ~= arg1._invertedCanvasLength - arg1._footerLength

            if itemCount <= arg1._highestMeasuredFrameIndex and var8 ~= arg1._invertedCanvasLength - arg1._footerLength then
                local var9 = var8 + arg1._footerLength - arg1._invertedCanvasLength
                arg1._invertedCanvasLength = var8 + arg1._footerLength
                local uDim2 = if arg1.props.horizontal then UDim2.new(0, arg1._invertedCanvasLength, 1, 0) else UDim2.new(1, 0, 0, arg1._invertedCanvasLength)
                current.CanvasSize = uDim2

                arg1._canvasPosition = if arg1.props.horizontal then Vector2.new(canvasPosition.X + var9, canvasPosition.Y) else Vector2.new(canvasPosition.X, canvasPosition.Y + var9)

                arg1._canvasSize = uDim2
            elseif bool2 and arg1.state.scrollPositionDelta == 0 then
                local _invertedCanvasLength = arg1._invertedCanvasLength
                local var9 = arg1._scrollMetrics.visibleLength * windowSizeOrDefault(arg1.props.windowSize) * 0.5
                local var6 = var7.offset + arg1._scrollMetrics.visibleLength + var9
                local var11 = var6 - _invertedCanvasLength
                arg1._invertedCanvasLength = var6
                local uDim2 = if arg1.props.horizontal then UDim2.new(0, arg1._invertedCanvasLength, 1, 0) else UDim2.new(1, 0, 0, arg1._invertedCanvasLength)
                current.CanvasSize = uDim2
                current.CanvasPosition = if arg1.props.horizontal then Vector2.new(canvasPosition.X + var11, canvasPosition.Y) else Vector2.new(canvasPosition.X, canvasPosition.Y + var11)

                arg1._canvasPosition = current.CanvasPosition
                arg1._canvasSize = uDim2
            end
        else
            arg1._canvasPosition = if arg1.props.horizontal then Vector2.new(arg1._invertedCanvasLength, 0) else Vector2.new(0, arg1._invertedCanvasLength)

            arg1._canvasSize = if arg1.props.horizontal then UDim2.new(0, arg1._invertedCanvasLength, 1, 0) else UDim2.new(1, 0, 0, arg1._invertedCanvasLength)
        end
    elseif arg1.props.inverted and arg1.props.getItemLayout then
        local var7 = arg1._getFrameMetricsApprox(itemCount)
        if arg1:getScrollRef() ~= nil and arg1:getScrollRef()._nativeRef.current ~= nil then
            local current = arg1:getScrollRef()._nativeRef.current
            local canvasPosition = current.CanvasPosition
            local _invertedCanvasLength = arg1._invertedCanvasLength
            arg1._invertedCanvasLength = var7.offset + var7.length

            if _invertedCanvasLength ~= arg1._invertedCanvasLength then
                local var8 = arg1._invertedCanvasLength - _invertedCanvasLength

                current.CanvasPosition = if arg1.props.horizontal then canvasPosition + Vector2.new(var8, 0) else canvasPosition + Vector2.new(0, var8)
            end
        else
            arg1._invertedCanvasLength = var7.offset + var7.length
        end
    end

    local var7 = Object.assign(table.clone(arg1.props), {
        onContentSizeChange = arg1._onContentSizeChange,
        onLayout = arg1._onLayout,
        onScroll = arg1._onScroll,
        onScrollBeginDrag = arg1._onScrollBeginDrag,
        onScrollEndDrag = arg1._onScrollEndDrag,
        onMomentumScrollBegin = arg1._onMomentumScrollBegin,
        onMomentumScrollEnd = arg1._onMomentumScrollEnd,
        scrollEventThrottle = scrollEventThrottleOrDefault(arg1.props.scrollEventThrottle),
        invertStickyHeaders = if arg1.props.invertStickyHeaders ~= nil then arg1.props.invertStickyHeaders else arg1.props.inverted,
        stickyHeaderIndices = stickyHeaderIndices,
        style = arg1.props.style,
        layoutStyle = layoutStyle or nil,
        AutomaticCanvasSize = if arg1.props.inverted and not arg1.props.getItemLayout then Enum.AutomaticSize.None else nil,
        CanvasSize = if arg1.props.inverted then arg1._canvasSize else nil,
        CanvasPosition = if arg1.props.inverted then arg1._canvasPosition else nil
    })

    arg1._hasMore = arg1.state.last < arg1.props.getItemCount(arg1.props.data)
    local element = React.createElement(
        VirtualizedListContextProvider,
        {
            value = {
                cellKey = nil,
                getScrollMetrics = arg1._getScrollMetrics,
                horizontal = horizontalOrDefault(arg1.props.horizontal),
                getOutermostParentListRef = arg1._getOutermostParentListRef,
                getNestedChildState = arg1._getNestedChildState,
                registerAsNestedChild = arg1._registerAsNestedChild,
                unregisterAsNestedChild = arg1._unregisterAsNestedChild,
                debugInfo = arg1:_getDebugInfo()
            }
        },
        React.cloneElement(
            (if arg1.props.renderScrollComponent then arg1.props.renderScrollComponent else arg1._defaultRenderScrollComponent)(
                var7
            ),
            {
                ref = arg1._captureScrollRef
            },
            tbl2
        )
    )

    local var8 = if _G.__DEV__ then React.createElement(ScrollView.Context.Consumer, nil, function(arg2)
        if arg2 ~= nil
            and not arg2.horizontal == not horizontalOrDefault(arg1.props.horizontal)
            and not arg1._hasWarned.nesting
            and arg1.context == nil
        then
            console.error(
                "VirtualizedLists should never be nested inside plain ScrollViews with the same orientation because it can break windowing and other functionality - use another VirtualizedList-backed container instead."
            )

            arg1._hasWarned.nesting = true
        end
        return element
    end) else element

    if arg1.props.debug then
        return React.createElement(View, { style = var2.debug, Name = "debug" }, var8, arg1:_renderDebugOverlay())
    end
    return var8
end

function var4.componentDidUpdate(arg1, arg2)
    local data = arg1.props.data
    local extraData = arg1.props.extraData
    if data ~= arg2.data or extraData ~= arg2.extraData then
        Array.forEach(arg1._viewabilityTuples, function(arg3)
            arg3.viewabilityHelper:resetViewableIndices()
        end)
    end

    local _hiPriInProgress = arg1._hiPriInProgress
    arg1:_scheduleCellsToRenderUpdate()

    if _hiPriInProgress then
        arg1._hiPriInProgress = false
    end
end

function var4._computeBlankness(arg1)
    arg1._fillRateHelper:computeBlankness(arg1.props, arg1.state, arg1._scrollMetrics)
end

function var4._getCellLayoutHandler(tbl2, str2: string, index: number)
    local _cellLayoutHandler = tbl2._cellLayoutHandlers[str2]
    if _cellLayoutHandler ~= nil and _cellLayoutHandler.index == index then
        return _cellLayoutHandler.handler
    end

    local function handler(arg1)
        return tbl2:_onCellLayout(arg1, str2, index)
    end
    tbl2._cellLayoutHandlers[str2] = { index = index, handler = handler }
    return handler
end

function var4._getCellRefHandler(tbl2, str2: string)
    local _cellRefHandler = tbl2._cellRefHandlers[str2]
    if _cellRefHandler == nil then
        _cellRefHandler = function(arg1)
            tbl2._cellRefs[tostring(str2)] = arg1
        end
        tbl2._cellRefHandlers[str2] = _cellRefHandler
    end
    return _cellRefHandler
end

function var4._onCellLayout(tbl2, arg1, str2: string, index: number)
    local var5 = if tbl2:getScrollRef() and tbl2:getScrollRef()._nativeRef.current then tbl2:getScrollRef()._nativeRef.current else arg1:FindFirstAncestorOfClass("ScrollingFrame")

    if var5 == nil then
        if _G.__DEV__ then
            console.warn("CellLayout failed for index " .. tostring(index) .. ". this may cause layout issues")
        end
        return
    end

    local absolutePosition = var5.AbsolutePosition
    local canvasPosition = var5.CanvasPosition
    local absoluteCanvasSize = var5.AbsoluteCanvasSize

    local absoluteSize = arg1.AbsoluteSize
    local absolutePosition2 = arg1.AbsolutePosition
    local var6

    if tbl2.props.inverted and tbl2.props.horizontal then
        var6 = absoluteCanvasSize.X - canvasPosition.X - absolutePosition2.X - absoluteSize.X + absolutePosition.X
    else
        var6 = absolutePosition2.X - absolutePosition.X + canvasPosition.X
    end

    local var7

    if tbl2.props.inverted and not tbl2.props.horizontal then
        var7 = absoluteCanvasSize.Y - canvasPosition.Y - absolutePosition2.Y - absoluteSize.Y + absolutePosition.Y
    else
        var7 = absolutePosition2.Y - absolutePosition.Y + canvasPosition.Y
    end
    local tbl3 = {
        width = arg1.AbsoluteSize.X,
        height = arg1.AbsoluteSize.Y,
        x = var6,
        y = var7
    }

    local tbl4 = {
        offset = tbl2:_selectOffset(tbl3),
        length = tbl2:_selectLength(tbl3),
        index = index,
        inLayout = true
    }

    local var8 = tbl2._frames[str2]
    if not var8 or math.abs(tbl4.offset - var8.offset) > 1 or tbl4.length ~= var8.length or index ~= var8.index then
        local item = tbl2.props.getItem(tbl2.props.data, index)

        if not var8 and not tbl2.props.getItemLayout and typeof(item) == "table" and item.shouldResizeOnMount then
            tbl2:recalculateFrames(tbl2:_selectLength(tbl3), str2, index)
        end

        if var8 and not tbl2.props.getItemLayout and math.abs(tbl4.length - var8.length) >= 1 then
            if tbl2.props.UNSTABLE_forceSiblingLayoutUpdate then
                local frame = arg1:FindFirstAncestorOfClass("Frame")
                local var9 = not frame and {} or frame:GetChildren()
                local itemCount = tbl2.props.getItemCount(tbl2.props.data)
                Array.forEach(var9, function(arg2)
                    if not arg2:IsA("GuiObject") then
                        return
                    end

                    local num1 = math.abs(arg2.LayoutOrder)
                    if num1 <= index or itemCount < num1 then
                        return
                    end

                    local item2 = tbl2.props.getItem(tbl2.props.data, num1)
                    if item2 == nil then
                        return
                    end
                    local var10 = tbl2:_keyExtractor(item2, num1)

                    tbl2:_onCellLayout(arg2, var10, num1)
                end)
            else
                Array.forEach(Object.keys(tbl2._frames), function(arg2)
                    if tbl2._frames[arg2].index <= index then
                        return
                    end

                    local ref = if tbl2._cellRefs[arg2] then tbl2._cellRefs[arg2]:getRef() else nil

                    if ref and ref.current then
                        tbl2:_onCellLayout(ref.current, arg2, tbl2._frames[arg2].index)
                    end
                end)
            end
        end

        tbl2._totalCellLength += tbl4.length - (if Boolean.toJSBoolean(var8) then var8.length else 0)
        tbl2._totalCellsMeasured += if Boolean.toJSBoolean(var8) then 0 else 1
        tbl2._averageCellLength = tbl2._totalCellLength / tbl2._totalCellsMeasured
        tbl2._frames[str2] = tbl4
        local _highestMeasuredFrameIndex = tbl2._highestMeasuredFrameIndex
        tbl2._highestMeasuredFrameIndex = math.max(_highestMeasuredFrameIndex, index)
        tbl2:_scheduleCellsToRenderUpdate()

        if tbl2.props.inverted
            and not tbl2.props.getItemLayout
            and tbl2.state.last == tbl2.props.getItemCount(tbl2.props.data)
            and tbl2._highestMeasuredFrameIndex == tbl2.state.last
        then
            tbl2:forceUpdate()
        end
    else
        tbl2._frames[str2].inLayout = true
    end

    tbl2:_triggerRemeasureForChildListsInCell(str2)

    tbl2:_computeBlankness()
    tbl2:_updateViewableItems(tbl2.props.data)
end

function var4._triggerRemeasureForChildListsInCell(tbl2, str2: string)
    local var5 = tbl2._cellKeysToChildListKeys:get(str2)
    if not var5 then
        return
    end

    var5:forEach(function(arg1)
        local var6 = tbl2._nestedChildLists:get(arg1)
        if var6 and var6.ref then
            var6.ref:measureLayoutRelativeToContainingList()
        end
    end)
end

function var4.recalculateFrames(tbl2, num1: number, str2: string, index: number)
    Array.forEach(Object.keys(tbl2._frames), function(arg1)
        if arg1 == str2 and tbl2._frames[arg1].index >= index then
            return
        end
        local var5 = tbl2._frames[arg1]
        var5.index += 1
        local var6 = tbl2._frames[arg1]
        var6.offset += num1
    end)

    tbl2._highestMeasuredFrameIndex += 1
end

function var4.measureLayoutRelativeToContainingList(arg1)
    local success, result = pcall(function()
        if not Boolean.toJSBoolean(arg1._scrollRef) then
            return nil
        end

        arg1._scrollRef:measureLayout(arg1.context.getOutermostParentListRef():getScrollRef(), function(x, y, width, height)
            arg1._offsetFromParentVirtualizedList = arg1:_selectOffset({ x = x, y = y })
            arg1._scrollMetrics.contentLength = arg1:_selectLength({ width = width, height = height })
            local var5 = arg1._convertParentScrollMetrics(arg1.context.getScrollMetrics())

            if arg1._scrollMetrics.visibleLength == var5.visibleLength and arg1._scrollMetrics.offset == var5.offset then
                return
            end

            arg1._scrollMetrics.visibleLength = var5.visibleLength
            arg1._scrollMetrics.offset = var5.offset

            arg1._cellKeysToChildListKeys:forEach(function(arg4)
                if not arg4 then
                    return
                end

                arg4:forEach(function(arg5)
                    local var6 = arg1._nestedChildLists:get(arg5)
                    if var6 and var6.ref then
                        var6.ref:measureLayoutRelativeToContainingList()
                    end
                end)
            end)
        end, function(_)
            console.warn(
                "VirtualizedList: Encountered an error while measuring a list's offset from its containing VirtualizedList."
            )
        end)

        return nil
    end)
    if not success then
        console.warn("measureLayoutRelativeToContainingList threw an error", result.stack)
    end
end

function var4._getFooterCellKey(arg1)
    return arg1:_getCellKey() .. "-footer"
end

function var4._renderDebugOverlay(arg1)
    local var5 = arg1._scrollMetrics.visibleLength / (if Boolean.toJSBoolean(arg1._scrollMetrics.contentLength) then arg1._scrollMetrics.contentLength else 1)

    local itemCount = arg1.props.getItemCount(arg1.props.data)
    local num1 = 1
    local tbl2 = {}

    while num1 <= itemCount do
        local var6 = arg1._getFrameMetricsApprox(num1)

        if Boolean.toJSBoolean(var6.inLayout) then
            table.insert(tbl2, var6)
        end
        num1 += 1
    end
    local offset = arg1._getFrameMetricsApprox(arg1.state.first).offset
    local var6 = arg1._getFrameMetricsApprox(arg1.state.last)
    local var7 = var6.offset + var6.length - offset
    local offset2 = arg1._scrollMetrics.offset
    local visibleLength = arg1._scrollMetrics.visibleLength

    return React.createElement(View, {
        style = { var2.debugOverlayBase, var2.debugOverlay }
    }, Array.map(tbl2, function(arg2, num2: number)
        return React.createElement(View, {
            key = "f" .. tostring(num2),
            Name = "f" .. tostring(num2),
            style = {
                var2.debugOverlayBase,
                var2.debugOverlayFrame,
                {
                    top = arg2.offset * var5,
                    height = arg2.length * var5
                }
            }
        })
    end), React.createElement(View, {
        Name = "DebugOverlayLast",
        style = {
            var2.debugOverlayBase,
            var2.debugOverlayFrameLast,
            {
                top = offset * var5,
                height = var7 * var5
            }
        }
    }), React.createElement(View, {
        Name = "DebugOverlayVis",
        style = {
            var2.debugOverlayBase,
            var2.debugOverlayFrameVis,
            {
                top = offset2 * var5,
                height = visibleLength * var5
            }
        }
    }))
end

function var4._selectLength(arg1, arg2)
    return if horizontalOrDefault(arg1.props.horizontal) then arg2.width else arg2.height
end

function var4._selectOffset(arg1, arg2)
    return if horizontalOrDefault(arg1.props.horizontal) then arg2.x else arg2.y
end

function var4._maybeCallOnEndReached(arg1)
    local data = arg1.props.data
    local getItemCount = arg1.props.getItemCount
    local onEndReached = arg1.props.onEndReached
    local onEndReachedThreshold = arg1.props.onEndReachedThreshold

    local contentLength = arg1._scrollMetrics.contentLength
    local visibleLength = arg1._scrollMetrics.visibleLength
    local offset = arg1._scrollMetrics.offset

    local distanceFromEnd = contentLength - visibleLength - offset
    local var6 = if onEndReachedThreshold == nil then 2 else onEndReachedThreshold * visibleLength
    if onEndReached
        and arg1.state.last == getItemCount(data)
        and distanceFromEnd < var6
        and arg1._scrollMetrics.contentLength ~= arg1._sentEndForContentLength
    then
        arg1._sentEndForContentLength = arg1._scrollMetrics.contentLength
        onEndReached({ distanceFromEnd = distanceFromEnd })
    elseif var6 < distanceFromEnd then
        arg1._sentEndForContentLength = 0
    end
end

function var4._scheduleCellsToRenderUpdate(arg1)
    local first = arg1.state.first
    local last = arg1.state.last

    if arg1.state.scrollPositionDelta > 0 then
        return
    end

    local offset = arg1._scrollMetrics.offset
    local visibleLength = arg1._scrollMetrics.visibleLength
    local velocity = arg1._scrollMetrics.velocity
    local itemCount = arg1.props.getItemCount(arg1.props.data)
    local bool2 = false
    local var5 = onEndReachedThresholdOrDefault(arg1.props.onEndReachedThreshold) * visibleLength / 2

    if first > 1 then
        local var6 = offset - arg1._getFrameMetricsApprox(first).offset
        if not bool2 then
            if var6 < 0 then
                bool2 = true
            elseif velocity < -2 then
                bool2 = var6 < var5
            else
                bool2 = false
            end
        end
    end
    if last < itemCount then
        local var6 = arg1._getFrameMetricsApprox(last).offset - (offset + visibleLength)
        bool2 = bool2 or var6 < 0 or velocity > 2
    end

    if not (bool2 and (Boolean.toJSBoolean(arg1._averageCellLength) or arg1.props.getItemLayout)) or arg1._hiPriInProgress then
        arg1._updateCellsToRenderBatcher:schedule()

        return
    end

    arg1._hiPriInProgress = true

    arg1._updateCellsToRenderBatcher:dispose({ abort = true })
    arg1._updateCellsToRender()
end

function var4._updateViewableItems(arg1, arg2)
    local getItemCount = arg1.props.getItemCount
    Array.forEach(arg1._viewabilityTuples, function(arg3)
        arg3.viewabilityHelper:onUpdate(
            getItemCount(arg2),
            arg1._scrollMetrics.offset,
            arg1._scrollMetrics.visibleLength,
            arg1._getFrameMetrics,
            arg1._createViewToken,
            arg3.onViewableItemsChanged,
            arg1.state
        )
    end)
end

var3 = React.Component:extend("CellRenderer")

function var3.init(arg1, props)
    arg1.props = props

    arg1.state = {
        separatorProps = {
            highlighted = false,
            leadingItem = arg1.props.item
        }
    }

    arg1._separators = {
        highlight = function()
            local cellKey = arg1.props.cellKey
            local prevCellKey = arg1.props.prevCellKey
            arg1.props.onUpdateSeparators({ cellKey, prevCellKey }, { highlighted = true })
        end,
        unhighlight = function()
            local cellKey = arg1.props.cellKey
            local prevCellKey = arg1.props.prevCellKey
            arg1.props.onUpdateSeparators({ cellKey, prevCellKey }, { highlighted = false })
        end,
        updateProps = function(str2: string, arg2)
            local cellKey = arg1.props.cellKey
            local prevCellKey = arg1.props.prevCellKey
            local onUpdateSeparators = arg1.props.onUpdateSeparators
            if str2 ~= "leading" then
                prevCellKey = cellKey
            end

            onUpdateSeparators({ prevCellKey }, arg2)
        end
    }

    arg1._nativeRef = React.createRef()
end

function var3.getDerivedStateFromProps(tbl2, tbl3)
    return {
        separatorProps = Object.assign({}, tbl3.separatorProps, { leadingItem = tbl2.item })
    }
end

function var3.updateSeparatorProps(arg1, arg2)
    arg1:setState(function(arg3)
        return {
            separatorProps = Object.assign({}, arg3.separatorProps, arg2)
        }
    end)
end

local function shallowEqual(props, arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    for k, prop in props do
        if arg1[k] ~= prop then
            return false
        end
    end
    for value in arg1 do
        if props[value] == nil then
            return false
        end
    end
    return true
end

function var3.shouldComponentUpdate(tbl2, tbl3, tbl4)
    if not var1 then
        return true
    end

    local bool2 = not shallowEqual(tbl2.props, tbl3)

    if not bool2 then
        local separatorProps = tbl2.state.separatorProps
        local separatorProps2 = tbl4.separatorProps
        local bool3 = false

        for k, separatorProp in separatorProps do
            if separatorProps2[k] ~= separatorProp then
                bool3 = true
                break
            end
        end

        local bool4

        if bool3 then
            bool4 = false
        else
            bool4 = true

            for k in separatorProps2 do
                if separatorProps[k] == nil then
                    bool4 = false
                    break
                end
            end
        end

        bool2 = not bool4
    end

    return bool2
end

function var3.componentWillUnmount(arg1)
    arg1.props.onUnmount(arg1.props.cellKey)
end

function var3._renderElement(arg1, arg2, arg3, arg4, index)
    if Boolean.toJSBoolean(arg2) and Boolean.toJSBoolean(arg3) then
        console.warn(
            "VirtualizedList: Both ListItemComponent and renderItem props are present. ListItemComponent will take precedence over renderItem."
        )
    end

    if Boolean.toJSBoolean(arg3) then
        return React.createElement(arg3, { item = arg4, index = index, separators = arg1._separators })
    end

    if not Boolean.toJSBoolean(arg2) then
        invariant(false, "VirtualizedList: Either ListItemComponent or renderItem props are required but none were found.")
        return nil
    end

    return arg2({ item = arg4, index = index, separators = arg1._separators })
end

function var3.getRef(arg1)
    return arg1._nativeRef
end

function var3.render(arg1)
    local cellRendererComponent = arg1.props.CellRendererComponent
    local itemSeparatorComponent = arg1.props.ItemSeparatorComponent
    local fillRateHelper = arg1.props.fillRateHelper
    local horizontal = arg1.props.horizontal
    local item = arg1.props.item
    local index = arg1.props.index
    local inversionStyle = arg1.props.inversionStyle
    local parentProps = arg1.props.parentProps

    local renderItem = parentProps.renderItem
    local getItemLayout = parentProps.getItemLayout
    local var5 = arg1:_renderElement(renderItem, parentProps.ListItemComponent, item, index)
    local onLayout = if getItemLayout and not (parentProps.debug or fillRateHelper:enabled()) then nil else arg1.props.onLayout
    local element = itemSeparatorComponent
        and React.createElement(
            itemSeparatorComponent,
            Object.assign(arg1.state.separatorProps, { LayoutOrder = if inversionStyle then -1 else 1 })
        )
    local style = if Boolean.toJSBoolean(inversionStyle) then horizontal and { var2.rowReverse, inversionStyle } or { var2.columnReverse, inversionStyle } else horizontal and { var2.row, inversionStyle } or inversionStyle
    local var7

    if not Boolean.toJSBoolean(cellRendererComponent) then
        local createElement = React.createElement
        local var8 = View
        local tbl2 = {
            Name = "CellRendererView",
            style = style,
            onLayout = onLayout,
            LayoutOrder = 0,
            AutomaticSize = 0,
            nativeRef = 0,
            SelectionGroup = 0,
            SelectionBehaviorLeft = 0,
            SelectionBehaviorRight = 0,
            SelectionBehaviorUp = 0,
            SelectionBehaviorDown = 0
        }

        if inversionStyle then
            index = -index
        end

        tbl2.LayoutOrder = index
        tbl2.AutomaticSize = if horizontal then Enum.AutomaticSize.X else Enum.AutomaticSize.Y
        tbl2.nativeRef = arg1._nativeRef
        tbl2.SelectionGroup = if arg1.props.isSequentiallySelectable then true else nil
        tbl2.SelectionBehaviorLeft = if arg1.props.isSequentiallySelectable then if arg1.props.horizontal then Enum.SelectionBehavior.Escape else Enum.SelectionBehavior.Stop else nil

        tbl2.SelectionBehaviorRight = if arg1.props.isSequentiallySelectable then if arg1.props.horizontal then Enum.SelectionBehavior.Escape else Enum.SelectionBehavior.Stop else nil

        tbl2.SelectionBehaviorUp = if arg1.props.isSequentiallySelectable then if arg1.props.horizontal then Enum.SelectionBehavior.Stop else Enum.SelectionBehavior.Escape else nil

        tbl2.SelectionBehaviorDown = if arg1.props.isSequentiallySelectable then if arg1.props.horizontal then Enum.SelectionBehavior.Stop else Enum.SelectionBehavior.Escape else nil
        local element2 = if element then React.createElement("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            FillDirection = if horizontal then Enum.FillDirection.Horizontal else Enum.FillDirection.Vertical
        }) else nil
        var7 = createElement(var8, tbl2, element2, var5, element)
    else
        local createElement = React.createElement

        local var8 = Object.assign(table.clone(arg1.props), { style = style, onLayout = onLayout, nativeRef = arg1._nativeRef })
        local element2 = if element then React.createElement("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            FillDirection = if horizontal then Enum.FillDirection.Horizontal else Enum.FillDirection.Vertical
        }) else nil
        var7 = createElement(cellRendererComponent, var8, element2, var5, element)
    end

    return React.createElement(VirtualizedListCellContextProvider, { cellKey = arg1.props.cellKey }, var7)
end

describeNestedLists = function(tbl2): string
    local str2 = "VirtualizedList trace:\n" .. ("  Child (%s):\n"):format(if Boolean.toJSBoolean(tbl2.horizontal) then "horizontal" else "vertical") .. ("    listKey: %s\n"):format(tbl2.key) .. ("    cellKey: %s"):format(tbl2.cellKey)
    local parentDebugInfo = tbl2.parentDebugInfo

    while parentDebugInfo do
        str2 ..= ("\n  Parent (%s):\n"):format(if parentDebugInfo.horizontal then "horizontal" else "vertical") .. ("    listKey: %s\n"):format(parentDebugInfo.listKey) .. ("    cellKey: %s"):format(parentDebugInfo.cellKey)
        parentDebugInfo = parentDebugInfo.parent
    end
    return str2
end

var2 = StyleSheet.create({
    verticallyInverted = {
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        VerticalAlignment = Enum.VerticalAlignment.Bottom
    },
    horizontallyInverted = {
        HorizontalAlignment = Enum.HorizontalAlignment.Right,
        VerticalAlignment = Enum.VerticalAlignment.Center
    },
    row = {
        AutomaticSize = Enum.AutomaticSize.X,
        Size = UDim2.new(0, 0, 1, 0)
    },
    column = {
        AutomaticSize = Enum.AutomaticSize.Y
    },
    rowReverse = {
        flexDirection = "row-reverse",
        AutomaticSize = Enum.AutomaticSize.X,
        Size = UDim2.new(0, 0, 1, 0)
    },
    columnReverse = {
        flexDirection = "column-reverse",
        AutomaticSize = Enum.AutomaticSize.Y
    },
    debug = { flex = 1 },
    debugOverlayBase = { position = "absolute", top = 0, right = 0 },
    debugOverlay = { bottom = 0, width = 20, borderColor = "blue", borderWidth = 1 },
    debugOverlayFrame = { left = 0, backgroundColor = "orange" },
    debugOverlayFrameLast = { left = 0, borderColor = "green", borderWidth = 2 },
    debugOverlayFrameVis = { left = 0, borderColor = "red", borderWidth = 2 }
})

return var4

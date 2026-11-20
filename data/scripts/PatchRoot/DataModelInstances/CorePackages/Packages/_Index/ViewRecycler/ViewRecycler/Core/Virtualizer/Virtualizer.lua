-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:30:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FFlagViewRecyclerReact084 = require(script:FindFirstAncestor("ViewRecycler").Flags).FFlagViewRecyclerReact084
local FFlagViewRecyclerReact08 = require(script:FindFirstAncestor("ViewRecycler").Flags).FFlagViewRecyclerReact08
local ViewRecycler = script:FindFirstAncestor("ViewRecycler")

local AutoScroll = require(ViewRecycler.Core.ViewportBehavior.AutoScroll)

local _AutoScrollPolicy = require(ViewRecycler.Core.Enums.AutoScrollPolicy)

local AutoScrollTarget = require(ViewRecycler.Core.Enums.AutoScrollTarget)
local DataPrefetch = require(ViewRecycler.Core.DataPrefetch)
local _DataSource = require(ViewRecycler.Core.DataSource)
local DataSourceChangeType = require(ViewRecycler.Core.Enums.DataSourceChangeType)
local Diagnostics = require(ViewRecycler.Core.Diagnostics)
local _Layout = require(ViewRecycler.Core.Layout)
local PaginationEdges = require(ViewRecycler.Core.ViewportBehavior.PaginationEdges)
local _PinnedItems = require(ViewRecycler.Core.PinnedItems)
local PlacementTypes = require(ViewRecycler.Core.Placement.PlacementTypes)
local _ReachedThreshold = require(ViewRecycler.Core.ViewportBehavior.ReachedThreshold)
local ScrollAlignment = require(ViewRecycler.Core.Enums.ScrollAlignment)

local ScrollMotion = require(ViewRecycler.Core.Virtualizer.ScrollMotion)
local ScrollObservationKind = require(ViewRecycler.Core.Enums.ScrollObservationKind)
local _Types = require(ViewRecycler.Core.Types)
local DataPrefetchController = require(ViewRecycler.Core.Virtualizer.DataPrefetchController)
local ListRows = require(ViewRecycler.Core.Virtualizer.ListRows)
local createPinnedItemPlanner = require(ViewRecycler.Core.PinnedItems.createPinnedItemPlanner)
local _RecyclingScope = require(ViewRecycler.Core.Recycling.RecyclingScope)
local ScrollAnchor = require(ViewRecycler.Core.Virtualizer.ScrollAnchor)

local ScrollPolicy = require(ViewRecycler.Core.ViewportBehavior.ScrollPolicy)
local SlotBinder = require(ViewRecycler.Core.Recycling.SlotBinder)
local Viewport = require(ViewRecycler.Core.Virtualizer.Viewport)

local var1 = table.freeze({})

local plannerItem = nil
local policyConfig = nil
local keyOnly = nil
local anchorConfig, paginationConfig

if FFlagViewRecyclerReact084 then
    anchorConfig = function(arg1)
        return {
            preserveScrollPositionOnChange = arg1.preserveScrollPositionOnChange ~= false,
            initialScrollAlignment = arg1.initialScrollAlignment,
            autoScrollOnChange = arg1.autoScrollOnChange,
            autoScrollThreshold = arg1.autoScrollThreshold
        }
    end

    paginationConfig = function(arg1)
        return {
            startReachedThreshold = arg1.startReachedThreshold,
            startReachedEnabled = arg1.startReachedEnabled == true,
            endReachedEnabled = arg1.endReachedEnabled == true
        }
    end

    plannerItem = function(arg1): {estimatedLength: any, key: any}?
        return if arg1 == nil then nil else {
            key = arg1.key,
            estimatedLength = arg1.estimatedLength
        }
    end
else
    anchorConfig = nil
    paginationConfig = nil
    policyConfig = nil
    if FFlagViewRecyclerReact08 then
        anchorConfig = function(arg1)
            return {
                preserveScrollPositionOnChange = arg1.preserveScrollPositionOnChange ~= false,
                initialScrollAlignment = arg1.initialScrollAlignment,
                autoScrollOnChange = arg1.autoScrollOnChange,
                autoScrollThreshold = arg1.autoScrollThreshold
            }
        end

        paginationConfig = function(arg1)
            return {
                startReachedThreshold = arg1.startReachedThreshold,
                startReachedEnabled = arg1.startReachedEnabled == true,
                endReachedEnabled = arg1.endReachedEnabled == true
            }
        end
    else
        policyConfig = function(arg1)
            return {
                initialScrollAlignment = arg1.initialScrollAlignment,
                autoScrollOnChange = arg1.autoScrollOnChange,
                autoScrollThreshold = arg1.autoScrollThreshold,
                startReachedThreshold = arg1.startReachedThreshold,
                startReachedEnabled = arg1.startReachedEnabled == true,
                endReachedEnabled = arg1.endReachedEnabled == true
            }
        end
    end

    keyOnly = function(tbl1): {key: any}?
        return if tbl1 == nil then nil else {
            key = tbl1.key
        }
    end
end

local function createVirtualizer(tbl1)
    local dataSource = tbl1.dataSource
    local layout = tbl1.layout
    local isItemStickyHeader = tbl1.isItemStickyHeader
    local pinnedStartItem = tbl1.pinnedStartItem
    local pinnedEndItem = tbl1.pinnedEndItem

    local bool1 = nil
    if not FFlagViewRecyclerReact084 then
        bool1 = nil
        if not FFlagViewRecyclerReact08 then
            bool1 = tbl1.preserveScrollPositionOnChange ~= false
        end
    end
    local dataPrefetch = tbl1.dataPrefetch
    local bool2 = true

    if isItemStickyHeader == nil then
        bool2 = true

        if pinnedStartItem == nil then
            bool2 = pinnedEndItem ~= nil
        end
    end

    local viewport = Viewport({
        layout = layout,
        overscan = tbl1.overscan,
        contentAlignment = tbl1.contentAlignment,
        endThreshold = tbl1.endThreshold
    })
    local bool3, isLaidOut

    if FFlagViewRecyclerReact084 then
        bool3 = false

        isLaidOut = function(): boolean
            local bool4 = bool3
            return bool4 and viewport.getLength() > 0 and (dataSource.getItemCount() == 0 or viewport.getContentLength() > 0)
        end
    else
        bool3 = nil
        isLaidOut = nil
        if FFlagViewRecyclerReact08 then
            bool3 = false

            isLaidOut = function(): boolean
                local bool4 = bool3
                return bool4 and viewport.getLength() > 0 and (dataSource.getItemCount() == 0 or viewport.getContentLength() > 0)
            end
        end
    end

    local pinnedItemPlanner = createPinnedItemPlanner(dataSource, {
        isItemStickyKey = isItemStickyHeader,
        pinnedStartItem = (if FFlagViewRecyclerReact084 then plannerItem else keyOnly)(pinnedStartItem),
        pinnedEndItem = (if FFlagViewRecyclerReact084 then plannerItem else keyOnly)(pinnedEndItem)
    })

    if FFlagViewRecyclerReact084 then
        local contentInsets = pinnedItemPlanner.getContentInsets()
        viewport.setInsets(contentInsets.start, contentInsets.finish)
    end
    local var3 = DataPrefetchController(dataPrefetch)
    local var4 = ScrollAnchor({
        viewport = viewport,
        getItemSequence = function()
            return dataSource
        end,
        isLaidOut = if FFlagViewRecyclerReact084 then isLaidOut elseif FFlagViewRecyclerReact08 then isLaidOut else nil,
        config = if FFlagViewRecyclerReact084 then anchorConfig(tbl1) elseif FFlagViewRecyclerReact08 then anchorConfig(tbl1) else nil,
        shouldPreserveUserPosition = if FFlagViewRecyclerReact084 then nil else not FFlagViewRecyclerReact08 and function()
            return bool1
        end or nil
    })

    local var5 = nil
    local var6, prepareDesiredAssignment

    if FFlagViewRecyclerReact084 then
        var6 = PaginationEdges.create(paginationConfig(tbl1))
        prepareDesiredAssignment = tbl1.prepareDesiredAssignment
    else
        var6 = nil
        prepareDesiredAssignment = nil
        var5 = nil
        if FFlagViewRecyclerReact08 then
            var6 = PaginationEdges.create(paginationConfig(tbl1))
            prepareDesiredAssignment = tbl1.prepareDesiredAssignment
        else
            var5 = ScrollPolicy(policyConfig(tbl1))
        end
    end
    local var7 = ListRows

    local tbl2 = {
        slotBinder = SlotBinder({
            recyclingScope = tbl1.recyclingScope,
            name = if FFlagViewRecyclerReact084 then "Virtualizer" elseif FFlagViewRecyclerReact08 then "Virtualizer" else nil,
            prepareDesiredAssignment = if FFlagViewRecyclerReact084 then prepareDesiredAssignment ~= nil and function(arg1)
                return prepareDesiredAssignment({ key = arg1.key, value = arg1.value })
            end or nil elseif FFlagViewRecyclerReact08 then prepareDesiredAssignment ~= nil and function(arg1)
                return prepareDesiredAssignment({ key = arg1.key, value = arg1.value })
            end or nil else tbl1.prepareDesiredAssignment
        }),
        getItemViewType = tbl1.getItemViewType,
        isReadyOnAssignment = if FFlagViewRecyclerReact084 then tbl1.isReadyOnAssignment else nil,
        getPinnedItem = 0
    }

    function tbl2.getPinnedItem(start)
        return if start == PlacementTypes.PinnedPosition.Start then pinnedStartItem else pinnedEndItem
    end

    local var8 = var7(tbl2)

    if not (FFlagViewRecyclerReact084 or FFlagViewRecyclerReact08) then
        bool3 = false
    end

    local bool4 = true
    local bool5 = false
    local bool6 = false
    local var9 = nil
    local getCurrent = nil

    local var11 = nil
    local var12 = nil
    local findMotionIndex = nil
    local resolveMotionTarget = nil
    local stopMotion = nil
    if FFlagViewRecyclerReact084 then
        var11 = nil
        var12 = nil

        findMotionIndex = function(tbl3)
            local indexHint = tbl3.indexHint
            if indexHint <= dataSource.getItemCount() and dataSource.getItemKey(indexHint) == tbl3.key then
                return indexHint
            end
            for i = 1, dataSource.getItemCount() do
                if dataSource.getItemKey(i) == tbl3.key then
                    tbl3.indexHint = i
                    return i
                end
            end
            return nil
        end

        resolveMotionTarget = function()
            local var13 = var12
            if var13 == nil then
                return nil
            elseif var13.kind == "index" then
                local motionIndex = findMotionIndex(var13)
                if motionIndex == nil then
                    return nil
                end

                return (viewport.offsetForItem(motionIndex, var13.alignment))
            elseif var13.kind == "edge" then
                if var13.edge == ScrollAlignment.Start then
                    return 0
                end

                return (viewport.clamp(viewport.getContentLength() - viewport.getLength()))
            else
                return viewport.clamp(var13.offset)
            end
        end
        stopMotion = function()
            if var11 ~= nil then
                var11 = nil
                var12 = nil
                var4.endMotion()
            end
        end
    end

    local function addDiagnostic(tbl3, arg1) -- Luacid: Inlined by compiler; 6 call sites recovered
        if table.isfrozen(tbl3.diagnostics) then
            tbl3.diagnostics = {}
        end
        table.insert(tbl3.diagnostics, arg1)
    end

    local function applyCorrection(tbl3, arg1)
        if arg1 == nil then
            return
        end
        local scrollOffset = viewport.getScrollOffset()
        viewport.setScrollOffset(scrollOffset + arg1.delta)
        local delta = viewport.getScrollOffset() - scrollOffset
        tbl3.scrollCorrection += delta
        tbl3.scrollPositionChanged = true
        tbl3.scrollPositionFollowsCorrection = true
        if tbl1.diagnostics == nil then
            return
        end

        addDiagnostic(tbl3, { kind = Diagnostics.EventKind.ScrollCorrection, source = arg1.source, delta = delta })
    end

    local function moveScrollPosition(tbl3) -- Luacid: Inlined by compiler; 11 call sites recovered
        tbl3.scrollPositionChanged = true
        tbl3.scrollPositionFollowsCorrection = false
    end

    local applyPolicyTarget = nil
    local moveTo

    if FFlagViewRecyclerReact084 then
        moveTo = function(tbl3, num1: number)
            local scrollOffset = viewport.getScrollOffset()
            local var13 = viewport.scrollTo(num1)
            var4.setViewport(var13)
            if var13 ~= scrollOffset then
                moveScrollPosition(tbl3)
            end
        end
    else
        moveTo = nil
        applyPolicyTarget = nil
        if FFlagViewRecyclerReact08 then
            moveTo = function(tbl3, num1: number)
                local scrollOffset = viewport.getScrollOffset()
                local var13 = viewport.scrollTo(num1)
                var4.setViewport(var13)
                if var13 ~= scrollOffset then
                    moveScrollPosition(tbl3)
                end
            end
        else
            applyPolicyTarget = function(tbl3, num1: number?)
                if num1 == nil or not var4.allowsPolicyOffset() then
                    return
                end
                local scrollOffset = viewport.getScrollOffset()
                if viewport.scrollTo(num1) ~= scrollOffset then
                    moveScrollPosition(tbl3)
                end
            end
        end
    end

    local function readKeys()
        local itemCount = dataSource.getItemCount()
        local var13 = table.create(itemCount)
        for i = 1, itemCount do
            var13[i] = dataSource.getItemKey(i)
        end
        return var13
    end

    local var13 = nil
    var13 = FFlagViewRecyclerReact084 and function() -- name: resolveItemEstimates
        local resolveItemEstimates2 = layout.resolveItemEstimates
        return not (resolveItemEstimates2 == nil) and resolveItemEstimates2(dataSource.getItem)
    end or var13

    local function resetLayout(keys) -- Luacid: Inlined by compiler; 3 call sites recovered
        layout.applyDataSourceChange({ type = DataSourceChangeType.Reset, keys = keys })

        if FFlagViewRecyclerReact084 then
            var13()
        end
        viewport.refresh()
    end

    local function unsubscribe() -- Luacid: Inlined by compiler; 4 call sites recovered
        if var9 ~= nil then
            var9()
            var9 = nil
        end
    end

    local tbl3 = {}

    local function beginTransaction()
        local tbl4 = tbl3

        if FFlagViewRecyclerReact084 or FFlagViewRecyclerReact08 then
            tbl4.settlesScroll = true
        else
            tbl4.policyEligible = true
        end

        tbl4.dataChange = nil

        if not (FFlagViewRecyclerReact084 or FFlagViewRecyclerReact08) then
            tbl4.before = nil
        end

        tbl4.replaced = false
        tbl4.viewportChanged = false
        tbl4.scrollMoved = false

        if FFlagViewRecyclerReact084 or FFlagViewRecyclerReact08 then
            tbl4.keptDistanceFromEnd = nil
        end

        tbl4.contentLengthBefore = viewport.getContentLength()
        tbl4.scrollCorrection = 0
        tbl4.scrollPositionChanged = false
        tbl4.scrollPositionFollowsCorrection = false

        if FFlagViewRecyclerReact084 then
            tbl4.animatedScrollTarget = nil
        end
        tbl4.contentLengthChanged = false
        tbl4.startReached = false
        tbl4.endReached = false
        tbl4.entered = var1
        tbl4.updated = var1
        tbl4.departed = var1
        tbl4.dataPrefetchRequests = var1
        tbl4.diagnostics = var1
        return tbl4
    end

    local function checkEdges(tbl4, bool7: boolean)
        local var14, var15

        if FFlagViewRecyclerReact084 or FFlagViewRecyclerReact08 then
            if not (var6.isEnabled() and isLaidOut()) then
                return
            end
            var14, var15 = var6.check(viewport.scrollState(), bool7)
        else
            var14, var15 = var5.checkEdges(viewport.scrollState(), dataSource.getItemCount(), bool7)
        end

        tbl4.startReached = tbl4.startReached or var14
        tbl4.endReached = tbl4.endReached or var15
    end

    local policyContext = nil
    local settlePolicy = nil
    local moveSettled, settleScroll

    if FFlagViewRecyclerReact084 then
        moveSettled = function(num1: number)
            moveTo(tbl3, num1)
        end

        settleScroll = function(tbl4)
            tbl4.contentLengthChanged = viewport.getContentLength() ~= tbl4.contentLengthBefore
            var4.settle(tbl4, moveSettled)
            local dataChange = tbl4.dataChange
            checkEdges(tbl4, not (dataChange == nil) and PaginationEdges.hasStructuralChange(dataChange))
        end
    else
        moveSettled = nil
        settleScroll = nil
        policyContext = nil
        settlePolicy = nil
        if FFlagViewRecyclerReact08 then
            moveSettled = function(num1: number)
                moveTo(tbl3, num1)
            end

            settleScroll = function(tbl4)
                tbl4.contentLengthChanged = viewport.getContentLength() ~= tbl4.contentLengthBefore
                var4.settle(tbl4, moveSettled)
                local dataChange = tbl4.dataChange
                checkEdges(tbl4, not (dataChange == nil) and PaginationEdges.hasStructuralChange(dataChange))
            end
        else
            policyContext = function()
                return {
                    itemCount = dataSource.getItemCount(),
                    scrollState = viewport.scrollState(),
                    getScrollOffsetForItem = viewport.offsetForItem
                }
            end

            settlePolicy = function(tbl4)
                if viewport.getContentLength() ~= tbl4.contentLengthBefore then
                    tbl4.contentLengthChanged = true
                    applyPolicyTarget(tbl4, var5.contentLengthChanged(viewport.scrollState()))
                end
                local dataChange = tbl4.dataChange
                if dataChange ~= nil then
                    applyPolicyTarget(tbl4, var5.dataChanged(policyContext(), tbl4.before))
                    checkEdges(tbl4, PaginationEdges.hasStructuralChange(dataChange))
                    return
                end
                if tbl4.replaced then
                    applyPolicyTarget(tbl4, var5.dataReplaced(policyContext()))
                    var5.observe(viewport.scrollState())
                end
                if tbl4.viewportChanged then
                    applyPolicyTarget(tbl4, var5.viewportChanged(policyContext()))
                    var5.observe(viewport.scrollState())
                elseif tbl4.scrollMoved then
                    var5.observe(viewport.scrollState())
                end
                if var5.reachesEdges() then
                    checkEdges(tbl4, false)
                end
            end
        end
    end

    local tbl4 = ({})
    local tbl5 = {}

    local function settle(tbl6)
        viewport.refresh()

        if if FFlagViewRecyclerReact084 then tbl6.settlesScroll elseif FFlagViewRecyclerReact08 then tbl6.settlesScroll else tbl6.policyEligible then
            if FFlagViewRecyclerReact084 or FFlagViewRecyclerReact08 then
                settleScroll(tbl6)
            else
                settlePolicy(tbl6)
            end
        end

        local var14, var15 = viewport.updateRanges()
        if tbl1.diagnostics ~= nil then
            if var14 then
                local visibleRange = viewport.getVisibleRange()
                addDiagnostic(tbl6, {
                    kind = Diagnostics.EventKind.RangeChanged,
                    rangeKind = Diagnostics.RangeKind.Visible,
                    firstIndex = visibleRange.firstIndex,
                    lastIndex = visibleRange.lastIndex
                })
            end

            if var15 then
                local mountedRange = viewport.getMountedRange()
                addDiagnostic(tbl6, {
                    kind = Diagnostics.EventKind.RangeChanged,
                    rangeKind = Diagnostics.RangeKind.Rendered,
                    firstIndex = mountedRange.firstIndex,
                    lastIndex = mountedRange.lastIndex
                })
            end
        end

        if bool5 then
            return
        end
        if bool4 then
            local scrollOffset = viewport.getScrollOffset()
            local contentStartOffset = viewport.getContentStartOffset()
            tbl4.dataSource = dataSource
            tbl4.layout = layout
            tbl4.mountedRange = viewport.getMountedRange()

            if FFlagViewRecyclerReact084 then
                tbl4.visibleRange = viewport.getVisibleRange()
            end
            tbl4.scrollOffset = scrollOffset
            tbl4.contentStartOffset = contentStartOffset
            local tbl7 = tbl4
            tbl7.plan = if bool2 then pinnedItemPlanner.update({
                itemSequence = dataSource,
                layout = layout,
                scrollOffset = scrollOffset,
                viewportLength = viewport.getLength(),
                contentStartOffset = contentStartOffset
            }) else nil

            local var16, var17 = var8.apply(tbl4)
            if var16 ~= nil then
                tbl6.entered = var16.entered
                tbl6.updated = var16.updated
                tbl6.departed = var16.departed
            end
            if var17 ~= nil then
                addDiagnostic(tbl6, var17)
            end
        elseif var8.isApplied() then
            tbl6.departed = var8.release()
        end
        tbl5.itemSequence = dataSource
        tbl5.mountedRange = viewport.getMountedRange()
        tbl5.options = dataPrefetch
        tbl6.dataPrefetchRequests = var3.reconcile(tbl5)
    end

    local function frozen(arg1) -- Luacid: Inlined by compiler; 4 call sites recovered
        if table.isfrozen(arg1) then
            return arg1
        end

        return (table.freeze(arg1))
    end

    local function makeRecord(tbl6)
        local var14 = getCurrent
        return (table.freeze({
            mountedViews = var8.getMountedViews(),
            entered = frozen(tbl6.entered),
            updated = frozen(tbl6.updated),
            departed = frozen(tbl6.departed),
            visibleRange = viewport.getVisibleRange(),
            mountedRange = viewport.getMountedRange(),
            scrollState = viewport.scrollState(if var14 == nil then nil else var14.scrollState),
            contentStartOffset = viewport.getContentStartOffset(),
            contentLength = viewport.getContentLength(),
            requiresItemMeasurement = layout.requiresItemMeasurement(),
            scrollCorrection = tbl6.scrollCorrection,
            scrollPositionChanged = tbl6.scrollPositionChanged,
            scrollPositionFollowsCorrection = tbl6.scrollPositionFollowsCorrection,
            scrollAnchor = var4.getAnchoredItem(),
            animatedScrollTarget = if FFlagViewRecyclerReact084 then tbl6.animatedScrollTarget else nil,
            contentLengthChanged = tbl6.contentLengthChanged,
            startReached = tbl6.startReached,
            endReached = tbl6.endReached,
            dataPrefetchRequests = tbl6.dataPrefetchRequests,
            diagnostics = frozen(tbl6.diagnostics)
        }))
    end

    local mutateAndSettle, transact

    if FFlagViewRecyclerReact084 then
        mutateAndSettle = function(callback: (...any) -> (...any), tbl6, arg1, arg2, arg3)
            callback(tbl6, arg1, arg2, arg3)
            if var11 ~= nil and resolveMotionTarget() == nil then
                stopMotion()
            end
            settle(tbl6)
            if var11 ~= nil then
                tbl6.animatedScrollTarget = resolveMotionTarget()
            end
        end

        transact = function(func1: (...any) -> (...any), arg1, arg2, arg3)
            assert(not bool6, "Virtualizer: cannot mutate during a transaction")
            assert(not bool5, "Virtualizer: cannot dispatch after destruction")
            bool6 = true
            local tbl6 = beginTransaction()
            local success, result = pcall(mutateAndSettle, func1, tbl6, arg1, arg2, arg3)
            bool6 = false
            if not success then
                error(result, 0)
            end
            local var14 = getCurrent
            local record = makeRecord(tbl6)
            getCurrent = record
            if tbl1.diagnostics ~= nil then
                for _, diagnostic in record.diagnostics do
                    tbl1.diagnostics(diagnostic)
                end
            end
            if tbl1.onTransaction ~= nil then
                tbl1.onTransaction(var14, record)
            end
            return record
        end
    else
        mutateAndSettle = function(callback: (...any) -> (...any), tbl6, arg1, arg2)
            callback(tbl6, arg1, arg2)
            settle(tbl6)
        end

        transact = function(func1: (...any) -> (...any), arg1, arg2)
            assert(not bool6, "Virtualizer: cannot mutate during a transaction")
            assert(not bool5, "Virtualizer: cannot dispatch after destruction")
            bool6 = true
            local tbl6 = beginTransaction()
            local success, result = pcall(mutateAndSettle, func1, tbl6, arg1, arg2)
            bool6 = false
            if not success then
                error(result, 0)
            end
            local var14 = getCurrent
            local record = makeRecord(tbl6)
            getCurrent = record
            if tbl1.diagnostics ~= nil then
                for _, diagnostic in record.diagnostics do
                    tbl1.diagnostics(diagnostic)
                end
            end
            if tbl1.onTransaction ~= nil then
                tbl1.onTransaction(var14, record)
            end
            return record
        end
    end

    local function applyDataChange(tbl6, arg1)
        if not (FFlagViewRecyclerReact084 or FFlagViewRecyclerReact08) then
            tbl6.before = viewport.scrollState()
        end

        tbl6.dataChange = arg1
        var8.noteDataChange(arg1)
        local bool7 = false
        applyCorrection(
            tbl6,
            var4.preserve({
                source = Diagnostics.ScrollCorrectionSource.Data,
                dataSourceChange = arg1
            }, function()
                for _, value in arg1.changes do
                    bool7 = layout.applyDataSourceChange(value) or bool7
                end

                if FFlagViewRecyclerReact084 then
                    bool7 = var13() or bool7
                end
                pinnedItemPlanner.applyDataSourceChange(arg1)
                viewport.refresh()
            end)
        )
        if bool7 then
            var8.invalidateLayout()
        end
    end

    local function func1(arg1)
        transact(applyDataChange, arg1)
    end

    local function func2()
        if var9 == nil and bool3 and not bool5 then
            var9 = dataSource.subscribe(func1)
        end
    end

    local function replaceDataSource(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
        if arg1 ~= dataSource then
            unsubscribe()
            dataSource = arg1
        end
        pinnedItemPlanner.setItemSequence(dataSource)
    end

    local function replaceLayout(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
        layout = arg1
        viewport.setLayout(arg1)
        local crossAxisLength = viewport.getCrossAxisLength()
        if crossAxisLength > 0 then
            arg1.setViewportCrossAxisLength(crossAxisLength)
        end
        var8.invalidateLayout()
    end

    local function resetData()
        if FFlagViewRecyclerReact084 or FFlagViewRecyclerReact08 then
            var4.dataSourceReplaced()
        else
            var4.reset()
        end

        resetLayout((readKeys()))
        var8.invalidateKeys()
        var8.invalidatePayloads()
        func2()
    end

    local function submitMeasurements(tbl6, tbl7)
        local var14, var15 = var8.validate(tbl7)
        if #var14 > 0 and tbl1.diagnostics ~= nil then
            addDiagnostic(
                tbl6,
                {
                    kind = Diagnostics.EventKind.MeasurementsProcessingStarted,
                    submitted = #var14,
                    boundaryDropped = var15
                }
            )
        end

        local num1 = 0
        local bool7 = false
        local var16 = nil
        local tbl8 = {
            source = Diagnostics.ScrollCorrectionSource.Measurement,
            preserveStartAnchor = true,
            startInsetDelta = 0
        }

        local start = pinnedItemPlanner.getContentInsets().start
        applyCorrection(tbl6, var4.preserve(tbl8, function()
            for _, value in var14 do
                local index = value.index
                if index ~= nil then
                    local var17 = layout.updateItemMeasurement({ itemIndex = index, itemKey = value.key, length = value.length })

                    if var17.accepted then
                        num1 += 1
                    else
                        var15 += 1
                    end
                    bool7 = bool7 or var17.geometryChanged
                elseif value.pinnedPosition ~= nil then
                    local var17 = nil
                    local var18

                    if FFlagViewRecyclerReact084 then
                        var18, var17 = pinnedItemPlanner.updatePinnedMeasurement(value.pinnedPosition, value.key, value.pinnedRevision, value.length)
                    else
                        var18 = pinnedItemPlanner.updatePinnedMeasurement(value.pinnedPosition, value.key, value.pinnedRevision, value.length)
                    end

                    if not FFlagViewRecyclerReact084 then
                        var17 = var18 == nil
                    end

                    if var17 then
                        if FFlagViewRecyclerReact084 then
                            num1 += 1
                        else
                            var15 += 1
                        end
                    elseif FFlagViewRecyclerReact084 then
                        var15 += 1
                    else
                        num1 += 1
                        var16 = var18
                    end

                    if FFlagViewRecyclerReact084 and var18 ~= nil then
                        var16 = var18
                    end
                else
                    var15 += 1
                end
            end
            if var16 ~= nil then
                tbl8.startInsetDelta = var16.start - start
                viewport.setInsets(var16.start, var16.finish)
                bool7 = true
            end
            viewport.refresh()
        end))

        if tbl1.diagnostics ~= nil and #var14 > 0 then
            addDiagnostic(tbl6, { kind = Diagnostics.EventKind.MeasurementsProcessed, accepted = num1, dropped = var15 })
        end

        if bool7 then
            var8.invalidateLayout()
        end
    end

    local setPolicy = FFlagViewRecyclerReact084 and function(tbl6, tbl7) -- name: setPolicy
        DataPrefetch.resolve(tbl7.dataPrefetch)
        local pinnedItems = tbl7.pinnedItems
        viewport.setOverscan(tbl7.overscan)
        viewport.setContentAlignment(tbl7.contentAlignment)
        viewport.setEndThreshold(tbl7.endThreshold)
        dataPrefetch = tbl7.dataPrefetch
        var4.configure(anchorConfig(tbl7))
        var6.configure(paginationConfig(tbl7))
        local contentInsets = pinnedItemPlanner.getContentInsets()

        pinnedItemPlanner.setOptions({
            isItemStickyKey = pinnedItems.isItemStickyHeader,
            pinnedStartItem = plannerItem(pinnedItems.pinnedStartItem),
            pinnedEndItem = plannerItem(pinnedItems.pinnedEndItem)
        })
        isItemStickyHeader = pinnedItems.isItemStickyHeader
        pinnedStartItem = pinnedItems.pinnedStartItem
        pinnedEndItem = pinnedItems.pinnedEndItem
        bool2 = isItemStickyHeader ~= nil or pinnedStartItem ~= nil or pinnedEndItem ~= nil
        local contentInsets2 = pinnedItemPlanner.getContentInsets()
        if contentInsets2.start == contentInsets.start and contentInsets2.finish == contentInsets.finish then
            return
        end

        applyCorrection(
            tbl6,
            var4.preserve({
                source = Diagnostics.ScrollCorrectionSource.Policy,
                preserveStartAnchor = true,
                startInsetDelta = contentInsets2.start - contentInsets.start
            }, function()
                viewport.setInsets(contentInsets2.start, contentInsets2.finish)
            end)
        )
    end or function(tbl6) -- name: setPolicy
        DataPrefetch.resolve(tbl6.dataPrefetch)
        local pinnedItems = tbl6.pinnedItems
        viewport.setOverscan(tbl6.overscan)
        viewport.setContentAlignment(tbl6.contentAlignment)
        viewport.setEndThreshold(tbl6.endThreshold)

        if not FFlagViewRecyclerReact08 then
            bool1 = tbl6.preserveScrollPositionOnChange ~= false
        end
        dataPrefetch = tbl6.dataPrefetch
        isItemStickyHeader = pinnedItems.isItemStickyHeader
        pinnedStartItem = pinnedItems.pinnedStartItem
        pinnedEndItem = pinnedItems.pinnedEndItem

        if pinnedItemPlanner.setOptions({
            isItemStickyKey = isItemStickyHeader,
            pinnedStartItem = keyOnly(pinnedStartItem),
            pinnedEndItem = keyOnly(pinnedEndItem)
        }) then
            local contentInsets = pinnedItemPlanner.getContentInsets()
            viewport.setInsets(contentInsets.start, contentInsets.finish)
        end
        bool2 = isItemStickyHeader ~= nil or pinnedStartItem ~= nil or pinnedEndItem ~= nil

        if FFlagViewRecyclerReact08 then
            var4.configure(anchorConfig(tbl6))
            var6.configure(paginationConfig(tbl6))
            return
        end
        var5.configure(policyConfig(tbl6))
    end

    local function setActiveMutation(tbl6, bool7: boolean)
        if FFlagViewRecyclerReact084 or FFlagViewRecyclerReact08 then
            tbl6.settlesScroll = false
        else
            tbl6.policyEligible = false
        end

        if bool7 and not bool4 then
            var8.invalidatePayloads()
        end
        bool4 = bool7
    end

    local var14 = nil
    if not FFlagViewRecyclerReact084 then
        var14 = nil
        var14 = not FFlagViewRecyclerReact08 and function(_, num1: number) -- name: setScrollOffsetMutation
            if viewport.setScrollOffset(num1) then
                var4.setViewport(num1)
            end
        end or var14
    end

    local function observeScrollOffsetMutation(tbl6, tbl7)
        if FFlagViewRecyclerReact084 and tbl7.kind == ScrollObservationKind.User then
            stopMotion()
        end

        local var15 = viewport.setScrollOffset(tbl7.offset)
        if tbl7.kind == ScrollObservationKind.Programmatic then
            var4.observeHost(tbl7.offset)
        elseif var15 then
            var4.setViewport(tbl7.offset)
        end
        if tbl7.kind == ScrollObservationKind.User then
            tbl6.scrollMoved = true
        end
    end

    local animate = nil
    local var15, scrollToIndexMutation, scrollToOffsetMutation

    if FFlagViewRecyclerReact084 then
        var15 = function(tbl6, arg1) -- name: finishProgrammaticScroll
            var4.scrolledProgrammatically(arg1)
            moveScrollPosition(tbl6)

            if arg1 == nil then
                tbl6.scrollMoved = true
            end
        end

        animate = function(tbl6, tbl7): boolean
            if tbl6 == nil or tbl6.animated ~= true then
                return false
            end
            ScrollMotion.validate(tbl6, "Virtualizer")
            local var16 = if var11 == nil then 0 else var11.velocity
            stopMotion()
            if not isLaidOut() then
                return false
            end
            var12 = tbl7
            local var17 = resolveMotionTarget()
            local scrollOffset = viewport.getScrollOffset()
            if var17 == nil or ScrollMotion.isAtRest(scrollOffset, var17, var16) then
                var12 = nil
                return false
            end
            var11 = ScrollMotion.start(scrollOffset, var17, viewport.getLength(), var16, ScrollMotion.resolve(tbl6))

            var4.beginMotion()
            return true
        end

        scrollToIndexMutation = function(tbl6, num1: number, alignment, tbl7)
            local itemCount = dataSource.getItemCount()
            if itemCount > 0 then
                local indexHint = math.clamp(num1, 1, itemCount)

                local tbl8 = {
                    kind = "index",
                    key = dataSource.getItemKey(indexHint),
                    indexHint = indexHint,
                    alignment = alignment
                }

                if animate(tbl7, tbl8) then
                    return
                end
            end
            stopMotion()
            moveTo(tbl6, viewport.offsetForItem(num1, alignment))
            var4.setItemTarget(num1, alignment)
            var15(tbl6, nil)
        end

        scrollToOffsetMutation = function(tbl6, offset: number, tbl7)
            if animate(tbl7, { kind = "offset", offset = offset }) then
                return
            end
            stopMotion()
            moveTo(tbl6, offset)
            var15(tbl6, nil)
        end
    else
        var15 = nil
        var15 = FFlagViewRecyclerReact08 and function(tbl6, arg1) -- name: finishProgrammaticScroll
            var4.scrolledProgrammatically(arg1)
            moveScrollPosition(tbl6)

            if arg1 == nil then
                tbl6.scrollMoved = true
            end
        end or var15

        scrollToIndexMutation = function(tbl6, num1: number, arg1)
            if FFlagViewRecyclerReact08 then
                moveTo(tbl6, viewport.offsetForItem(num1, arg1))
            end
            var4.setItemTarget(num1, arg1)

            if FFlagViewRecyclerReact08 then
                var15(tbl6, nil)
                return
            end
            viewport.scrollTo(viewport.offsetForItem(num1, arg1))
            moveScrollPosition(tbl6)
            tbl6.scrollMoved = true
        end

        scrollToOffsetMutation = function(tbl6, num1: number)
            if FFlagViewRecyclerReact08 then
                moveTo(tbl6, num1)
                var15(tbl6, nil)
                return
            end
            var4.setViewport(viewport.scrollTo(num1))
            moveScrollPosition(tbl6)
            tbl6.scrollMoved = true
        end
    end

    local function scrollByMutation(tbl6, num1: number)
        if FFlagViewRecyclerReact084 then
            assert(math.abs(num1) < math.huge, "Virtualizer: scroll delta must be finite")
            stopMotion()
            moveTo(tbl6, viewport.getScrollOffset() + num1)
            var15(tbl6, nil)
        elseif FFlagViewRecyclerReact08 then
            assert(math.abs(num1) < math.huge, "Virtualizer: scroll delta must be finite")
            moveTo(tbl6, viewport.getScrollOffset() + num1)
            var15(tbl6, nil)
        else
            var4.setViewport(viewport.scrollBy(num1))
            moveScrollPosition(tbl6)
            tbl6.scrollMoved = true
        end
    end

    local landMotion = nil
    local stepAnimatedScrollMutation = nil
    local scrollToEdgeMutation

    if FFlagViewRecyclerReact084 then
        scrollToEdgeMutation = function(tbl6, edge, tbl7)
            if animate(tbl7, { kind = "edge", edge = edge }) then
                return
            end
            stopMotion()
            moveTo(tbl6, if edge == ScrollAlignment.Start then 0 else viewport.getContentLength() - viewport.getLength())

            var15(tbl6, edge)
        end

        landMotion = function(tbl6)
            local var16 = var12
            stopMotion()
            if var16.kind == "index" then
                local motionIndex = findMotionIndex(var16)
                if motionIndex ~= nil then
                    scrollToIndexMutation(tbl6, motionIndex, var16.alignment, nil)
                end
            else
                if var16.kind == "edge" then
                    scrollToEdgeMutation(tbl6, var16.edge, nil)
                    return
                end
                scrollToOffsetMutation(tbl6, var16.offset, nil)
            end
        end

        stepAnimatedScrollMutation = function(tbl6, num1: number)
            local var16 = var11
            local var17 = resolveMotionTarget()
            if var17 == nil then
                stopMotion()
                return
            end

            if not isLaidOut() then
                landMotion(tbl6)
                return
            end

            local var18, var19 = ScrollMotion.step(var16, viewport.getScrollOffset(), var17, viewport.getLength(), num1)
            if var19 then
                landMotion(tbl6)
                return
            end
            moveTo(tbl6, var18)
        end
    else
        scrollToEdgeMutation = function(tbl6, start)
            if FFlagViewRecyclerReact08 then
                moveTo(tbl6, if start == ScrollAlignment.Start then 0 else viewport.getContentLength() - viewport.getLength())

                var15(tbl6, start)
                return
            end
            var4.setViewport(
                viewport.scrollTo(AutoScroll.getTargetOffset(start, viewport.getContentLength(), viewport.getLength()))
            )

            var5.pin(start)
            moveScrollPosition(tbl6)
        end
    end

    local function setViewportSizeMutation(tbl6, num1: number, num2: number)
        local length = viewport.getLength()
        local var16 = viewport.getContentLength() - length - viewport.getScrollOffset()
        if viewport.setSize(num1, num2) then
            if layout.setViewportCrossAxisLength(num2) then
                var8.invalidateLayout()
            end

            if (if FFlagViewRecyclerReact084 then length > 0 elseif FFlagViewRecyclerReact08 then length > 0 else length > 0 and num1 ~= length)
                and (if FFlagViewRecyclerReact084 then num1 ~= length elseif FFlagViewRecyclerReact08 then num1 ~= length else viewport.getContentAlignment() == ScrollAlignment.End)
                and (if FFlagViewRecyclerReact084 then viewport.getContentAlignment() == ScrollAlignment.End elseif FFlagViewRecyclerReact08 then viewport.getContentAlignment() == ScrollAlignment.End else var4.allowsPolicyOffset())
            then
                if FFlagViewRecyclerReact084 or FFlagViewRecyclerReact08 then
                    tbl6.keptDistanceFromEnd = math.max(0, var16)
                else
                    viewport.refresh()
                    local scrollOffset = viewport.getScrollOffset()
                    local var17 = viewport.scrollTo(viewport.getContentLength() - num1 - math.max(0, var16))

                    if var17 ~= scrollOffset then
                        var4.setViewport(var17)
                        moveScrollPosition(tbl6)
                    end
                end
            end
        end

        tbl6.viewportChanged = true
    end

    getCurrent = makeRecord((beginTransaction()))

    return {
        activate = function()
            return transact(function(arg1)
                if not bool3 then
                    bool3 = true
                    local keys = readKeys()
                    resetLayout(keys)
                    pinnedItemPlanner.applyDataSourceChange(
                        {
                            changes = {{
                                type = DataSourceChangeType.Reset,
                                keys = keys
                            }},
                            previousItemCount = #keys,
                            itemCount = #keys
                        }
                    )
                    var8.invalidateKeys()
                    func2()
                end
                arg1.viewportChanged = true
            end)
        end,
        setActive = function(arg1)
            return transact(setActiveMutation, arg1)
        end,
        observeScrollOffset = function(arg1)
            return transact(observeScrollOffsetMutation, arg1)
        end,
        scrollToIndex = FFlagViewRecyclerReact084 and function(arg1, arg2, arg3)
            return transact(scrollToIndexMutation, arg1, arg2, arg3)
        end or function(arg1, arg2)
            return transact(scrollToIndexMutation, arg1, arg2)
        end,
        scrollToOffset = FFlagViewRecyclerReact084 and function(arg1, arg2)
            return transact(scrollToOffsetMutation, arg1, arg2)
        end or function(arg1)
            return transact(scrollToOffsetMutation, arg1)
        end,
        scrollToStart = FFlagViewRecyclerReact084 and function(arg1)
            return transact(scrollToEdgeMutation, ScrollAlignment.Start, arg1)
        end or function()
            return transact(scrollToEdgeMutation, (if FFlagViewRecyclerReact08 then ScrollAlignment else AutoScrollTarget).Start)
        end,
        scrollToEnd = FFlagViewRecyclerReact084 and function(arg1)
            return transact(scrollToEdgeMutation, ScrollAlignment.End, arg1)
        end or function()
            return transact(scrollToEdgeMutation, (if FFlagViewRecyclerReact08 then ScrollAlignment else AutoScrollTarget).End)
        end,
        scrollBy = function(arg1)
            return transact(scrollByMutation, arg1)
        end,
        stepAnimatedScroll = FFlagViewRecyclerReact084 and function(arg1)
            if var11 == nil then
                return getCurrent
            end
            return transact(stepAnimatedScrollMutation, arg1)
        end or nil,
        stopAnimatedScroll = FFlagViewRecyclerReact084 and function()
            if var11 == nil then
                return getCurrent
            end
            return transact(function()
                stopMotion()
            end)
        end or nil,
        restoreScrollAnchorSnapshot = function(arg1)
            return transact(function(arg2)
                if FFlagViewRecyclerReact084 then
                    stopMotion()
                    moveTo(arg2, var4.snapshotOffset(arg1))
                    var4.restore(arg1, viewport.getScrollOffset())
                    var15(arg2, nil)
                elseif FFlagViewRecyclerReact08 then
                    moveTo(arg2, var4.snapshotOffset(arg1))
                    var4.restore(arg1, viewport.getScrollOffset())
                    var15(arg2, nil)
                else
                    var4.restore(arg1, viewport.scrollTo(var4.snapshotOffset(arg1)))
                    moveScrollPosition(arg2)
                    arg2.scrollMoved = true
                end
            end)
        end,
        setViewportSize = function(arg1, arg2)
            return transact(setViewportSizeMutation, arg1, arg2)
        end,
        setPolicy = function(arg1)
            if FFlagViewRecyclerReact084 then
                return transact(setPolicy, arg1)
            end
            return transact(function()
                setPolicy(arg1)
            end)
        end,
        setDataSource = function(arg1)
            return transact(function(arg2)
                if FFlagViewRecyclerReact084 then
                    stopMotion()
                end
                replaceDataSource(arg1)
                resetData()
                arg2.replaced = true
            end)
        end,
        setLayout = function(arg1)
            return transact(function()
                if FFlagViewRecyclerReact084 then
                    stopMotion()
                end
                replaceLayout(arg1)
                var4.reset()
                resetLayout((readKeys()))
            end)
        end,
        setDataSourceAndLayout = function(arg1, arg2)
            return transact(function(arg3)
                if FFlagViewRecyclerReact084 then
                    stopMotion()
                end
                replaceDataSource(arg1)
                replaceLayout(arg2)
                resetData()
                arg3.replaced = true
            end)
        end,
        refresh = function()
            return transact(function()
                var8.invalidateKeys()
                var8.invalidatePayloads()
            end)
        end,
        submitMeasurements = function(arg1)
            return transact(submitMeasurements, arg1)
        end,
        getCurrent = function()
            return getCurrent
        end,
        getItemLayout = function(arg1)
            return layout.getItemLayout(arg1)
        end,
        getScrollOffsetForItem = function(arg1, arg2)
            return viewport.offsetForItem(arg1, arg2)
        end,
        captureScrollAnchorSnapshot = function()
            local var16 = getCurrent
            local visibleRange = var16.visibleRange
            local scrollOffset = var16.scrollState.scrollOffset
            if not (visibleRange.firstIndex <= visibleRange.lastIndex) then
                return {
                    anchorKey = nil,
                    anchorIndex = nil,
                    offsetWithinItem = 0,
                    fallbackScrollOffset = scrollOffset
                }
            end

            local firstIndex = visibleRange.firstIndex
            return {
                anchorKey = dataSource.getItemKey(firstIndex),
                anchorIndex = firstIndex,
                offsetWithinItem = scrollOffset - var16.contentStartOffset - layout.getItemLayout(firstIndex).startOffset,
                fallbackScrollOffset = scrollOffset
            }
        end,
        destroy = function()
            if bool5 then
                return
            end
            transact(function(arg1)
                if FFlagViewRecyclerReact084 then
                    arg1.settlesScroll = false
                    stopMotion()
                elseif FFlagViewRecyclerReact08 then
                    arg1.settlesScroll = false
                else
                    arg1.policyEligible = false
                end

                unsubscribe()
                arg1.departed = var8.release()
                var8.destroy()
                var3.destroy()
                pinnedItemPlanner.destroy()
                bool5 = true
            end)
        end,
        setScrollOffset = if FFlagViewRecyclerReact084 then nil else not FFlagViewRecyclerReact08 and function(arg1)
            return transact(var14, arg1)
        end or nil
    }
end

return createVirtualizer

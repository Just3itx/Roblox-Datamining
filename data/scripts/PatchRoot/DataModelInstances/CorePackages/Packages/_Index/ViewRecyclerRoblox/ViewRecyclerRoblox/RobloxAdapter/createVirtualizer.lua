-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:41:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FFlagViewRecyclerReact084 = require(script:FindFirstAncestor("ViewRecyclerRoblox").Flags).FFlagViewRecyclerReact084
local FFlagViewRecyclerReact08 = require(script:FindFirstAncestor("ViewRecyclerRoblox").Flags).FFlagViewRecyclerReact08
local ViewRecyclerRoblox = script:FindFirstAncestor("ViewRecyclerRoblox")
local ViewRecycler = require(ViewRecyclerRoblox.Parent.ViewRecycler)

local AttachedViewportOverlay = require(ViewRecyclerRoblox.RobloxAdapter.AttachedViewportOverlay)
local HostPlacement = require(ViewRecyclerRoblox.RobloxAdapter.HostPlacement)
local HostPresentationPhase = require(ViewRecyclerRoblox.RobloxAdapter.HostPresentationPhase)

local ReducedMotion = require(ViewRecyclerRoblox.RobloxAdapter.ReducedMotion)
local ScrollHost = require(ViewRecyclerRoblox.RobloxAdapter.ScrollHost)

local VacantHosts = require(ViewRecyclerRoblox.RobloxAdapter.VacantHosts)
local VirtualizerConfigurationKeys = require(ViewRecyclerRoblox.RobloxAdapter.VirtualizerConfigurationKeys)
local VisibleItemsPresentation = require(ViewRecyclerRoblox.RobloxAdapter.VisibleItemsPresentation)
local _createRecyclingScope = require(ViewRecyclerRoblox.RobloxAdapter.createRecyclingScope)

local Axis = ViewRecycler.Axis

local ReachedThreshold = ViewRecycler.Adapter._Private.ReachedThreshold
local ScrollMotion = ViewRecycler.Adapter._Private.ScrollMotion
local ShallowTable = ViewRecycler.Adapter._Private.ShallowTable

local var1 = nil
if not FFlagViewRecyclerReact084 then
    var1 = nil
    if not FFlagViewRecyclerReact08 then
        var1 = table.freeze({
            "scrollingFrame",
            "viewportOverlay",
            "axis",
            "dataSource",
            "layout",
            "overscan",
            "dataPrefetch",
            "contentAlignment",
            "isItemStickyHeader",
            "pinnedStartItem",
            "pinnedEndItem",
            "preserveScrollPositionOnChange",
            "initialScrollAlignment",
            "autoScrollOnChange",
            "autoScrollThreshold",
            "onStartReached",
            "onEndReached",
            "startReachedThreshold",
            "endReachedThreshold",
            "onViewportChanged",
            "onScrollOffsetChanged",
            "onContentLengthChanged",
            "onVisibleRangeChanged",
            "onMountedRangeChanged",
            "onVisibleItemsPresented",
            "onDataPrefetchRequested"
        })
    end
end

local var2 = table.freeze(
    {
        "axis",
        "onStartReached",
        "onEndReached",
        "onViewportChanged",
        "onScrollOffsetChanged",
        "onContentLengthChanged"
    }
)

local var3 = table.freeze(
    FFlagViewRecyclerReact084
        and {
            "overscan",
            "contentAlignment",
            "initialScrollAlignment",
            "autoScrollOnChange",
            "preserveScrollPositionOnChange",
            "isItemStickyHeader"
        }
        or {
            "overscan",
            "dataPrefetch",
            "contentAlignment",
            "endReachedThreshold",
            "initialScrollAlignment",
            "autoScrollOnChange",
            "autoScrollThreshold",
            "startReachedThreshold",
            "preserveScrollPositionOnChange",
            "isItemStickyHeader"
        }
)

local var4 = nil
local var5 = nil
local coreScrollOptions = nil
if FFlagViewRecyclerReact084 then
    var4 = table.freeze({ "endReachedThreshold", "autoScrollThreshold", "startReachedThreshold" })

    var5 = table.freeze({ "startItems", "endItems" })

    coreScrollOptions = function(arg1, arg2)
        if arg1 == nil or arg1.animated ~= true or ReducedMotion.isEnabled() then
            return nil
        end
        local var6 = arg2 or {}
        return {
            animated = true,
            jumpDistance = arg1.jumpDistance or var6.jumpDistance,
            frequency = arg1.frequency or var6.frequency,
            cruiseSpeed = arg1.cruiseSpeed or var6.cruiseSpeed,
            approachDistance = arg1.approachDistance or var6.approachDistance,
            landingDistance = arg1.landingDistance or var6.landingDistance
        }
    end
end

local function pick(tbl1) -- Luacid: Inlined by compiler; 1 call site recovered
    local result = ({})

    for _, value in if FFlagViewRecyclerReact084 then VirtualizerConfigurationKeys elseif FFlagViewRecyclerReact08 then VirtualizerConfigurationKeys else var1 do
        result[value] = tbl1[value]
    end
    return result
end

local function samePinnedItem(arg1, arg2) -- Luacid: Inlined by compiler; 2 call sites recovered
    return ShallowTable.equal(arg1 or {}, arg2 or {})
end

local var6 = nil
var6 = FFlagViewRecyclerReact084 and function(tbl1, tbl2) -- name: sameThresholds
    for _, value in var4 do
        if not ReachedThreshold.equal(tbl1[value], tbl2[value]) then
            return false
        end
    end
    return true
end or var6

local function samePolicy(tbl1, tbl2)
    local var7 = if FFlagViewRecyclerReact084 then ShallowTable.containsEqual(tbl1, tbl2, var3)
        and var6(tbl1, tbl2)
        and ShallowTable.optionalContainsEqual(tbl1.dataPrefetch, tbl2.dataPrefetch, var5) else ShallowTable.containsEqual(tbl1, tbl2, var3)
    return var7
        and tbl1.onStartReached == nil == (tbl2.onStartReached == nil)
        and tbl1.onEndReached == nil == (tbl2.onEndReached == nil)
        and samePinnedItem(tbl1.pinnedStartItem, tbl2.pinnedStartItem)
        and samePinnedItem(tbl1.pinnedEndItem, tbl2.pinnedEndItem)
end

local function stackedSpacing(tbl1) -- Luacid: Inlined by compiler; 2 call sites recovered
    local stackedSpacing2 = tbl1.layout.stackedSpacing
    if stackedSpacing2 == nil then
        return nil
    end

    return (stackedSpacing2())
end

local function assertPlaceable(layout) -- Luacid: Inlined by compiler; 2 call sites recovered
    assert(
        not layout.requiresItemMeasurement() or layout.stackedSpacing ~= nil,
        "createVirtualizer: a Layout that requires Item measurement must be a Stacked layout"
    )
end

local var7 = nil
var7 = FFlagViewRecyclerReact084 and function(tbl1): boolean -- name: needsOwnedOverlay
    return tbl1.viewportOverlay == nil
        and tbl1.scrollingFrame ~= nil
        and (tbl1.isItemStickyHeader ~= nil or tbl1.pinnedStartItem ~= nil or tbl1.pinnedEndItem ~= nil)
end or var7

if not FFlagViewRecyclerReact084 then
    var7 = nil
    var7 = FFlagViewRecyclerReact08 and function(tbl1): boolean -- name: needsOwnedOverlay
        return tbl1.viewportOverlay == nil
            and tbl1.scrollingFrame ~= nil
            and (tbl1.isItemStickyHeader ~= nil or tbl1.pinnedStartItem ~= nil or tbl1.pinnedEndItem ~= nil)
    end or var7
end

local function corePolicy(tbl1)
    return {
        overscan = tbl1.overscan,
        dataPrefetch = tbl1.dataPrefetch,
        contentAlignment = tbl1.contentAlignment,
        endThreshold = tbl1.endReachedThreshold,
        initialScrollAlignment = tbl1.initialScrollAlignment,
        autoScrollOnChange = tbl1.autoScrollOnChange,
        autoScrollThreshold = tbl1.autoScrollThreshold,
        startReachedThreshold = tbl1.startReachedThreshold,
        startReachedEnabled = tbl1.onStartReached ~= nil,
        endReachedEnabled = tbl1.onEndReached ~= nil,
        pinnedItems = {
            isItemStickyHeader = tbl1.isItemStickyHeader,
            pinnedStartItem = tbl1.pinnedStartItem,
            pinnedEndItem = tbl1.pinnedEndItem
        },
        preserveScrollPositionOnChange = tbl1.preserveScrollPositionOnChange ~= false
    }
end

local function createVirtualizer(arg1)
    assert(arg1.axis == Axis.X or arg1.axis == Axis.Y, "createVirtualizer: invalid axis")
    assertPlaceable(arg1.layout)
    local var8

    if FFlagViewRecyclerReact084 then
        ScrollMotion.validate(arg1.animatedScroll, "createVirtualizer: animatedScroll")
        var8 = VacantHosts.forScope(arg1.recyclingScope)
    else
        var8 = nil
    end

    local getConfiguration = ({})

    for _, value in if FFlagViewRecyclerReact084 then VirtualizerConfigurationKeys elseif FFlagViewRecyclerReact08 then VirtualizerConfigurationKeys else var1 do
        local var9 = arg1[value]
        getConfiguration[value] = var9
    end

    local bool1 = false
    local var9

    if FFlagViewRecyclerReact084 then
        var9 = arg1.active ~= false
    else
        var9 = nil
        if FFlagViewRecyclerReact08 then
            var9 = arg1.active ~= false
        end
    end
    local bool2 = false
    local bool3 = false
    local bool4 = false
    local bool5 = false
    local virtualizer = nil
    local var10 = nil

    local visibleItemsPresentation = VisibleItemsPresentation.new(function()
        return if bool1 then nil else getConfiguration.onVisibleItemsPresented
    end)

    local var11, syncOwnedOverlay, viewportContainer

    if FFlagViewRecyclerReact084 then
        var11 = nil

        syncOwnedOverlay = function(tbl2)
            local var12 = var11
            if not var7(tbl2) then
                var11 = nil
                return var12
            end
            local scrollingFrame = tbl2.scrollingFrame
            if var12 ~= nil and var12.scrollingFrame == scrollingFrame and var12.axis == tbl2.axis then
                return nil
            end
            var11 = {
                scrollingFrame = scrollingFrame,
                axis = tbl2.axis,
                handle = AttachedViewportOverlay.new(scrollingFrame, tbl2.axis)
            }
            return var12
        end
        viewportContainer = function(tbl2)
            local viewportOverlay = tbl2.viewportOverlay
            if viewportOverlay ~= nil then
                return viewportOverlay
            end
            local var12 = var11
            return if var12 == nil then nil else var12.handle.overlay
        end
        syncOwnedOverlay(getConfiguration)
    else
        var11 = nil
        syncOwnedOverlay = nil
        viewportContainer = nil
        if FFlagViewRecyclerReact08 then
            var11 = nil

            syncOwnedOverlay = function(tbl2)
                local var12 = var11
                if not var7(tbl2) then
                    var11 = nil
                    return var12
                end
                local scrollingFrame = tbl2.scrollingFrame
                if var12 ~= nil and var12.scrollingFrame == scrollingFrame and var12.axis == tbl2.axis then
                    return nil
                end
                var11 = {
                    scrollingFrame = scrollingFrame,
                    axis = tbl2.axis,
                    handle = AttachedViewportOverlay.new(scrollingFrame, tbl2.axis)
                }
                return var12
            end
            viewportContainer = function(tbl2)
                local viewportOverlay = tbl2.viewportOverlay
                if viewportOverlay ~= nil then
                    return viewportOverlay
                end
                local var12 = var11
                return if var12 == nil then nil else var12.handle.overlay
            end
            syncOwnedOverlay(getConfiguration)
        end
    end

    local new = HostPlacement.new
    local tbl2 = {
        vacantHosts = 0,
        container = 0,
        viewportContainer = 0,
        axis = 0,
        selfSizing = 0,
        stackedSpacing = 0,
        onItemMeasurements = 0,
        onItemViewPresentationChanged = 0,
        getCanvasOriginOffset = 0
    }

    if not FFlagViewRecyclerReact084 then
        var8 = nil
    end

    tbl2.vacantHosts = var8
    tbl2.container = getConfiguration.scrollingFrame
    tbl2.viewportContainer = if FFlagViewRecyclerReact084 then viewportContainer(getConfiguration) elseif FFlagViewRecyclerReact08 then viewportContainer(getConfiguration) else getConfiguration.viewportOverlay

    tbl2.axis = getConfiguration.axis
    tbl2.selfSizing = getConfiguration.layout.requiresItemMeasurement()
    tbl2.stackedSpacing = stackedSpacing(getConfiguration)
    function tbl2.onItemMeasurements(arg2)
        virtualizer.submitMeasurements(arg2)
    end
    function tbl2.onItemViewPresentationChanged(arg2, arg3)
        local onItemViewPresentationChanged2 = arg1.onItemViewPresentationChanged
        if onItemViewPresentationChanged2 ~= nil then
            onItemViewPresentationChanged2(arg2, arg3)
        end
        visibleItemsPresentation.presentationChanged(arg2, arg3)
    end
    function tbl2.getCanvasOriginOffset()
        if var10 == nil then
            return 0
        end

        return (var10.getCanvasOriginOffset())
    end

    local var12 = new(tbl2)

    local var13 = table.freeze({ apply = var12.apply })

    local var14 = arg1.presentItemView or function(host, state, arg2, arg3)
        local transition = arg1.transition
        if state == nil then
            arg3.apply(host, nil)
            if arg2 and transition ~= nil then
                transition(host, nil)
            end
            return
        end

        local var14 = if arg1.getInstance == nil then host else arg1.getInstance(host)
        assert(typeof(var14) == "Instance" and var14:IsA("GuiObject"), "createVirtualizer: ItemView host must be a GuiObject")

        if arg2 then
            arg3.apply(host, { host = var14, phase = HostPresentationPhase.Hidden, state = state })

            if transition ~= nil then
                transition(host, state.assignment)
            end
        end
        arg3.apply(host, { host = var14, phase = HostPresentationPhase.Presented, state = state })
    end

    local var15 = (setmetatable({}, { __mode = "k" }))

    local function present(itemView, state) -- Luacid: Inlined by compiler; 2 call sites recovered
        local assignment = if state == nil then nil else state.assignment
        local bool6 = var15[itemView] ~= assignment
        if bool6 then
            var15[itemView] = assignment
        end
        var14(itemView, state, bool6, var13)
    end

    local var16 = nil

    local function presentChanges()
        local var17 = var16
        var16 = nil
        visibleItemsPresentation.present(var17, getConfiguration.dataSource.getItemCount(), function()
            var12.setMountedWindow(var17, function()
                for _, value in var17.departed do
                    local bool6 = var15[value] ~= nil
                    if bool6 then
                        var15[value] = nil
                    end
                    var14(value, nil, bool6, var13)
                end

                for _, value in var17.entered do
                    present(value.itemView, value.state)
                end
                for _, value in var17.updated do
                    present(value.itemView, value.state)
                end
            end)
        end)
    end

    local function applyRecord(arg2, arg3)
        var16 = arg3
        var10.applyRecord(arg3, presentChanges)
        if not bool2 then
            return
        end
        if arg2.visibleRange ~= arg3.visibleRange then
            if bool3 then
                bool4 = true
            end
            if getConfiguration.onVisibleRangeChanged ~= nil then
                getConfiguration.onVisibleRangeChanged(arg3.visibleRange)
            end
        end
        if arg2.mountedRange ~= arg3.mountedRange then
            if bool3 then
                bool5 = true
            end
            if getConfiguration.onMountedRangeChanged ~= nil then
                getConfiguration.onMountedRangeChanged(arg3.mountedRange)
            end
        end
        if getConfiguration.onDataPrefetchRequested == nil then
            return
        end

        for _, dataPrefetchRequest in arg3.dataPrefetchRequests do
            getConfiguration.onDataPrefetchRequested(dataPrefetchRequest)
        end
    end

    local tbl3 = corePolicy(getConfiguration)
    virtualizer = ViewRecycler.Adapter.createVirtualizer({
        dataSource = getConfiguration.dataSource,
        layout = getConfiguration.layout,
        recyclingScope = arg1.recyclingScope,
        getItemViewType = arg1.getItemViewType,
        isReadyOnAssignment = if FFlagViewRecyclerReact084 then arg1.isReadyOnAssignment else nil,
        overscan = tbl3.overscan,
        dataPrefetch = tbl3.dataPrefetch,
        contentAlignment = tbl3.contentAlignment,
        endThreshold = tbl3.endThreshold,
        initialScrollAlignment = tbl3.initialScrollAlignment,
        autoScrollOnChange = tbl3.autoScrollOnChange,
        autoScrollThreshold = tbl3.autoScrollThreshold,
        startReachedThreshold = tbl3.startReachedThreshold,
        startReachedEnabled = tbl3.startReachedEnabled,
        endReachedEnabled = tbl3.endReachedEnabled,
        isItemStickyHeader = tbl3.pinnedItems.isItemStickyHeader,
        pinnedStartItem = tbl3.pinnedItems.pinnedStartItem,
        pinnedEndItem = tbl3.pinnedItems.pinnedEndItem,
        preserveScrollPositionOnChange = tbl3.preserveScrollPositionOnChange,
        diagnostics = arg1.diagnostics,
        onTransaction = applyRecord
    })

    local new2 = ScrollHost.new
    local tbl4 = {
        observeScrollOffset = virtualizer.observeScrollOffset,
        setViewportSize = virtualizer.setViewportSize,
        getCurrent = virtualizer.getCurrent,
        stepAnimatedScroll = if FFlagViewRecyclerReact084 then virtualizer.stepAnimatedScroll else nil,
        stopAnimatedScroll = if FFlagViewRecyclerReact084 then virtualizer.stopAnimatedScroll else nil,
        getInstance = 0,
        getConfiguration = 0,
        onCanvasOriginMoved = 0
    }

    function tbl4.getInstance()
        return if bool1 then nil else getConfiguration.scrollingFrame
    end
    function tbl4.getConfiguration()
        return getConfiguration
    end
    tbl4.onCanvasOriginMoved = var12.reposition
    var10 = new2(tbl4)

    local function update(tbl5)
        if bool1 then
            return
        end
        local tbl6 = getConfiguration
        local tbl7 = pick(tbl5)
        assert(tbl7.axis == Axis.X or tbl7.axis == Axis.Y, "createVirtualizer: invalid axis")
        assertPlaceable(tbl7.layout)

        if FFlagViewRecyclerReact084 then
            ScrollMotion.validate(tbl7.animatedScroll, "createVirtualizer: animatedScroll")
        end
        local bool6 = tbl7.dataSource ~= tbl6.dataSource
        local bool7 = tbl7.layout ~= tbl6.layout
        local bool8 = tbl7.scrollingFrame ~= tbl6.scrollingFrame
        local var17, bool9

        if FFlagViewRecyclerReact084 then
            local var18 = viewportContainer(tbl6)
            var17 = syncOwnedOverlay(tbl7)
            bool9 = viewportContainer(tbl7) ~= var18
        elseif FFlagViewRecyclerReact08 then
            local var18 = viewportContainer(tbl6)
            var17 = syncOwnedOverlay(tbl7)
            if viewportContainer(tbl7) == var18 then
                bool9 = false
            else
                bool9 = true
            end
        else
            bool9 = nil
            var17 = nil
        end

        local var18 = bool8
            or (if FFlagViewRecyclerReact084 or FFlagViewRecyclerReact08 then bool9 else tbl7.viewportOverlay ~= tbl6.viewportOverlay)
            or tbl7.axis ~= tbl6.axis
            or bool7
            or tbl7.isItemStickyHeader == nil ~= (tbl6.isItemStickyHeader == nil)
        local var19

        if FFlagViewRecyclerReact084 then
            var19 = var9

            if var19 then
                if bool8 or bool9 then
                    var19 = var12.hasDestroyedHost()
                else
                    var19 = bool9
                end
            end
        else
            var19 = nil
        end

        if if FFlagViewRecyclerReact084 then var19 else FFlagViewRecyclerReact08 then
            if FFlagViewRecyclerReact084 then
                virtualizer.setActive(false)
            else
                local var20 = var9

                if var20 then
                    if bool8 or bool9 then
                        bool9 = var12.hasDestroyedHost()
                    end
                else
                    bool9 = var20
                end

                var19 = bool9

                if var19 then
                    virtualizer.setActive(false)
                end
            end
        end
        getConfiguration = tbl7

        if bool6 then
            visibleItemsPresentation.rearm()
        end
        if bool6 or bool7 then
            var12.cancelPendingMeasurements()
            if bool6 and bool7 then
                virtualizer.setDataSourceAndLayout(tbl7.dataSource, tbl7.layout)
            elseif bool6 then
                virtualizer.setDataSource(tbl7.dataSource)
            else
                virtualizer.setLayout(tbl7.layout)
            end
        end
        if var18 then
            var12.setConfiguration({
                container = tbl7.scrollingFrame,
                viewportContainer = if FFlagViewRecyclerReact084 then viewportContainer(tbl7) elseif FFlagViewRecyclerReact08 then viewportContainer(tbl7) else tbl7.viewportOverlay,
                axis = tbl7.axis,
                selfSizing = tbl7.layout.requiresItemMeasurement(),
                stackedSpacing = stackedSpacing(tbl7)
            })
        end
        if (if FFlagViewRecyclerReact084 then var17 ~= nil else FFlagViewRecyclerReact08)
            and (FFlagViewRecyclerReact084 or var17 ~= nil)
        then
            var17.handle.destroy()
        end

        if not samePolicy(tbl6, tbl7) then
            virtualizer.setPolicy((corePolicy(tbl7)))
        end
        if not ShallowTable.containsEqual(tbl6, tbl7, var2) then
            var10.configurationChanged()
        end
        if bool8 then
            var10.scrollingFrameChanged()
        end
        if not (if FFlagViewRecyclerReact084 then var19 else FFlagViewRecyclerReact08) then
            return
        end

        if FFlagViewRecyclerReact084 then
            virtualizer.setActive(true)
            return
        end
        if var19 then
            virtualizer.setActive(true)
        end
    end

    local function updateWith(callback: (...any) -> (...any)) -- Luacid: Inlined by compiler; 8 call sites recovered
        local var17 = table.clone(getConfiguration)
        callback(var17)
        update(var17)
    end

    local var17 = nil

    local function destroy()
        if bool1 then
            return
        end
        bool1 = true
        if var17 ~= nil then
            var17()
            var17 = nil
        end
        virtualizer.destroy()
        var12.destroy()
        local var18

        if FFlagViewRecyclerReact084 then
            var18 = var11
            var11 = nil
        else
            var18 = nil
        end

        if not (if FFlagViewRecyclerReact084 then var18 ~= nil else FFlagViewRecyclerReact08) then
            return
        end

        if FFlagViewRecyclerReact084 then
            var18.handle.destroy()
            return
        end
        local var19 = var11
        var11 = nil
        if var19 ~= nil then
            var19.handle.destroy()
        end
    end

    if arg1.active == false then
        virtualizer.setActive(false)
    end
    var17 = var10.connect()
    bool2 = true
    bool3 = true
    local success, result = pcall(virtualizer.activate)
    bool3 = false
    if not success then
        destroy()
        error(result, 0)
    end
    local current = virtualizer.getCurrent()
    if not bool4 and getConfiguration.onVisibleRangeChanged ~= nil then
        getConfiguration.onVisibleRangeChanged(current.visibleRange)
    end
    if not bool5 and getConfiguration.onMountedRangeChanged ~= nil then
        getConfiguration.onMountedRangeChanged(current.mountedRange)
    end

    return {
        update = update,
        setActive = FFlagViewRecyclerReact084 and function(arg2)
            if not bool1 then
                var9 = arg2
                virtualizer.setActive(arg2)
            end
        end or FFlagViewRecyclerReact08 and function(arg2)
            if not bool1 then
                var9 = arg2
                virtualizer.setActive(arg2)
            end
        end or function(arg2)
            if not bool1 then
                virtualizer.setActive(arg2)
            end
        end,
        scrollToOffset = FFlagViewRecyclerReact084 and function(arg2, arg3)
            local var18 = virtualizer.scrollToOffset(arg2, coreScrollOptions(arg3, getConfiguration.animatedScroll))

            return var18.animatedScrollTarget or var18.scrollState.scrollOffset
        end or function(arg2)
            return virtualizer.scrollToOffset(arg2).scrollState.scrollOffset
        end,
        scrollToStart = FFlagViewRecyclerReact084 and function(arg2)
            virtualizer.scrollToStart(coreScrollOptions(arg2, getConfiguration.animatedScroll))
        end or function()
            virtualizer.scrollToStart()
        end,
        scrollToEnd = FFlagViewRecyclerReact084 and function(arg2)
            virtualizer.scrollToEnd(coreScrollOptions(arg2, getConfiguration.animatedScroll))
        end or function()
            virtualizer.scrollToEnd()
        end,
        scrollBy = function(arg2)
            return virtualizer.scrollBy(arg2).scrollState.scrollOffset
        end,
        scrollToIndex = function(arg2, arg3)
            if not var10.isReady() then
                return
            end

            if FFlagViewRecyclerReact084 then
                virtualizer.scrollToIndex(arg2, arg3 and arg3.alignment, coreScrollOptions(arg3, getConfiguration.animatedScroll))
                return
            end

            virtualizer.scrollToIndex(arg2, arg3 and arg3.alignment)
        end,
        setDataSource = function(dataSource)
            updateWith(function(arg2)
                arg2.dataSource = dataSource
            end)
        end,
        setLayout = function(layout)
            updateWith(function(arg2)
                arg2.layout = layout
            end)
        end,
        setDataSourceAndLayout = function(dataSource, layout)
            updateWith(function(arg2)
                arg2.dataSource = dataSource
                arg2.layout = layout
            end)
        end,
        setOverscan = function(overscan)
            updateWith(function(arg2)
                arg2.overscan = overscan
            end)
        end,
        setDataPrefetch = function(dataPrefetch)
            updateWith(function(arg2)
                arg2.dataPrefetch = dataPrefetch
            end)
        end,
        setContentAlignment = function(contentAlignment)
            updateWith(function(arg2)
                arg2.contentAlignment = contentAlignment
            end)
        end,
        setPinnedItems = function(arg2)
            updateWith(function(arg3)
                arg3.isItemStickyHeader = arg2.isItemStickyHeader
                arg3.pinnedStartItem = arg2.pinnedStartItem
                arg3.pinnedEndItem = arg2.pinnedEndItem
            end)
        end,
        setPreserveScrollPositionOnChange = function(preserveScrollPositionOnChange)
            updateWith(function(arg2)
                arg2.preserveScrollPositionOnChange = preserveScrollPositionOnChange
            end)
        end,
        refreshItemViews = function()
            virtualizer.refresh()
        end,
        isReady = var10.isReady,
        getVisibleRange = function()
            return virtualizer.getCurrent().visibleRange
        end,
        getMountedRange = function()
            return virtualizer.getCurrent().mountedRange
        end,
        getScrollState = function()
            return virtualizer.getCurrent().scrollState
        end,
        captureScrollAnchorSnapshot = function()
            return virtualizer.captureScrollAnchorSnapshot()
        end,
        restoreScrollAnchorSnapshot = function(arg2)
            return virtualizer.restoreScrollAnchorSnapshot(arg2).scrollState.scrollOffset
        end,
        destroy = destroy,
        setScrollOffset = if FFlagViewRecyclerReact084 then nil else not FFlagViewRecyclerReact08 and function(arg2)
            virtualizer.setScrollOffset(arg2)
        end or nil
    }
end

return createVirtualizer

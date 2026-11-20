-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:40:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FFlagViewRecyclerReact084 = require(script:FindFirstAncestor("ViewRecyclerReact").Flags).FFlagViewRecyclerReact084
local FFlagViewRecyclerReact08 = require(script:FindFirstAncestor("ViewRecyclerReact").Flags).FFlagViewRecyclerReact08
local ViewRecyclerReact = script:FindFirstAncestor("ViewRecyclerReact")
local ViewRecyclerRoblox = require(ViewRecyclerReact.Parent.ViewRecyclerRoblox)

local Destination = require(script.Parent.Destination)

local PlacementKind = require(script.Parent.PlacementKind)
local React = require(ViewRecyclerReact.Parent.React)
local RecyclableViewRegistry = require(script.Parent.RecyclableViewRegistry)

local RecyclingScopeContext = require(script.Parent.RecyclingScopeContext)
local RecyclingViewportContext = require(script.Parent.RecyclingViewportContext)
local Signals = require(ViewRecyclerReact.Parent.Signals)
local _VirtualListShell = require(script.Parent.VirtualListShell)

local useCompositionPlacement = require(script.Parent.useCompositionPlacement)
local useRecyclingScope = require(script.Parent.useRecyclingScope)
local virtualizerConfiguration = require(script.Parent.virtualizerConfiguration)
local var1 = if FFlagViewRecyclerReact084 then React.useLayoutEffect else React.useEffect

local function assignRef(arg1, current) -- Luacid: Inlined by compiler; 4 call sites recovered
    if arg1 == nil then
        return
    end

    if type(arg1) == "function" then
        arg1(current)
    else
        arg1.current = current
    end
end

local toCorePinnedItem = nil
local configuration = nil
if not FFlagViewRecyclerReact084 then
    toCorePinnedItem = nil
    configuration = nil
    if not FFlagViewRecyclerReact08 then
        toCorePinnedItem = function(arg1)
            if arg1 == nil then
                return nil
            end

            return {
                key = arg1.key,
                value = arg1.value,
                itemViewType = arg1.itemType
            }
        end

        configuration = function(arg1, arg2)
            return {
                scrollingFrame = arg2.scrollingFrame,
                viewportOverlay = arg2.viewportOverlay,
                axis = arg1.axis,
                dataSource = arg1.dataSource,
                layout = arg1.layout,
                onStartReached = arg1.onStartReached,
                onEndReached = arg1.onEndReached,
                onViewportChanged = arg1.onViewportChanged,
                onScrollOffsetChanged = arg1.onScrollOffsetChanged,
                onContentLengthChanged = arg1.onContentLengthChanged,
                onVisibleRangeChanged = arg1.onVisibleRangeChanged,
                onMountedRangeChanged = arg1.onMountedRangeChanged,
                onVisibleItemsPresented = arg1.onVisibleItemsPresented,
                onDataPrefetchRequested = arg1.onDataPrefetchRequested,
                overscan = arg1.overscan,
                dataPrefetch = arg1.dataPrefetch,
                contentAlignment = arg1.contentAlignment,
                endReachedThreshold = arg1.endReachedThreshold,
                initialScrollAlignment = arg1.initialScrollAlignment,
                autoScrollOnChange = arg1.autoScrollOnChange,
                autoScrollThreshold = arg1.autoScrollThreshold,
                startReachedThreshold = arg1.startReachedThreshold,
                isItemStickyHeader = arg1.isItemStickyHeader,
                pinnedStartItem = toCorePinnedItem(arg1.pinnedStartItem),
                pinnedEndItem = toCorePinnedItem(arg1.pinnedEndItem),
                preserveScrollPositionOnChange = arg1.preserveScrollPositionOnChange
            }
        end
    end
end

local function hostTarget(arg1, arg2) -- Luacid: Inlined by compiler; 3 call sites recovered
    return {
        scrollingFrame = arg1.current,
        viewportOverlay = arg2.current
    }
end

local function assertAttachable(current) -- Luacid: Inlined by compiler; 1 call site recovered
    assert(
        current.scrollingFrameProps == nil,
        "VirtualList: `scrollingFrameProps` cannot style an attached `scrollingFrame`"
    )

    assert(current.tag == nil, "VirtualList: `tag` cannot style an attached `scrollingFrame`")
end

local function useVirtualList(current)
    local var2 = React.useRef(nil)
    local var3 = React.useState(current.scrollingFrame ~= nil)
    assert(
        current.scrollingFrame ~= nil == var3,
        "VirtualList: `scrollingFrame` cannot be added or removed during the list's lifetime"
    )

    if var3 then
        assertAttachable(current)
    end

    local var4 = nil
    local var5

    if FFlagViewRecyclerReact084 then
        var5 = useRecyclingScope("VirtualList")
    else
        var5 = nil
        var4 = nil
        if FFlagViewRecyclerReact08 then
            var5 = useRecyclingScope("VirtualList")
        else
            var4 = React.useContext(RecyclingScopeContext)
            assert(var4 ~= nil, "VirtualListRenderer requires a RecyclingScope")
        end
    end
    local var6 = React.useContext(RecyclingViewportContext)
    local var7 = React.useState(function()
        local active, setActive = Signals.createSignal(false)
        return { active = active, setActive = setActive }
    end)

    local var8 = React.useRef(nil)
    local internalRef = React.useRef(nil)
    local viewportOverlayRef = React.useRef(nil)

    local var11 = nil
    if not FFlagViewRecyclerReact084 then
        var11 = nil
        if not FFlagViewRecyclerReact08 then
            var5 = React.useState(function()
                return var4.root.getScope(var4.listOptions)
            end)
            React.useEffect(function()
                var5.bind({ releases = {}, requests = {}, capacity = var4.listOptions.maxPoolSize, updateCapacity = true })
            end, { var5, var4.listOptions.maxPoolSize })

            var11 = useCompositionPlacement(var4.root, var4.listOptions.maxPoolSize, var4.listOptions.diagnostics)
        end
    end

    local var12 = React.useRef(nil)
    local var13 = React.useState(function()
        local var13 = current
        return {
            synchronize = function(current2)
                var13 = current2
                var2.current = current2
                local current3 = var12.current
                if current3 ~= nil then
                    current3.update(
                        (if FFlagViewRecyclerReact084 then virtualizerConfiguration elseif FFlagViewRecyclerReact08 then virtualizerConfiguration else configuration)(
                            current2,
                            (hostTarget(internalRef, viewportOverlayRef))
                        )
                    )
                end
            end,
            refreshHost = function()
                local current2 = var12.current
                if current2 ~= nil then
                    current2.update(
                        (if FFlagViewRecyclerReact084 then virtualizerConfiguration elseif FFlagViewRecyclerReact08 then virtualizerConfiguration else configuration)(
                            var13,
                            (hostTarget(internalRef, viewportOverlayRef))
                        )
                    )
                end
            end
        }
    end)

    local onScrollingFrameChanged = React.useCallback(function(arg1)
        local current2 = var8.current
        if current2 ~= nil then
            var8.current = nil
            current2()
        end
        if arg1 ~= nil and var6 ~= nil then
            var8.current = var6.register(arg1, var7.setActive)
        end
        var13.refreshHost()
    end, { var7, var13.refreshHost, var6 })

    local var15 = nil
    local var16 = nil
    if not FFlagViewRecyclerReact084 then
        var15 = nil
        var16 = nil
        if not FFlagViewRecyclerReact08 then
            var15 = current.isItemStickyHeader ~= nil or current.pinnedStartItem ~= nil or current.pinnedEndItem ~= nil
            var16 = React.useRef(nil)
        end
    end

    React.useLayoutEffect(function()
        if not var3 then
            return
        end

        local attachedViewportOverlay, current2

        if FFlagViewRecyclerReact084 or FFlagViewRecyclerReact08 then
            attachedViewportOverlay = nil
            current2 = nil
        else
            current2 = var16.current
            if var15 then
                attachedViewportOverlay = ViewRecyclerRoblox.Internal.AttachedViewportOverlay.new(current.scrollingFrame, current.axis)
            else
                attachedViewportOverlay = nil
            end
            var16.current = attachedViewportOverlay
        end

        internalRef.current = current.scrollingFrame

        if not (FFlagViewRecyclerReact084 or FFlagViewRecyclerReact08) then
            local var17 = viewportOverlayRef
            var17.current = if attachedViewportOverlay == nil then nil else attachedViewportOverlay.overlay
        end

        onScrollingFrameChanged(current.scrollingFrame)

        if not FFlagViewRecyclerReact084 and not FFlagViewRecyclerReact08 and current2 ~= nil then
            current2.destroy()
        end
    end, FFlagViewRecyclerReact084 and { var3, current.scrollingFrame, onScrollingFrameChanged }
        or FFlagViewRecyclerReact08 and { var3, current.scrollingFrame, onScrollingFrameChanged }
        or {
            var3,
            current.scrollingFrame,
            current.axis,
            var15,
            onScrollingFrameChanged
        })

    React.useLayoutEffect(function()
        var2.current = current
        local function instrumentation() -- Luacid: Inlined by compiler; 2 call sites recovered
            local current2 = var2.current
            return if current2 == nil then nil else current2._instrumentation
        end

        local var17 = nil
        local listSink = nil
        if not FFlagViewRecyclerReact084 then
            var17 = nil
            listSink = nil
            if not FFlagViewRecyclerReact08 then
                var17 = setmetatable({}, { __mode = "k" })
                listSink = function(arg1, arg2)
                    local var18 = var17[arg1]
                    if var18 == nil then
                        var18 = table.freeze({
                            apply = function(arg3)
                                arg2.apply(arg1, arg3)
                            end
                        })
                        var17[arg1] = var18
                    end
                    return var18
                end
            end
        end

        local var18 = (if FFlagViewRecyclerReact084 then virtualizerConfiguration elseif FFlagViewRecyclerReact08 then virtualizerConfiguration else configuration)(
            current,
            (hostTarget(internalRef, viewportOverlayRef))
        )
        var18.recyclingScope = var5
        function var18.getItemViewType(arg1, arg2)
            local itemType = var2.current.itemType
            assert(
                RecyclableViewRegistry.isRegistered(itemType) or type(itemType) == "function",
                "VirtualList: `itemType` must be a Recyclable view type or selector"
            )

            if not RecyclableViewRegistry.isRegistered(itemType) then
                itemType = itemType(arg1, arg2)
            end

            assert(
                RecyclableViewRegistry.isRegistered(itemType),
                "VirtualList: `itemType` selector must return a Recyclable view type"
            )

            return itemType
        end
        var18.diagnostics = current.diagnostics
        var18.active = if var6 == nil then nil else var7.active(false)

        if FFlagViewRecyclerReact084 then
            function var18.isReadyOnAssignment(arg1)
                return arg1.isReadyOnAssignment()
            end
        end
        function var18.presentItemView(arg1, state, arg2, sink)
            local transition = arg1.transition
            local var19

            if state == nil then
                var19 = nil
            else
                local freeze = table.freeze
                local tbl1 = {
                    assignment = state.assignment,
                    index = state.index,
                    destination = 0
                }
                local freeze2 = table.freeze
                local tbl2 = {
                    kind = (if FFlagViewRecyclerReact084 then Destination.Kind elseif FFlagViewRecyclerReact08 then Destination.Kind else PlacementKind).List,
                    state = state,
                    sink = 0,
                    compositionPlacement = 0
                }

                if not (FFlagViewRecyclerReact084 or FFlagViewRecyclerReact08) then
                    sink = listSink(arg1, sink)
                end

                tbl2.sink = sink

                tbl2.compositionPlacement = if FFlagViewRecyclerReact084 or FFlagViewRecyclerReact08 then nil else var11
                tbl1.destination = freeze2(tbl2)
                var19 = freeze(tbl1)
            end

            transition(var19)
            local var20 = instrumentation()

            if arg2 and var20 ~= nil and var20.assignmentChanged ~= nil then
                var20.assignmentChanged(arg1, if state == nil then nil else state.assignment)
            end
        end
        function var18.onItemViewPresentationChanged(arg1, arg2)
            local var19 = instrumentation()

            if var19 ~= nil and var19.presentationChanged ~= nil then
                var19.presentationChanged(arg1, arg2)
            end
        end
        local virtualizer = ViewRecyclerRoblox.createVirtualizer(var18)
        var12.current = virtualizer
        local effect = nil
        if var6 ~= nil then
            local active = var18.active
            effect = Signals.createEffect(function(arg1)
                local var19 = var7.active(arg1)
                if var19 ~= active then
                    active = var19
                    virtualizer.setActive(var19)
                end
            end)
        end
        return function()
            if effect ~= nil then
                effect()
            end
            var12.current = nil
            virtualizer.destroy()
        end
    end, { var13 })

    if not (FFlagViewRecyclerReact084 or FFlagViewRecyclerReact08) then
        React.useLayoutEffect(function()
            return function()
                local current2 = var16.current
                if current2 ~= nil then
                    var16.current = nil
                    current2.destroy()
                end
            end
        end, {})

        React.useEffect(function()
            return var4.registerConsumer()
        end, { var4 })
    end

    React.useEffect(function()
        return function()
            local current2 = var8.current
            if current2 ~= nil then
                var8.current = nil
                current2()
            end
        end
    end, {})

    React.useLayoutEffect(function()
        var13.synchronize(current)
    end)

    React.useEffect(function()
        local current2 = var12.current
        if current2 ~= nil then
            current2.refreshItemViews()
        end
    end, { current.itemType })

    var1(function()
        local function runtime() -- Luacid: Inlined by compiler; 11 call sites recovered
            return assert(var12.current, "VirtualList: list handle used after unmount")
        end
        assignRef(current.listRef, {
            scrollToIndex = function(arg1, arg2)
                runtime().scrollToIndex(arg1, arg2)
            end,
            scrollToOffset = FFlagViewRecyclerReact084 and function(arg1, arg2)
                return runtime().scrollToOffset(arg1, arg2)
            end or function(arg1)
                return runtime().scrollToOffset(arg1)
            end,
            scrollToStart = FFlagViewRecyclerReact084 and function(arg1)
                runtime().scrollToStart(arg1)
            end or function()
                runtime().scrollToStart()
            end,
            scrollToEnd = FFlagViewRecyclerReact084 and function(arg1)
                runtime().scrollToEnd(arg1)
            end or function()
                runtime().scrollToEnd()
            end,
            scrollBy = function(arg1)
                return runtime().scrollBy(arg1)
            end,
            getScrollState = function()
                return runtime().getScrollState()
            end,
            captureScrollAnchorSnapshot = function()
                return runtime().captureScrollAnchorSnapshot()
            end,
            restoreScrollAnchorSnapshot = function(arg1)
                return runtime().restoreScrollAnchorSnapshot(arg1)
            end
        })

        return function()
            assignRef(current.listRef, nil)
        end
    end, { current.listRef })

    var1(function()
        assignRef(current.scrollingFrameRef, internalRef.current)
        return function()
            assignRef(current.scrollingFrameRef, nil)
        end
    end, { current.scrollingFrameRef, internalRef, current.scrollingFrame })

    local onViewportOverlayChanged = React.useCallback(function(_)
        var13.refreshHost()
    end, { var13.refreshHost })

    return {
        axis = current.axis,
        onScrollingFrameChanged = onScrollingFrameChanged,
        onViewportOverlayChanged = onViewportOverlayChanged,
        internalRef = internalRef,
        viewportOverlayRef = viewportOverlayRef,
        scrollingFrameProps = current.scrollingFrameProps,
        tag = current.tag
    }
end

return useVirtualList

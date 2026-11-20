-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:31:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FFlagViewRecyclerReact084 = require(script:FindFirstAncestor("ViewRecyclerReact").Flags).FFlagViewRecyclerReact084
local FFlagViewRecyclerReact08 = require(script:FindFirstAncestor("ViewRecyclerReact").Flags).FFlagViewRecyclerReact08
local ViewRecyclerReact = script:FindFirstAncestor("ViewRecyclerReact")

local ViewRecycler = require(ViewRecyclerReact.Parent.ViewRecycler)
local ItemHooks = require(ViewRecyclerReact.ReactAdapter.ItemHooks)
local LayoutHooks = require(ViewRecyclerReact.ReactAdapter.LayoutHooks)
local RecyclableViewReadiness = require(ViewRecyclerReact.ReactAdapter.RecyclableViewReadiness)
local RecyclableViewSwitch = require(ViewRecyclerReact.ReactAdapter.RecyclableViewSwitch)
local RecyclingScope = require(ViewRecyclerReact.ReactAdapter.RecyclingScope)
local RecyclingViewport = require(ViewRecyclerReact.ReactAdapter.RecyclingViewport)
local VirtualList = require(ViewRecyclerReact.ReactAdapter.VirtualList)
local createPinnedItem = require(ViewRecyclerReact.ReactAdapter.createPinnedItem)
local createRecyclableComponent = require(ViewRecyclerReact.ReactAdapter.createRecyclableComponent)
local createRecyclableView = require(ViewRecyclerReact.ReactAdapter.createRecyclableView)
local createVirtualList = require(ViewRecyclerReact.ReactAdapter.createVirtualList)
local useRectPlacement = require(ViewRecyclerReact.ReactAdapter.useRectPlacement)

local function createReactAdapter(arg1)
    local virtualList = VirtualList.create(arg1)
    local recyclingScope = RecyclingScope.create(arg1)
    local recyclingViewport = RecyclingViewport.create(arg1)
    local var1 = createVirtualList.create(virtualList)

    return table.freeze({
        VirtualList = virtualList,
        RecyclingScope = recyclingScope,
        RecyclingViewport = recyclingViewport,
        RecyclableViewSwitch = RecyclableViewSwitch,
        createPinnedItem = createPinnedItem,
        createRecyclableComponent = createRecyclableComponent,
        createRecyclableView = createRecyclableView,
        createVirtualList = var1,
        useRecyclingState = ItemHooks.useRecyclingState,
        useRecyclingSignal = ItemHooks.useRecyclingSignal,
        useRecyclingItem = ItemHooks.useRecyclingItem,
        useRecyclingAssignment = ItemHooks.useRecyclingAssignment,
        useRecyclingIndex = ItemHooks.useRecyclingIndex,
        useMeasuredLayout = LayoutHooks.useMeasuredLayout,
        useUniformLayout = LayoutHooks.useUniformLayout,
        useRectPlacement = if FFlagViewRecyclerReact084 then useRectPlacement elseif FFlagViewRecyclerReact08 then useRectPlacement else nil,
        RecyclableViewReadiness = RecyclableViewReadiness,
        DataSource = ViewRecycler.DataSource,
        Diagnostics = ViewRecycler.Diagnostics,
        Layout = ViewRecycler.Layout,
        ChatPreset = ViewRecycler.ChatPreset,
        Axis = ViewRecycler.Axis,
        AutoScrollPolicy = ViewRecycler.AutoScrollPolicy,
        ScrollAlignment = ViewRecycler.ScrollAlignment,
        ScrollObservationKind = ViewRecycler.ScrollObservationKind,
        PinnedPosition = ViewRecycler.PinnedPosition,
        IdentityKind = ViewRecycler.IdentityKind,
        DataPrefetchEdge = ViewRecycler.DataPrefetchEdge,
        DataSourceChangeType = ViewRecycler.DataSourceChangeType,
        ["jest.config"] = ViewRecyclerReact["jest.config"]
    })
end

return createReactAdapter

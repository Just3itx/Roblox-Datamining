-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:30:58Z
-- Luau bytecode version: 14 | Luau type version: 3
local _ViewRecycler = require(script.Parent.ViewRecycler)
local _ItemHooks = require(script.ReactAdapter.ItemHooks)
local ReactRoblox = require(script.Parent.ReactRoblox)
local _RecyclableViewReadiness = require(script.ReactAdapter.RecyclableViewReadiness)
local _RecyclableViewSwitch = require(script.ReactAdapter.RecyclableViewSwitch)
local _RecyclingScope = require(script.ReactAdapter.RecyclingScope)
local _RecyclingViewport = require(script.ReactAdapter.RecyclingViewport)
local _VirtualList = require(script.ReactAdapter.VirtualList)
local _createPinnedItem = require(script.ReactAdapter.createPinnedItem)
local createReactAdapter = require(script.ReactAdapter.Private.createReactAdapter)
local _createRecyclableComponent = require(script.ReactAdapter.createRecyclableComponent)
local _createRecyclableView = require(script.ReactAdapter.createRecyclableView)
local _createVirtualList = require(script.ReactAdapter.createVirtualList)
local _useRectPlacement = require(script.ReactAdapter.useRectPlacement)

return createReactAdapter({ createPortal = ReactRoblox.createPortal })

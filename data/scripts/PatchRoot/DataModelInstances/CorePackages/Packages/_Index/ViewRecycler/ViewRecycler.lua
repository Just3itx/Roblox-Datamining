-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:10:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local FFlagViewRecyclerReact084 = require(script.Flags).FFlagViewRecyclerReact084
local AutoScrollPolicy = require(script.Core.Enums.AutoScrollPolicy)
local Axis = require(script.Core.Enums.Axis)
local ChatPreset = require(script.Core.ViewportBehavior.ChatPreset)
local DataPrefetch = require(script.Core.DataPrefetch)
local DataSource = require(script.Core.DataSource)
local DataSourceChangeType = require(script.Core.Enums.DataSourceChangeType)
local Diagnostics = require(script.Core.Diagnostics)
local IdentityKind = require(script.Core.Enums.IdentityKind)
local Layout = require(script.Core.Layout)
local _PinnedItems = require(script.Core.PinnedItems)
local PinnedPosition = require(script.Core.Enums.PinnedPosition)
local ReachedThreshold = require(script.Core.ViewportBehavior.ReachedThreshold)
local Recycling = require(script.Core.Recycling)
local ScrollAlignment = require(script.Core.Enums.ScrollAlignment)

local ScrollMotion = require(script.Core.Virtualizer.ScrollMotion)
local ScrollObservationKind = require(script.Core.Enums.ScrollObservationKind)
local ShallowTable = require(script.Internal.ShallowTable)
local _Types = require(script.Core.Types)
local createScope = Recycling.createScope
local SlotBinder = require(script.Core.Recycling.SlotBinder)
local Virtualizer = require(script.Core.Virtualizer.Virtualizer)

local freeze = table.freeze
local tbl1 = {
    createRecyclingScope = createScope,
    createVirtualizer = Virtualizer,
    createSlotBinder = SlotBinder,
    _Private = 0
}
local freeze2 = table.freeze
local tbl2 = { ReachedThreshold = 0, ShallowTable = 0, ScrollMotion = 0 }
if not FFlagViewRecyclerReact084 then
    ReachedThreshold = nil
end

tbl2.ReachedThreshold = ReachedThreshold
tbl2.ShallowTable = ShallowTable
if not FFlagViewRecyclerReact084 then
    ScrollMotion = nil
end

tbl2.ScrollMotion = ScrollMotion
tbl1._Private = freeze2(tbl2)
local Adapter = freeze(tbl1)

return table.freeze({
    DataSource = DataSource,
    Diagnostics = Diagnostics,
    Layout = Layout,
    ChatPreset = ChatPreset,
    Axis = Axis,
    AutoScrollPolicy = AutoScrollPolicy,
    ScrollAlignment = ScrollAlignment,
    ScrollObservationKind = ScrollObservationKind,
    PinnedPosition = PinnedPosition,
    IdentityKind = IdentityKind,
    DataPrefetchEdge = DataPrefetch.Edge,
    DataSourceChangeType = DataSourceChangeType,
    Adapter = Adapter,
    ["jest.config"] = script["jest.config"]
})

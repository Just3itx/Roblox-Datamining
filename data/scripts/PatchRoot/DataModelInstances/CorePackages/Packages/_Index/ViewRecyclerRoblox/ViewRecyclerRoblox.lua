-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:40:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local FFlagViewRecyclerReact084 = require(script.Flags).FFlagViewRecyclerReact084
local FFlagViewRecyclerReact08 = require(script.Flags).FFlagViewRecyclerReact08

local AttachedViewportOverlay = require(script.RobloxAdapter.AttachedViewportOverlay)
local CanvasItemPlacer = require(script.RobloxAdapter.CanvasItemPlacer)
local ViewRecycler = require(script.Parent.ViewRecycler)

local HostPlacement = require(script.RobloxAdapter.HostPlacement)
local HostPresentationPhase = require(script.RobloxAdapter.HostPresentationPhase)

local MeasurementBatcher = require(script.RobloxAdapter.MeasurementBatcher)
local Measurer = require(script.RobloxAdapter.Measurer)
local ReparentableHost = require(script.RobloxAdapter.ReparentableHost)

local ScrollHost = require(script.RobloxAdapter.ScrollHost)
local ScrollbarOverlay = require(script.RobloxAdapter.ScrollbarOverlay)
local SlotGeometry = require(script.RobloxAdapter.SlotGeometry)

local VacantHosts = require(script.RobloxAdapter.VacantHosts)
local ViewportCoordinator = require(script.RobloxAdapter.ViewportCoordinator)
local createRecyclingScope = require(script.RobloxAdapter.createRecyclingScope)
local createVirtualizer = require(script.RobloxAdapter.createVirtualizer)

local freeze = table.freeze
local tbl1 = {
    ScrollbarOverlay = ScrollbarOverlay,
    VacantHosts = 0,
    AttachedViewportOverlay = 0,
    CanvasItemPlacer = 0,
    HostPlacement = 0,
    ScrollHost = 0
}

if not FFlagViewRecyclerReact084 then
    VacantHosts = nil
end

tbl1.VacantHosts = VacantHosts

if FFlagViewRecyclerReact084 or FFlagViewRecyclerReact08 then
    AttachedViewportOverlay = nil
end

tbl1.AttachedViewportOverlay = AttachedViewportOverlay

if FFlagViewRecyclerReact084 or FFlagViewRecyclerReact08 then
    CanvasItemPlacer = nil
end

tbl1.CanvasItemPlacer = CanvasItemPlacer

if FFlagViewRecyclerReact084 or FFlagViewRecyclerReact08 then
    HostPlacement = nil
end

tbl1.HostPlacement = HostPlacement
if FFlagViewRecyclerReact084 or FFlagViewRecyclerReact08 then
    ScrollHost = nil
end

tbl1.ScrollHost = ScrollHost
local Internal = freeze(tbl1)

local freeze2 = table.freeze
local tbl2 = {
    createRecyclingScope = createRecyclingScope.create,
    createVirtualizer = createVirtualizer,
    ChatPreset = ViewRecycler.ChatPreset,
    HostPresentationPhase = HostPresentationPhase,
    ReparentableHost = ReparentableHost,
    SlotGeometry = SlotGeometry,
    ViewportCoordinator = ViewportCoordinator,
    Internal = Internal,
    ["jest.config"] = script["jest.config"]
}
if FFlagViewRecyclerReact084 or FFlagViewRecyclerReact08 then
    MeasurementBatcher = nil
end

tbl2.MeasurementBatcher = MeasurementBatcher

if FFlagViewRecyclerReact084 or FFlagViewRecyclerReact08 then
    Measurer = nil
end

tbl2.Measurer = Measurer
return freeze2(tbl2)

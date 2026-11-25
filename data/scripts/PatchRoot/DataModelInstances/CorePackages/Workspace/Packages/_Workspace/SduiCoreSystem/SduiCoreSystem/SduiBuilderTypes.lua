-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T10:01:10Z
-- Luau bytecode version: 14 | Luau type version: 3
local SduiCoreSystem = script:FindFirstAncestor("SduiCoreSystem")
local SduiCoreSystemParent = SduiCoreSystem.Parent
local _React = require(SduiCoreSystemParent.React)
local _UnifiedLogging = require(SduiCoreSystemParent.UnifiedLogging)
local _Foundation = require(SduiCoreSystemParent.Foundation)
local _CollectionViews = require(SduiCoreSystemParent.CollectionViews)
local _Signals = require(SduiCoreSystemParent.Signals)

local _SduiActionType = require(SduiCoreSystem.SduiActionType)
local _SduiComponentType = require(SduiCoreSystem.SduiComponentType)
local _SduiErrors = require(SduiCoreSystem.SduiErrors)
local _SduiConfigTypes = require(SduiCoreSystem.SduiConfigTypes)
local _SduiDataStoreTypes = require(SduiCoreSystem.SduiDataStoreTypes)
local _DataHydration = require(SduiCoreSystemParent.DataHydration)

return {
    SduiBuilderProcessingPhase = { Eager = "Eager", Render = "Render", Lazy = "Lazy" }
}

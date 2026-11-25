-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T09:51:15Z
-- Luau bytecode version: 14 | Luau type version: 3
local SduiCoreSystem = script:FindFirstAncestor("SduiCoreSystem")
local SduiCoreSystemParent = SduiCoreSystem.Parent

local _ServiceContractsProto = require(SduiCoreSystemParent.ServiceContractsProto)
local _Signals = require(SduiCoreSystemParent.Signals)

local _SduiBuilderTypes = require(SduiCoreSystem.SduiBuilderTypes)
local _SduiErrors = require(SduiCoreSystem.SduiErrors)
local _SduiActionType = require(SduiCoreSystem.SduiActionType)
local _SduiComponentType = require(SduiCoreSystem.SduiComponentType)
local _SduiDataBindingContentType = require(SduiCoreSystem.ClientBinding.SduiDataBindingContentType)

return {
    PropResultCategory = {
        Literal = "Literal",
        PropSignal = "PropSignal",
        NestedComponentConfig = "NestedComponentConfig",
        NestedComponentConfigListPropSignal = "NestedComponentConfigListPropSignal",
        Failed = "Failed"
    }
}

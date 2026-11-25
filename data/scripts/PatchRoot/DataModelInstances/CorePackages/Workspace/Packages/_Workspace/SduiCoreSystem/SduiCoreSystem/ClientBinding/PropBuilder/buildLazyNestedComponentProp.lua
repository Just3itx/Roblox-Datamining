-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T09:41:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiCoreSystem = script:FindFirstAncestor("SduiCoreSystem")
local SduiCoreSystemParent = SduiCoreSystem.Parent
local _Signals = require(SduiCoreSystemParent.Signals)
local _ServiceContractsProto = require(SduiCoreSystemParent.ServiceContractsProto)

local _SduiBuilderTypes = require(SduiCoreSystem.SduiBuilderTypes)
local _SduiClientBindingTypes = require(SduiCoreSystem.ClientBinding.SduiClientBindingTypes)
local buildNestedComponentProp = require(SduiCoreSystem.ClientBinding.PropBuilder.buildNestedComponentProp)

local function buildLazyNestedComponentProp(str1: string, arg1, arg2, arg3, arg4, arg5)
    return buildNestedComponentProp(str1, arg1, arg2, arg3, arg4, arg5, true)
end

return buildLazyNestedComponentProp

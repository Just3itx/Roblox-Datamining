-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T09:50:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiCoreSystem = script:FindFirstAncestor("SduiCoreSystem")

local buildLazyNestedComponentListProp = require(SduiCoreSystem.ClientBinding.PropBuilder.buildLazyNestedComponentListProp)
local PropResultCategory = require(SduiCoreSystem.ClientBinding.SduiClientBindingTypes).PropResultCategory

local function buildNestedComponentListProp(...)
    return buildLazyNestedComponentListProp(...), PropResultCategory.NestedComponentConfigListPropSignal
end

return buildNestedComponentListProp

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T10:11:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiFoundation = script:FindFirstAncestor("SduiFoundation")
local SduiFoundationParent = SduiFoundation.Parent

local getSduiComponentRegistry = require(SduiFoundationParent.SduiCoreSystem).getSduiComponentRegistry
local getComponentDefinitions = require(SduiFoundation.Components.getComponentDefinitions)

local function registerFoundationComponents()
    getSduiComponentRegistry().registerComponentDefinitions(getComponentDefinitions())
end

return registerFoundationComponents

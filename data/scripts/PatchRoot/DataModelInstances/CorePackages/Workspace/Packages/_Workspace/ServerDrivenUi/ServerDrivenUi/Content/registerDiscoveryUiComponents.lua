-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:21:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUi = script:FindFirstAncestor("ServerDrivenUi")
local ServerDrivenUiParent = ServerDrivenUi.Parent

local getSduiComponentRegistry = require(ServerDrivenUiParent.SduiCoreSystem).getSduiComponentRegistry
local SduiComponentDefinitions = require(ServerDrivenUi.System.SduiComponentDefinitions)

local function registerDiscoveryUiComponents()
    local _registeredComponents = SduiComponentDefinitions.new()._registeredComponents
    getSduiComponentRegistry().registerComponentDefinitions(_registeredComponents)
end

return registerDiscoveryUiComponents

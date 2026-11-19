-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:50:41Z
-- Luau bytecode version: 14 | Luau type version: 3
local Chrome = script:FindFirstAncestor("Chrome")

local Service = require(Chrome.Service)
local registerConnectIntegration = require(script.Parent.registerConnectIntegration)

return if require(script.Parent.isConnectDropdownEnabled)() then registerConnectIntegration("connect_dropdown", Service.AvailabilitySignal.Available) else nil

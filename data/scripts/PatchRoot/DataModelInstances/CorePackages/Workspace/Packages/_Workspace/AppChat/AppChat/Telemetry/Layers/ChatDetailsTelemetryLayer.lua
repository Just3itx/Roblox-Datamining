-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:30:57Z
-- Luau bytecode version: 14 | Luau type version: 3
local Telemetry = script:FindFirstAncestor("AppChat").Telemetry
return (require(Telemetry.createReactTelemetryLayer)(require(Telemetry.Layers.ChatConversationTelemetryLayer).Context, {}))

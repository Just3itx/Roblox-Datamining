-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:30:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent
local React = require(AppChatParent.React)

local Telemetry = AppChat.Telemetry
local createReactTelemetryLayer = require(Telemetry.createReactTelemetryLayer)
local ChatPlacementContext = require(AppChat.Contexts.ChatPlacementContext)

return createReactTelemetryLayer(React.createContext(function()
    return {}
end), {
    context = "platformChat",
    locale = "unknown",
    entryPoint = "unknown",
    userId = "unknown",
    placement = ChatPlacementContext.Enum.Unknown
})

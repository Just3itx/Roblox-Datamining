-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:00:46Z
-- Luau bytecode version: 14 | Luau type version: 3
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

return {
    eventName = "appChatKeyStrokes",
    backends = { require(AppChatParent.LoggingProtocol).TelemetryBackends.EventIngest },
    throttlingPercentage = 10000,
    lastUpdated = { 24, 5, 20 },
    description = "Tracks keystroke data for the chat conversation screen",
    links = "https://docs.google.com/document/d/1CIP98uWhheThwiGBioCeXJ_WDmnym5D-zmUe5cNxOJ0/edit?tab=t.0#heading=h.q5oxzu9wbzz6"
}

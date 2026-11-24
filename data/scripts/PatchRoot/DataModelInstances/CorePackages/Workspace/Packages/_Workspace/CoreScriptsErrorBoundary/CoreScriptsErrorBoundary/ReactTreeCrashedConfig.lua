-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T01:10:52Z
-- Luau bytecode version: 14 | Luau type version: 3
local scriptParentParent = script.Parent.Parent

return {
    eventName = "LuaCoreScriptsReactTreeCrashed",
    backends = { require(scriptParentParent.LoggingProtocol).TelemetryBackends.Counter },
    lastUpdated = { 26, 10, 8 },
    description = "Report a CoreScripts React tree being torn down by an uncaught error, tagged by surface"
}

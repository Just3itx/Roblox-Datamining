-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:11:09Z
-- Luau bytecode version: 14 | Luau type version: 3
local CorePackages = game:GetService("CorePackages")
local LoggingProtocol = require(CorePackages.Workspace.Packages.LoggingProtocol)
local throttlingPercentage = game:DefineFastInt("LuaCoreScriptsErrorV2ThrottleHundredthPercentage", 0)

return {
    eventName = "LuaCoreScriptsError",
    backends = { LoggingProtocol.TelemetryBackends.Counter },
    throttlingPercentage = throttlingPercentage,
    lastUpdated = { 25, 1, 29 },
    description = "V2 Counter to for Lua CoreScripts Error."
}

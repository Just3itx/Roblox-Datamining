-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T01:10:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
return {
    CoreScriptsErrorBoundary = require(script.CoreScriptsErrorBoundary),
    Surfaces = require(script.Surfaces),
    ReactTreeCrashedConfig = require(script.ReactTreeCrashedConfig),
    Flags = {
        FFlagCoreScriptsReactTreeCrashCounter = require(script.Flags.FFlagCoreScriptsReactTreeCrashCounter)
    },
    ["jest.config"] = script["jest.config"]
}

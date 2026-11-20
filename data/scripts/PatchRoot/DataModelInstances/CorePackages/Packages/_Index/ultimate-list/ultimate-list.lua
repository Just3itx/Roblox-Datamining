-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:41:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local Components = require(script.Components)
local DataSources = require(script.DataSources)
return {
    Components = Components,
    DebugFlags = require(script.DebugFlags),
    DataSources = DataSources,
    Dimensions = require(script.Dimensions),
    Renderers = require(script.Renderers)
}

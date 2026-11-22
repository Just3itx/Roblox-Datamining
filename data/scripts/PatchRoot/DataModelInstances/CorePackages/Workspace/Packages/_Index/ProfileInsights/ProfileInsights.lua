-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T10:50:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local Formatters = require(script.Formatters)
local ProfileInsightsModel = require(script["data-hydration"].ProfileInsightsModel)

return {
    Enums = require(script.Enums),
    Formatters = Formatters,
    ProfileInsightsStore = require(script["data-hydration"].ProfileInsightsStore),
    ProfileInsightsModel = ProfileInsightsModel,
    useSignalProfileInsightsByUserId = require(script.Hooks.useSignalProfileInsightsByUserId),
    ["jest.config"] = script["jest.config"],
    ["data-hydration"] = require(script["data-hydration"])
}

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T01:21:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local createSignalMap = require(script.Utilities.createSignalMap)

return {
    CoreScriptsRootProvider = require(script.CoreScriptsRootProvider),
    Scrim = require(script.Scrim),
    Traversal = require(script.Traversal),
    ["jest.config"] = script["jest.config"],
    ["jest.main.config"] = script["jest.main.config"],
    ["jest.mockDataModel.config"] = script["jest.mockDataModel.config"],
    useScreenSize = require(script.useScreenSize),
    Utilities = {
        createSignalMap = createSignalMap,
        sortTableByValue = require(script.Utilities.sortTableByValue)
    }
}

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T20:41:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
return {
    Hooks = require(script.Parent.Hooks),
    Formatters = require(script.Parent.Formatters),
    Selectors = require(script.Parent.Selectors),
    Queries = require(script.Parent.Common.Queries),
    Mutations = require(script.Parent.Mutations),
    Stores = require(script.Parent.Stores),
    TestUtils = require(script.Parent.TestUtils),
    UserProfilesFetchWrapper = require(script.Parent.UserProfilesFetchWrapper),
    ["jest.config"] = script.Parent["jest.config"]
}

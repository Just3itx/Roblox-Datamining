-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T06:01:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
return {
    Constants = require(script.Constants),
    DrawerContainer = require(script.Components.DrawerContainer),
    Hooks = {
        useDrawerVisible = require(script.Hooks.useDrawerVisible),
        useSetDrawerVisible = require(script.Hooks.useSetDrawerVisible),
        useDrawerShouldMount = require(script.Hooks.useDrawerShouldMount),
        useDrawerAnimating = require(script.Hooks.useDrawerAnimating),
        useSetDrawerAnimating = require(script.Hooks.useSetDrawerAnimating)
    },
    Stores = {
        GetDrawerVisibleStore = require(script.Stores.GetDrawerVisibleStore)
    },
    ["jest.config"] = script["jest.config"]
}

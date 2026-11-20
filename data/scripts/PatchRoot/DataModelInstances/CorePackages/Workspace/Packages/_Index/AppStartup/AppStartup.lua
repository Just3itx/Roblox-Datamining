-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T23:30:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local AppStartupSequence = require(script.AppStartupSequence)
local PlatformAccountRouter = require(script.Components.PlatformAccountRouter)
local StartupMessageContainer = require(script.Components.StartupMessage.StartupMessageContainer)
local navigateWithPlatformAccount = require(script.navigateWithPlatformAccount)
local Reducers = require(script.Reducers)
local Actions = require(script.Actions)
local Enums = require(script.Enums)
local Hooks = require(script.Hooks)

return {
    AppStartupSequence = AppStartupSequence,
    PlatformAccountRouter = PlatformAccountRouter,
    StartupMessageContainer = StartupMessageContainer,
    PostAppInteractiveContainer = require(script.Components.PostAppInteractiveContainer),
    navigateWithPlatformAccount = navigateWithPlatformAccount,
    Reducers = Reducers,
    Actions = Actions,
    Hooks = Hooks,
    Enums = Enums,
    ["jest.config"] = script["jest.config"]
}

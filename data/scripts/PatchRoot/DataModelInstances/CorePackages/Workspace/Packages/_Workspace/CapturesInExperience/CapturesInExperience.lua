-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T23:21:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local _App = require(script.App.App)
local Constants = require(script.Constants)
local _Types = require(script.Types)

return {
    ["jest.config"] = script["jest.config"],
    Actions = require(script.Actions),
    Analytics = require(script.Analytics),
    App = require(script.App),
    CapturesPolicy = require(script.App.CapturesPolicy),
    Constants = Constants,
    Context = require(script.Context),
    Flags = require(script.Flags),
    installReducer = require(script.installReducer),
    RoduxKey = Constants.RoduxKey
}

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:11:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
return {
    ["jest.config"] = script["jest.config"],
    Actions = {
        SetAuthenticationStatus = require(script.Actions.SetAuthenticationStatus)
    },
    Reducers = {
        AuthenticationStatusReducer = require(script.Reducers.AuthenticationStatusReducer)
    },
    GetAuthenticationStatusStore = require(script.Stores.GetAuthenticationStatusStore)
}

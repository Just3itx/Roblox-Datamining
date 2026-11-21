-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T06:21:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
return {
    ["jest.config"] = script["jest.config"],
    Actions = {
        SetCentralOverlay = require(script.Actions.SetCentralOverlay)
    },
    Reducers = {
        CentralOverlayReducer = require(script.Reducers.CentralOverlayReducer)
    },
    Thunks = {
        CloseCentralOverlay = require(script.Thunks.CloseCentralOverlay)
    }
}

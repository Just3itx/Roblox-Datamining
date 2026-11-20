-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:21:22Z
-- Luau bytecode version: 14 | Luau type version: 3
local SignalsScheduler = require(script.Parent.SignalsScheduler)

local createProxy = require(script.createProxy)

return {
    batch = SignalsScheduler.batch,
    createProxy = createProxy,
    createReducer = require(script.createReducer),
    onDisposed = require(script.onDisposed)
}

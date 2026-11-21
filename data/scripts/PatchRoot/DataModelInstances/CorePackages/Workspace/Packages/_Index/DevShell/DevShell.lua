-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T09:51:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local createShell = require(script.createShell)
local FFlagEnableDevShell = require(script.Flags.FFlagEnableDevShell)
local FFlagEnableMemoryShell = require(script.Flags.FFlagEnableMemoryShell)

local shell = createShell({
    host = game:DefineFastString("DevShellHost", "ws://localhost:5013"),
    enabled = FFlagEnableDevShell or FFlagEnableMemoryShell
})

return {
    ["jest.config"] = script["jest.config"],
    start = shell.start,
    stop = shell.stop,
    isConnected = shell.isConnected,
    registerMethods = shell.registerMethods,
    FFlagEnableMemoryShell = FFlagEnableMemoryShell
}

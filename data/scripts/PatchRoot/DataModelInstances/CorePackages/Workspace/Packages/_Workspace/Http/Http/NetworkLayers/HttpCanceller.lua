-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-18T23:40:55Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local module = {}

local currentSession = 0

function module.currentSession()
    return currentSession
end

function module.cancel()
    currentSession += 1
end

return module

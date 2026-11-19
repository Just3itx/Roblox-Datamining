-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T05:41:29Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local tbl1 = {
    DEV = require(script.DEV).default
}

local removeTemporaryGlobals = require(script.graphql).removeTemporaryGlobals
tbl1.removeTemporaryGlobals = removeTemporaryGlobals

tbl1.NULL = require(script.null).NULL

removeTemporaryGlobals()

return tbl1

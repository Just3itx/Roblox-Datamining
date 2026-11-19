-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T05:11:14Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local tbl1 = {}
local scriptParent = script.Parent
local Object = require(scriptParent.LuauPolyfill).Object
local core = require(script.core)
Object.assign(tbl1, core)
tbl1.None = core.None

local react = require(script.react)
Object.assign(tbl1, react)

return tbl1

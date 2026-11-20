-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:51:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent

local Object = require(scriptParentParentParentParent.LuauPolyfill).Object

local tbl1 = {}
local default = require(scriptParentParentParentParent.React).createContext(nil)
if _G.__DEV__ then
    default.displayName = "ScrollViewContext"
end
tbl1.default = default

tbl1.HORIZONTAL = Object.freeze({ horizontal = true })

tbl1.VERTICAL = Object.freeze({ horizontal = false })

return tbl1

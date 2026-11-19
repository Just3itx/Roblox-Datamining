-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T05:31:08Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local scriptParentParent = script.Parent.Parent
local tbl1 = {}
local _anyEntryTypes = require(script.Parent.anyEntryTypes)

tbl1.parentEntrySlot = require(scriptParentParent.wry.context).Slot.new()
local context = require(scriptParentParent.wry.context)
tbl1.bindContext = context.bind
tbl1.noContext = context.noContext
tbl1.setTimeout = context.setTimeout

return tbl1

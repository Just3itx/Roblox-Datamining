-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:00:49Z
-- Luau bytecode version: 14 | Luau type version: 3
local Dictionary = require(script.Parent.Dictionary)

return {
    add = require(script.add),
    has = require(script.has),
    intersect = require(script.intersect),
    subtract = require(script.subtract),
    toList = require(script.toList),
    union = require(script.union),
    copy = Dictionary.copy
}

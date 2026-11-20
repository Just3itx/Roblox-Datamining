-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T02:40:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local _ES7Types = require(scriptParentParentParent.ES7Types)

local indexOf = require(script.Parent.indexOf)

return function(arg1, arg2, num1: number?): boolean
    return indexOf(arg1, arg2, num1) ~= -1
end

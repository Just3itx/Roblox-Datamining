-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T04:41:18Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local _types = require(scriptParentParent.types)

local indexOf = require(script.Parent.indexOf)

return function(arg1, arg2, num1: number?): boolean
    return indexOf(arg1, arg2, num1) ~= -1
end

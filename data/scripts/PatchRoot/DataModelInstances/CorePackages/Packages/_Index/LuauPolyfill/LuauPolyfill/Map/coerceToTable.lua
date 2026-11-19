-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T10:51:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local Parent = require(script.Parent)
local instanceof = require(scriptParentParent.instanceof)
local reduce = require(scriptParentParent.Array.reduce)
local _types = require(scriptParentParent.types)

local function coerceToTable(arg1)
    if not instanceof(arg1, Parent) then
        return arg1
    end

    return reduce(arg1:entries(), function(arg2, arg3)
        arg2[arg3[1]] = arg3[2]
        return arg2
    end, {})
end

return coerceToTable

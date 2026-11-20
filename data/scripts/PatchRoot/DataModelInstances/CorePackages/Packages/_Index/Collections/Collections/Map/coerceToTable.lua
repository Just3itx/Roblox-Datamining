-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T02:41:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local Map = require(scriptParent.Map)
local InstanceOf = require(scriptParentParentParent.InstanceOf)
local reduce = require(scriptParentParent.Array.reduce)
local _ES7Types = require(scriptParentParentParent.ES7Types)

local function coerceToTable(arg1)
    if not InstanceOf(arg1, Map) then
        return arg1
    end

    return reduce(arg1:entries(), function(arg2, arg3)
        arg2[arg3[1]] = arg3[2]
        return arg2
    end, {})
end

return coerceToTable

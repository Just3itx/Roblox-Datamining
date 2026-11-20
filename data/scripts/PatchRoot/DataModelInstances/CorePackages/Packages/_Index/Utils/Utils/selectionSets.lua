-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:10:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local module = {}
local parse = require(scriptParentParent.GraphQL).parse

local _Interfaces = require(script.Parent.Interfaces)

function module.parseSelectionSet(str1: string, arg1)
    return parse(str1, arg1).definitions[1].selectionSet
end

return module

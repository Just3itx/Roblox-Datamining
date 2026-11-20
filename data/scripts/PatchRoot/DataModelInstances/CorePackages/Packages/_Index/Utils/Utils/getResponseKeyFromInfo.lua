-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:01:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local module = {}

local _GraphQL = require(scriptParentParent.GraphQL)

function module.getResponseKeyFromInfo(arg1)
    if arg1.fieldNodes[1] and arg1.fieldNodes[1].alias ~= nil then
        return arg1.fieldNodes[1].alias.value
    end

    return arg1.fieldName
end

return module

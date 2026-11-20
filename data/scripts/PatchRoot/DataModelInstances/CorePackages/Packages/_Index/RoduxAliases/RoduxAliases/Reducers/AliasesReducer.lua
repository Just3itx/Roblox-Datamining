-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:40:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local byUserId = require(scriptParentParent.Reducers.Aliases.byUserId)

local _RoduxAliasesTypes = require(scriptParentParent.RoduxAliasesTypes)

local tbl1 = {}

return function(arg1)
    return function(arg2, arg3)
        local var1 = arg2 or tbl1

        return {
            byUserId = byUserId(arg1)(var1.byUserId, arg3)
        }
    end
end

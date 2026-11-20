-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:40:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local getDeepValue = require(scriptParentParent.getDeepValue)

local _RoduxAliasesTypes = require(scriptParentParent.RoduxAliasesTypes)

return function(arg1)
    local keyPath = arg1.keyPath
    return function(arg2, arg3)
        return getDeepValue(arg2, keyPath .. ".byUserId")[arg3]
    end
end

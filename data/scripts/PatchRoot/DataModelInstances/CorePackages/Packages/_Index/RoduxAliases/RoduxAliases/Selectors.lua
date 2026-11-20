-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:40:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local _RoduxAliasesTypes = require(scriptParent.RoduxAliasesTypes)

return function(arg1)
    return {
        getAliasByUserId = require(script.getAliasByUserId)(arg1)
    }
end

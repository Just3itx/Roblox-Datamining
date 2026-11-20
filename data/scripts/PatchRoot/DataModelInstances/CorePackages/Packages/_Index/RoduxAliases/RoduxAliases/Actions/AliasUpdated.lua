-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:40:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RoduxAliasesParent = script:FindFirstAncestor("RoduxAliases").Parent
return require(RoduxAliasesParent.Rodux).makeActionCreator(script.Name, function(userId, newAlias)
    return {
        payload = { userId = userId, newAlias = newAlias }
    }
end)

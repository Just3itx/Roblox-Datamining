-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T17:40:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SquadsCoreParent = script:FindFirstAncestor("SquadsCore").Parent

return require(SquadsCoreParent.Rodux).makeActionCreator(script.Name, function(arg1)
    return { arguments = arg1 }
end)

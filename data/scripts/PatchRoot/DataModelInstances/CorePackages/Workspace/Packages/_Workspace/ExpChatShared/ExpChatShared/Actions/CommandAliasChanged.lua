-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T10:11:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChatSharedParent = script:FindFirstAncestor("ExpChatShared").Parent
return require(ExpChatSharedParent.Rodux).makeActionCreator(script.Name, function(name: string, primaryAlias: string, secondaryAlias: string)
    return { name = name, primaryAlias = primaryAlias, secondaryAlias = secondaryAlias }
end)

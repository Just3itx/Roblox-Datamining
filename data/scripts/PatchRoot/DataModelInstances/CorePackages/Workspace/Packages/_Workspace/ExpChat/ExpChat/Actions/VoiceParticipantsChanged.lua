-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T07:21:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChatParent = script:FindFirstAncestor("ExpChat").Parent
return require(ExpChatParent.Rodux).makeActionCreator(script.Name, function(newParticipants)
    return { newParticipants = newParticipants }
end)

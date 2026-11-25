-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:30:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VoiceChatParent = script:FindFirstAncestor("VoiceChat").Parent
return require(VoiceChatParent.Rodux).makeActionCreator(script.Name, function(isUserOptIn)
    return { isUserOptIn = isUserOptIn }
end)

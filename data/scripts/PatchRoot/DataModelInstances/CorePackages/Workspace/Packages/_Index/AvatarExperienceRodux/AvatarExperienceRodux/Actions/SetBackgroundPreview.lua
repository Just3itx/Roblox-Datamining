-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T04:10:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceRoduxParent = script:FindFirstAncestor("AvatarExperienceRodux").Parent
return require(AvatarExperienceRoduxParent.Rodux).makeActionCreator(script.Name, function(previewKey: string?)
    return { previewKey = previewKey }
end)

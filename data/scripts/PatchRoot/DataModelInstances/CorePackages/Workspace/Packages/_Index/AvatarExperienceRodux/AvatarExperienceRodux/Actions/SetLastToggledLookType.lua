-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T04:11:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceRoduxParent = script:FindFirstAncestor("AvatarExperienceRodux").Parent
return require(AvatarExperienceRoduxParent.Rodux).makeActionCreator(script.Name, function(tbl1)
    return {
        lastToggledLookType = tbl1.lastToggledLookType
    }
end)

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:31:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommonParent = script:FindFirstAncestor("AvatarExperienceCommon").Parent

return require(AvatarExperienceCommonParent.Rodux).makeActionCreator(script.Name, function(tbl1)
    return {
        type = script.Name,
        isUndo = tbl1.isUndo,
        equipped = tbl1.equipped,
        tryOn = tbl1.tryOn
    }
end)

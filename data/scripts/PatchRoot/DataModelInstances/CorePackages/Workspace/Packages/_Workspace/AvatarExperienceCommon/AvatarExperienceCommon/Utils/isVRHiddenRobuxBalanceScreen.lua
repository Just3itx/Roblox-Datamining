-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T14:00:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommonParent = script:FindFirstAncestor("AvatarExperienceCommon").Parent

local tbl1 = {
    [require(AvatarExperienceCommonParent.AvatarExperienceNavigation).Enums.AvatarScreen.BackgroundGeneration] = true
}

local function isVRHiddenRobuxBalanceScreen(str1: string?): boolean
    return not (str1 == nil) and tbl1[str1] == true
end

return isVRHiddenRobuxBalanceScreen

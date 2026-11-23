-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:51:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommon = script:FindFirstAncestor("AvatarExperienceCommon")

local BODY_PART_FOR_SKIN_COLORING_ID_TO_HUMANOID_DESCRIPTION = require(AvatarExperienceCommon.Constants).BODY_PART_FOR_SKIN_COLORING_ID_TO_HUMANOID_DESCRIPTION

return function(arg1, arg2)
    if not arg2 then
        return
    end

    for value, value2 in arg2 do
        arg1[BODY_PART_FOR_SKIN_COLORING_ID_TO_HUMANOID_DESCRIPTION[value]] = value2
    end
end

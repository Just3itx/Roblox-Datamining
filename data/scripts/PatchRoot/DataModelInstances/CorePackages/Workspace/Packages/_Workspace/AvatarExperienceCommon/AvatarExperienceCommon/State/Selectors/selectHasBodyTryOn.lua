-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:40:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local selectTryOnBodyIds = require(script.Parent.selectTryOnBodyIds)

local function selectHasBodyTryOn(arg1): boolean
    return #selectTryOnBodyIds(arg1) > 0
        or not (arg1.AvatarExperience.AvatarScene.OutfitTryOn == nil)
            and arg1.AvatarExperience.AvatarScene.OutfitTryOn.LookId ~= nil
end

return selectHasBodyTryOn

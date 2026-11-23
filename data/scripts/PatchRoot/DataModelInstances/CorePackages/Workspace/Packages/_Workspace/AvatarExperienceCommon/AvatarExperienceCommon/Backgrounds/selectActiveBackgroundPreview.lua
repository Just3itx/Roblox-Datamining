-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:11:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function selectActiveBackgroundPreview(arg1)
    local var1 = arg1 and (arg1.AvatarExperience or arg1)
    local outfitTryOn = var1 and var1.AvatarScene and var1.AvatarScene.OutfitTryOn
    return if outfitTryOn then outfitTryOn.BackgroundPreview else nil
end

return selectActiveBackgroundPreview

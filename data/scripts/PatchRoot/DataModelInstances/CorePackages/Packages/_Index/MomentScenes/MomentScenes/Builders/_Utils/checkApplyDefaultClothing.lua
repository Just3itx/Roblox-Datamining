-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T10:01:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function checkApplyDefaultClothing(humanoidDescription: HumanoidDescription): HumanoidDescription
    return game:GetService("AvatarEditorService"):CheckApplyDefaultClothingAsync(humanoidDescription)
end

return checkApplyDefaultClothing

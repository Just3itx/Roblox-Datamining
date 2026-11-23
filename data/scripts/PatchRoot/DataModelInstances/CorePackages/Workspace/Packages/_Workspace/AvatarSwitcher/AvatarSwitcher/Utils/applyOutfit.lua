-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T17:31:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarEditorService = game:GetService("AvatarEditorService")
local Players = game:GetService("Players")

local function applyOutfit(outfitId: number, humanoidRigType: Enum.HumanoidRigType)
    local humanoidDescription = Players:GetHumanoidDescriptionFromOutfitIdAsync(outfitId)

    AvatarEditorService:NoPromptSaveAvatar(
        humanoidDescription,
        humanoidRigType,
        { BodyColors = true, AvatarType = true, Scales = true, Assets = true }
    )
    AvatarEditorService.PromptSaveAvatarCompleted:Wait()
end

return applyOutfit

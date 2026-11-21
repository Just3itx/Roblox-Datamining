-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T04:30:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarEditorService = game:GetService("AvatarEditorService")
local AvatarExperienceSaveParent = script:FindFirstAncestor("AvatarExperienceSave").Parent

local Promise = require(AvatarExperienceSaveParent.Promise)
local _LuauPolyfill = require(AvatarExperienceSaveParent.LuauPolyfill)

local function saveAvatar(humanoidDescription: HumanoidDescription, humanoidRigType: Enum.HumanoidRigType, saveDict, gearAssetId: number?)
    return Promise.new(function(callback, callback2)
        local bool1 = AvatarEditorService:NoPromptSaveAvatar(humanoidDescription, humanoidRigType, saveDict, gearAssetId)

        while not bool1 do
            AvatarEditorService.PromptSaveAvatarCompleted:Wait()
            bool1 = AvatarEditorService:NoPromptSaveAvatar(humanoidDescription, humanoidRigType, saveDict, gearAssetId)
        end

        local result, humanoidDescription2 = AvatarEditorService.PromptSaveAvatarCompleted:Wait()
        if result == Enum.AvatarPromptResult.Success then
            callback({ avatarPromptResult = result, humanoidDescriptionWithValidAssets = humanoidDescription2 })
            return
        end

        callback2({ avatarPromptResult = result })
    end)
end

return saveAvatar

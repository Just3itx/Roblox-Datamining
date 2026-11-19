-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:20:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarEditorService = game:GetService("AvatarEditorService")

local scriptParentParent = script.Parent.Parent
local CloseOpenPrompt = require(scriptParentParent.Actions.CloseOpenPrompt)

local PromptType = require(scriptParentParent.PromptType)

return function(arg1)
    local promptType = arg1:getState().promptInfo.promptType

    if promptType == PromptType.AllowInventoryReadAccess then
        AvatarEditorService:SetAllowInventoryReadAccess(false)
    elseif promptType == PromptType.SaveAvatar then
        AvatarEditorService:SignalSaveAvatarPermissionDenied()
    elseif promptType == PromptType.CreateOutfit or promptType == PromptType.EnterOutfitName then
        AvatarEditorService:SignalCreateOutfitPermissionDenied()
    elseif promptType == PromptType.SetFavorite then
        AvatarEditorService:SignalSetFavoritePermissionDenied()
    elseif promptType == PromptType.DeleteOutfit then
        AvatarEditorService:SignalDeleteOutfitPermissionDenied()
    elseif promptType == PromptType.RenameOutfit then
        AvatarEditorService:SignalRenameOutfitPermissionDenied()
    elseif promptType == PromptType.UpdateOutfit then
        AvatarEditorService:SignalUpdateOutfitPermissionDenied()
    elseif promptType == PromptType.SaveAvatarTimeout then
        AvatarEditorService:SignalSaveAvatarPermissionDenied()
    elseif promptType ~= nil then
        error("CloseOpenPrompt for unhandled prompt type " .. tostring(promptType))
    end

    arg1:dispatch(CloseOpenPrompt())
end

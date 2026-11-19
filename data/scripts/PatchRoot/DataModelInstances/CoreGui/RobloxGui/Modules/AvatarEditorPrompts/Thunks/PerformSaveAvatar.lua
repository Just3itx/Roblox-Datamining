-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:21:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarEditorService = game:GetService("AvatarEditorService")

local scriptParentParent = script.Parent.Parent
local CloseOpenPrompt = require(scriptParentParent.Actions.CloseOpenPrompt)

local GetConformedHumanoidDescription = require(scriptParentParent.GetConformedHumanoidDescription)

return function(arg1)
    local addedAssets = arg1:getState().analyticsInfo.addedAssets or {}
    local removedAssets = arg1:getState().analyticsInfo.removedAssets or {}

    local humanoidDescription = arg1:getState().promptInfo.humanoidDescription

    GetConformedHumanoidDescription(humanoidDescription, false):andThen(function(humanoidDescription2: HumanoidDescription)
        AvatarEditorService:PerformSaveAvatarWithDescription(humanoidDescription2, addedAssets, removedAssets)
    end, function(_)
        AvatarEditorService:SignalSaveAvatarFailed()
    end)

    arg1:dispatch(CloseOpenPrompt())
end

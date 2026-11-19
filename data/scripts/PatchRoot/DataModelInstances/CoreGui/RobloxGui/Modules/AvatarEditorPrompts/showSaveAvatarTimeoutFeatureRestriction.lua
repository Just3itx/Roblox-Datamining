-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:20:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarEditorService = game:GetService("AvatarEditorService")
local CorePackages = game:GetService("CorePackages")

local showAvatarChangeFeatureRestriction = require(CorePackages.Workspace.Packages.AvatarExperienceCommon).Utils.showAvatarChangeFeatureRestriction

local function showSaveAvatarTimeoutFeatureRestriction(arg1)
    (arg1 or AvatarEditorService):SignalSaveAvatarPermissionDenied()
    showAvatarChangeFeatureRestriction()
end

return showSaveAvatarTimeoutFeatureRestriction

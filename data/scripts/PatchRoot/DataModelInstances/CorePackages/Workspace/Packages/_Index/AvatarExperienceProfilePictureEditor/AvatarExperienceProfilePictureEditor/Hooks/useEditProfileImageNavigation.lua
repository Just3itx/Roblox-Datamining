-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:41:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceProfilePictureEditor = script:FindFirstAncestor("AvatarExperienceProfilePictureEditor")
local AvatarExperienceProfilePictureEditorParent = AvatarExperienceProfilePictureEditor.Parent

local React = require(AvatarExperienceProfilePictureEditorParent.React)
local FFlagEditProfileFramesEnabled = require(AvatarExperienceProfilePictureEditorParent.SharedFlags).FFlagEditProfileFramesEnabled

local Enums = require(AvatarExperienceProfilePictureEditor.Common.Enums)
local editProfileImageHelpers = require(AvatarExperienceProfilePictureEditor.Utils.editProfileImageHelpers)

local function useEditProfileImageNavigation(tbl1)
    local activeView, var2 = React.useState((editProfileImageHelpers.getInitialActiveView(tbl1.mode)))
    local titleBackAvailable = editProfileImageHelpers.hasOnTitleBack(activeView, tbl1.mode)
    local bool1 = FFlagEditProfileFramesEnabled

    if bool1 then
        if activeView == "frames" then
            bool1 = tbl1.mode == Enums.EditProfileImageMode.FramesOnly
        else
            bool1 = false
        end
    end

    local onExpandEmotes = React.useCallback(function()
        var2("emotes")
    end, {})
    local onExpandFrames = React.useCallback(function()
        var2("frames")
    end, {})
    local var6 = React.useCallback(function()
        var2("combined")
    end, {})

    local tbl2 = {
        activeView = activeView,
        isFramesOnlyEntry = bool1,
        titleBackAvailable = titleBackAvailable,
        onExpandEmotes = onExpandEmotes,
        onExpandFrames = onExpandFrames,
        onReturnToCombined = var6,
        onTitleBack = 0
    }

    if not titleBackAvailable then
        var6 = nil
    end

    tbl2.onTitleBack = var6
    return tbl2
end

return useEditProfileImageNavigation

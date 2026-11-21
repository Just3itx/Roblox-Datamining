-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:31:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceProfilePictureEditor = script:FindFirstAncestor("AvatarExperienceProfilePictureEditor")
local AvatarExperienceProfilePictureEditorParent = AvatarExperienceProfilePictureEditor.Parent

local HttpRequest = require(AvatarExperienceProfilePictureEditorParent.HttpRequest)

local _Enums = require(AvatarExperienceProfilePictureEditor.Common.Enums)

return HttpRequest.config({
    requestFunction = function(str1: string, arg1, arg2)
        return HttpRequest.requestFunctions.RequestInternal(str1, arg1, arg2)
    end
})

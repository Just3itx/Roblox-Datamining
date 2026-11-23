-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:31:05Z
-- Luau bytecode version: 14 | Luau type version: 3
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent
local SharedFlags = require(BuildExperienceParent.SharedFlags)

return require(script.Parent.FFlagBuildExperienceChatCaptureGalleryEmptyEducation)
    and SharedFlags.FFlagBuildExperienceInGameShell
    and SharedFlags.FFlagBuildExperienceInGameCaptureToChat

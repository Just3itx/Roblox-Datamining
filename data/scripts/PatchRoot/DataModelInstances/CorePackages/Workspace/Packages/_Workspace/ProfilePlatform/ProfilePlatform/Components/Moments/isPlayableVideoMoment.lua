-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:10:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatformParent = script:FindFirstAncestor("ProfilePlatform").Parent

local _MomentsStoreTypes = require(ProfilePlatformParent.DataHydration.MomentsStoreTypes)

local function isPlayableVideoMoment(arg1): boolean
    return not (arg1.metadata.isMomentScene == true) and arg1.metadata.captureType == Enum.CaptureType.Video
end

return isPlayableVideoMoment

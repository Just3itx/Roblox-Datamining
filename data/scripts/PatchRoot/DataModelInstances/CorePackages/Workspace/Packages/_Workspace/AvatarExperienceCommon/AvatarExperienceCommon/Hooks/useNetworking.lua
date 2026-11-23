-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:31:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommonParent = script:FindFirstAncestor("AvatarExperienceCommon").Parent

local useRoactService = require(AvatarExperienceCommonParent.RobloxAppHooks).useRoactService
local RoactNetworking = require(AvatarExperienceCommonParent.RoactServiceTags).RoactNetworking

local function useNetworking()
    return useRoactService(RoactNetworking)
end

return useNetworking

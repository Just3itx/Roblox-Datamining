-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T06:01:07Z
-- Luau bytecode version: 14 | Luau type version: 3
local ProfilePlatformParent = script:FindFirstAncestor("ProfilePlatform").Parent

return require(ProfilePlatformParent.GenericChallenges).Middleware.ChallengeRequestWrapper(
    require(ProfilePlatformParent.DataHydration).Friends.httpRequest
)

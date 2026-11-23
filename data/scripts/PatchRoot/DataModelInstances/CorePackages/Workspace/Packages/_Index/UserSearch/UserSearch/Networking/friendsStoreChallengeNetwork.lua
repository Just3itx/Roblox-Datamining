-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T03:10:50Z
-- Luau bytecode version: 14 | Luau type version: 3
local UserSearchParent = script:FindFirstAncestor("UserSearch").Parent

return require(UserSearchParent.GenericChallenges).Middleware.ChallengeRequestWrapper(
    require(UserSearchParent.DataHydration).Friends.httpRequest
)

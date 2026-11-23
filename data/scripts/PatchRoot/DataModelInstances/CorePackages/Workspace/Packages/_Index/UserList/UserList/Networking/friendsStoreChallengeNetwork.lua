-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T02:21:01Z
-- Luau bytecode version: 14 | Luau type version: 3
local UserListParent = script:FindFirstAncestor("UserList").Parent

return require(UserListParent.GenericChallenges).Middleware.ChallengeRequestWrapper(
    require(UserListParent.DataHydration).Friends.httpRequest
)

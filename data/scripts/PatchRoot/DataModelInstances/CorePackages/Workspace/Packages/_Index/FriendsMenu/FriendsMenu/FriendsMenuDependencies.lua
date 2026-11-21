-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T16:31:05Z
-- Luau bytecode version: 14 | Luau type version: 3
local scriptParentParent = script.Parent.Parent

local FFlagLuaAppDefaultHttpRetry = require(scriptParentParent.SharedFlags).FFlagLuaAppDefaultHttpRetry
local LuaSocialLibrariesDeps = require(scriptParentParent.LuaSocialLibrariesDeps)
local HttpRequest = require(scriptParentParent.HttpRequest)

return {
    networkImpl = HttpRequest.config({
        requestFunction = HttpRequest.requestFunctions.HttpRbxApi,
        maxRetryCount = if FFlagLuaAppDefaultHttpRetry then game:DefineFastInt("FriendsMenuHttpRetryCount", 4) else nil
    }),
    sortFriendsByCorrectedPresenceAndRank = LuaSocialLibrariesDeps.SocialLibraries.config({}).User.sortFriendsByCorrectedPresenceAndRank
}

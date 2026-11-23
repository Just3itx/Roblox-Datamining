-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T03:10:53Z
-- Luau bytecode version: 14 | Luau type version: 3
local UserSearch = script:FindFirstAncestor("UserSearch")
local UserSearchParent = UserSearch.Parent
local LuaSocialLibrariesDeps = require(UserSearchParent.LuaSocialLibrariesDeps)
local RODUX_KEY = require(UserSearch.Common.Constants).RODUX_KEY
local RoduxNetworking = LuaSocialLibrariesDeps.RoduxNetworking

local myHttpRequest = require(script.Parent.myHttpRequest)
local ChallengeRequestWrapper = require(UserSearchParent.GenericChallenges).Middleware.ChallengeRequestWrapper
local bool1 = game:DefineFastFlag("EnableUserSearchChallengeInterceptor", false)

local config = RoduxNetworking.config
local tbl1 = {
    keyPath = RODUX_KEY .. ".NetworkStatus",
    networkImpl = 0
}

if bool1 then
    myHttpRequest = ChallengeRequestWrapper(myHttpRequest)
end

tbl1.networkImpl = myHttpRequest
return (config(tbl1))

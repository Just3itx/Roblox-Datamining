-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T23:31:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local LegacyFriendsRodux = script:FindFirstAncestor("LegacyFriendsRodux")
local LegacyFriendsRoduxParent = LegacyFriendsRodux.Parent

local Immutable = require(LegacyFriendsRoduxParent.AppCommonLib).Immutable
local RetrievalStatus = require(LegacyFriendsRoduxParent.Http).Enum.RetrievalStatus

local FetchUserFriendsStarted = require(LegacyFriendsRodux.Actions).FetchUserFriendsStarted
local FetchUserFriendsFailed = require(LegacyFriendsRodux.Actions).FetchUserFriendsFailed
local FetchUserFriendsCompleted = require(LegacyFriendsRodux.Actions).FetchUserFriendsCompleted

local function setFieldPerUser(arg1, str1: string, userId, arg2)
    local var1 = arg1[str1] or {}
    return Immutable.JoinDictionaries(arg1, { [str1] = Immutable.JoinDictionaries(var1, { [userId] = arg2 }) })
end

local function setRetrievalStatus(arg1, userId, arg2) -- Luacid: Inlined by compiler; 3 call sites recovered
    return setFieldPerUser(arg1, "retrievalStatus", userId, arg2)
end

local function setRetrievalFailureResponse(arg1, userId, response) -- Luacid: Inlined by compiler; 1 call site recovered
    return setFieldPerUser(arg1, "retrievalFailureResponse", userId, response)
end

return function(arg1, arg2)
    arg1 = arg1 or {
        retrievalStatus = {},
        retrievalFailureResponse = {}
    }

    if arg2.type == FetchUserFriendsStarted.name then
        return (setRetrievalStatus(arg1, arg2.userId, RetrievalStatus.Fetching))
    end

    if arg2.type == FetchUserFriendsFailed.name then
        return (setRetrievalFailureResponse(setRetrievalStatus(arg1, arg2.userId, RetrievalStatus.Failed), arg2.userId, arg2.response))
    end

    if arg2.type == FetchUserFriendsCompleted.name then
        arg1 = setRetrievalStatus(arg1, arg2.userId, RetrievalStatus.Done)
    end

    return arg1
end

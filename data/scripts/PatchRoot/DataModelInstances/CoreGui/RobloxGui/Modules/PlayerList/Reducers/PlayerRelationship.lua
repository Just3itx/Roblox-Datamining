-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:01:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local Rodux = require(CorePackages.Packages.Rodux)
local Cryo = require(CorePackages.Packages.Cryo)

local Actions = script.Parent.Parent.Actions
local AddPlayer = require(Actions.AddPlayer)
local RemovePlayer = require(Actions.RemovePlayer)
local SetPlayerIsBlocked = require(Actions.SetPlayerIsBlocked)
local SetPlayerFollowRelationship = require(Actions.SetPlayerFollowRelationship)
local SetPlayerFriendStatus = require(Actions.SetPlayerFriendStatus)
local SetPlayerIsFollowing = require(Actions.SetPlayerIsFollowing)

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[AddPlayer.name] = function(arg1, arg2)
    return Cryo.Dictionary.join(arg1, {
        [arg2.userId] = {
            isBlocked = false,
            friendStatus = Enum.FriendStatus.Unknown,
            isFollowing = false,
            isFollower = false
        }
    })
end

tbl1[RemovePlayer.name] = function(arg1, arg2)
    return Cryo.Dictionary.join(arg1, { [arg2.userId] = Cryo.None })
end

tbl1[SetPlayerIsBlocked.name] = function(arg1, arg2)
    return Cryo.Dictionary.join(arg1, {
        [arg2.userId] = {
            isBlocked = arg2.isBlocked,
            friendStatus = arg1[arg2.userId].friendStatus,
            isFollowing = arg1[arg2.userId].isFollowing,
            isFollower = arg1[arg2.userId].isFollower
        }
    })
end

tbl1[SetPlayerFollowRelationship.name] = function(arg1, arg2)
    return Cryo.Dictionary.join(arg1, {
        [arg2.userId] = {
            isBlocked = arg1[arg2.userId].isBlocked,
            friendStatus = arg1[arg2.userId].friendStatus,
            isFollowing = arg2.isFollowing,
            isFollower = arg2.isFollower
        }
    })
end

tbl1[SetPlayerIsFollowing.name] = function(arg1, arg2)
    return Cryo.Dictionary.join(arg1, {
        [arg2.userId] = {
            isBlocked = arg1[arg2.userId].isBlocked,
            friendStatus = arg1[arg2.userId].friendStatus,
            isFollowing = arg2.isFollowing,
            isFollower = arg1[arg2.userId].isFollower
        }
    })
end

tbl1[SetPlayerFriendStatus.name] = function(arg1, arg2)
    return Cryo.Dictionary.join(arg1, {
        [arg2.userId] = {
            isBlocked = arg1[arg2.userId].isBlocked,
            friendStatus = arg2.friendStatus,
            isFollowing = arg1[arg2.userId].isFollowing,
            isFollower = arg1[arg2.userId].isFollower
        }
    })
end

return (createReducer({}, tbl1))

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:01:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local Rodux = require(CorePackages.Packages.Rodux)
local Cryo = require(CorePackages.Packages.Cryo)

local Actions = script.Parent.Parent.Actions
local AddPlayer = require(Actions.AddPlayer)
local RemovePlayer = require(Actions.RemovePlayer)
local SetPlayerSpecialGroupIcon = require(Actions.SetPlayerSpecialGroupIcon)
local SetPlayerIsCreator = require(Actions.SetPlayerIsCreator)
local SetPlayerAvatarIcon = require(Actions.SetPlayerAvatarIcon)

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[AddPlayer.name] = function(arg1, arg2)
    return Cryo.Dictionary.join(arg1, {
        [arg2.userId] = {
            isPlaceOwner = game.CreatorType == Enum.CreatorType.User and arg2.userId == game.CreatorId,
            avatarIcon = nil,
            specialGroupIcon = nil
        }
    })
end

tbl1[RemovePlayer.name] = function(arg1, arg2)
    return Cryo.Dictionary.join(arg1, { [arg2.userId] = Cryo.None })
end

tbl1[SetPlayerAvatarIcon.name] = function(arg1, arg2)
    return Cryo.Dictionary.join(arg1, {
        [arg2.userId] = {
            isPlaceOwner = arg1[arg2.userId].isPlaceOwner,
            avatarIcon = arg2.avatarIcon,
            specialGroupIcon = arg1[arg2.userId].specialGroupIcon
        }
    })
end

tbl1[SetPlayerIsCreator.name] = function(arg1, arg2)
    return Cryo.Dictionary.join(arg1, {
        [arg2.userId] = {
            isPlaceOwner = arg2.isCreator,
            avatarIcon = arg1[arg2.userId].avatarIcon,
            specialGroupIcon = arg1[arg2.userId].specialGroupIcon
        }
    })
end

tbl1[SetPlayerSpecialGroupIcon.name] = function(arg1, arg2)
    return Cryo.Dictionary.join(arg1, {
        [arg2.userId] = {
            isPlaceOwner = arg1[arg2.userId].isPlaceOwner,
            avatarIcon = arg1[arg2.userId].avatarIcon,
            specialGroupIcon = arg2.specialGroupIcon
        }
    })
end

return (createReducer({}, tbl1))

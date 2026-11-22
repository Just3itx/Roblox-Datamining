-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T18:51:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialExperienceJoin = script:FindFirstAncestor("SocialExperienceJoin")
local SocialExperienceJoinParent = SocialExperienceJoin.Parent
local Rodux = require(SocialExperienceJoinParent.Rodux)
local myRoduxNetworking = require(SocialExperienceJoin.Networking.myRoduxNetworking)
local Games = require(SocialExperienceJoin.Rodux.Games)
local Presence = require(SocialExperienceJoin.Rodux.Presence)

local FFlagSocialExperienceJoinPresenceStoreMigration = require(SocialExperienceJoin.Flags.FFlagSocialExperienceJoinPresenceStoreMigration)

return function()
    return Rodux.combineReducers({
        NetworkStatus = myRoduxNetworking.installReducer(),
        Games = Games.installReducer(),
        Presence = if FFlagSocialExperienceJoinPresenceStoreMigration then nil else Presence.installReducer()
    })
end

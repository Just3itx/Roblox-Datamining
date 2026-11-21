-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T20:51:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GamePlayButtonParent = script:FindFirstAncestor("GamePlayButton").Parent
local PlayabilityStatusEnum = require(GamePlayButtonParent.DiscoveryTypes).PlayabilityStatusEnum

local FFlagLuaAppPlayButtonAmpAgeCheckFlow = require(GamePlayButtonParent.SharedFlags).FFlagLuaAppPlayButtonAmpAgeCheckFlow

local Type = {
    AgeVerification = "AgeVerification",
    UpdatePlaytestSettings = "UpdatePlaytestSettings",
    TrustedFriends = "TrustedFriends"
}

return {
    Type = Type,
    getType = function(str1: string?)
        if str1 == PlayabilityStatusEnum.ContextualPlayabilityUnverifiedSeventeenPlusUser
            or FFlagLuaAppPlayButtonAmpAgeCheckFlow and str1 == PlayabilityStatusEnum.ContextualPlayabilityAgeCheckRequired
        then
            return Type.AgeVerification
        end

        if str1 == PlayabilityStatusEnum.ContextualPlayabilityPlaytestDisabled
            or str1 == PlayabilityStatusEnum.ContextualPlayabilityRequireParentApproval
        then
            return Type.UpdatePlaytestSettings
        end

        if str1 == PlayabilityStatusEnum.ContextualPlayabilityTrustedFriendRequired then
            return Type.TrustedFriends
        end

        return nil
    end
}

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T15:20:53Z
-- Luau bytecode version: 14 | Luau type version: 3
return {
    getMutualFriendsText = require(script.getMutualFriendsText),
    getRecommendationContextualInfoDisplay = require(script.getRecommendationContextualInfoDisplay),
    getRecommendationContextualInfoType = require(script.getRecommendationContextualInfoType),
    convertLuaAppUserToSocialUser = require(script.convertLuaAppUserToSocialUser),
    convertUserPresenceTypeToString = require(script.convertUserPresenceTypeToString),
    convertToFoundationPresenceEnum = require(script.convertToFoundationPresenceEnum),
    InputUtilities = require(script.InputUtilities),
    isPresenceInGame = require(script.isPresenceInGame),
    simpleUrlDecode = require(script.simpleUrlDecode),
    buildApiSiteUrl = require(script.buildApiSiteUrl),
    userIdExists = require(script.userIdExists),
    hydrateEmptyIdsHelper = require(script.hydrateEmptyIdsHelper),
    ImpressionCacheImpl = require(script.ImpressionCacheImpl),
    getDeepValue = require(script.getDeepValue)
}

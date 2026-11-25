-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T15:21:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialCommon = script:FindFirstAncestor("SocialCommon")
local RecommendationContextType = require(SocialCommon.Enums.RecommendationContextType)
local ContextualInfoTypes = require(SocialCommon.Enums.ContextualInfoTypes)
local SocialCommonParent = SocialCommon.Parent
local FFlagShowClassmatesOnPYMK = require(SocialCommonParent.SharedFlags.FFlagShowClassmatesOnPYMK)

local function getRecommendationContextualInfoType(arg1)
    local contextType = arg1.contextType
    local var1 = contextType and contextType.rawValue()

    if var1 == RecommendationContextType.MutualFriends.rawValue() then
        return ContextualInfoTypes.MutualFriends
    end

    if var1 == RecommendationContextType.Frequents.rawValue() then
        return ContextualInfoTypes.Frequents
    end

    if var1 == RecommendationContextType.Contacts.rawValue() then
        return ContextualInfoTypes.Contacts
    end

    if FFlagShowClassmatesOnPYMK and var1 == RecommendationContextType.Classmates.rawValue() then
        return ContextualInfoTypes.Classmates
    end

    return nil
end

return getRecommendationContextualInfoType

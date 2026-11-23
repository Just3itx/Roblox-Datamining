-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T21:11:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local _ExperienceGuidelines = require(BuildExperienceParent.DataHydration.ExperienceGuidelines)
local _UniverseActivation = require(BuildExperienceParent.DataHydration.UniverseActivation)
local UniverseConfiguration = require(BuildExperienceParent.DataHydration.UniverseConfiguration)
local LocalizationStrings = require(BuildExperience.LocalizationStrings)

local PrivacyType = UniverseConfiguration.PrivacyType

local GAME_CONFIGURATION_AUDIENCE_PUBLIC = LocalizationStrings.GAME_CONFIGURATION_AUDIENCE_PUBLIC
local GAME_CONFIGURATION_AUDIENCE_FRIENDS_ONLY = LocalizationStrings.GAME_CONFIGURATION_AUDIENCE_FRIENDS_ONLY
local GAME_CONFIGURATION_AUDIENCE_PRIVATE = LocalizationStrings.GAME_CONFIGURATION_AUDIENCE_PRIVATE
local GAME_CONFIGURATION_AUDIENCE_UNKNOWN = LocalizationStrings.GAME_CONFIGURATION_AUDIENCE_UNKNOWN

local AudienceTextByPrivacyType = {
    [PrivacyType.Public] = GAME_CONFIGURATION_AUDIENCE_PUBLIC,
    [PrivacyType.FriendsOnly] = GAME_CONFIGURATION_AUDIENCE_FRIENDS_ONLY,
    [PrivacyType.Private] = GAME_CONFIGURATION_AUDIENCE_PRIVATE
}
local tbl2 = {
    [PrivacyType.Public] = PrivacyType.Public,
    [PrivacyType.FriendsOnly] = PrivacyType.FriendsOnly,
    [PrivacyType.Private] = PrivacyType.Private
}

local function getAudience(tbl3) -- Luacid: Inlined by compiler; 1 call site recovered
    if tbl3 == nil then
        return nil
    end

    if tbl3.audiences ~= nil then
        return UniverseConfiguration.getPrivacyTypeForAudiences(tbl3.audiences)
    end

    local privacyType = tbl3.privacyType
    return if privacyType == nil then nil else tbl2[privacyType]
end

local function getDescriptorDisplayName(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    local experienceDescriptorUsages = arg1 and arg1.experienceDescriptorUsages
    local items = experienceDescriptorUsages and experienceDescriptorUsages.items
    local item = items and items[1]
    local descriptorDisplayName = item and item.descriptorDisplayName
    return if descriptorDisplayName == nil or descriptorDisplayName == "" then nil else descriptorDisplayName
end

local function getContentRatingText(arg1)
    local ageRecommendationDetails = arg1 and arg1.ageRecommendationDetails
    local ageRecommendationSummary = ageRecommendationDetails and ageRecommendationDetails.ageRecommendationSummary
    local ageRecommendation = ageRecommendationSummary and ageRecommendationSummary.ageRecommendation
    if ageRecommendation == nil then
        return nil
    end
    local displayName = ageRecommendation.displayName
    if displayName == nil or displayName == "" then
        displayName = ageRecommendation.contentMaturity
    end
    if displayName == nil or displayName == "" then
        return displayName
    end

    local descriptorDisplayName = getDescriptorDisplayName(ageRecommendationDetails)

    if descriptorDisplayName ~= nil then
        return `{displayName} - {descriptorDisplayName}`
    end

    return displayName
end

local function getProvisionalRatingText(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    local ageRecommendationDetails = arg1 and arg1.ageRecommendationDetails
    local ageRecommendationSummary = ageRecommendationDetails and ageRecommendationDetails.ageRecommendationSummary
    local ageRecommendation = ageRecommendationSummary and ageRecommendationSummary.ageRecommendation
    local displayName = ageRecommendation and ageRecommendation.displayName
    return if displayName == nil or displayName == "" then nil else displayName
end

local function getProvisionalRatingDescriptor(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    local ageRecommendationDetails = arg1 and arg1.ageRecommendationDetails
    local experienceDescriptorUsages = ageRecommendationDetails and ageRecommendationDetails.experienceDescriptorUsages
    local var1 = experienceDescriptorUsages and experienceDescriptorUsages[1]
    local descriptorDisplayName = var1 and var1.descriptorDisplayName
    return if descriptorDisplayName == nil or descriptorDisplayName == "" then nil else descriptorDisplayName
end

return {
    AudienceTextByPrivacyType = AudienceTextByPrivacyType,
    UNKNOWN_AUDIENCE_TEXT = GAME_CONFIGURATION_AUDIENCE_UNKNOWN,
    getAudience = getAudience,
    getAudienceText = function(tbl3)
        if tbl3 == nil then
            return nil
        end

        local audience = getAudience(tbl3)
        return if audience == nil then nil else AudienceTextByPrivacyType[audience]
    end,
    getContentRatingText = getContentRatingText,
    getContentMaturityText = function(arg1, arg2, bool1: boolean)
        if bool1 then
            local provisionalRatingText = getProvisionalRatingText(arg2)

            if provisionalRatingText ~= nil then
                local provisionalRatingDescriptor = getProvisionalRatingDescriptor(arg2)

                if provisionalRatingDescriptor ~= nil then
                    return `{provisionalRatingText} - {provisionalRatingDescriptor}`
                end

                return provisionalRatingText
            end
        end

        return (getContentRatingText(arg1))
    end,
    getProvisionalRatingText = getProvisionalRatingText,
    getProvisionalRatingDescriptor = getProvisionalRatingDescriptor
}

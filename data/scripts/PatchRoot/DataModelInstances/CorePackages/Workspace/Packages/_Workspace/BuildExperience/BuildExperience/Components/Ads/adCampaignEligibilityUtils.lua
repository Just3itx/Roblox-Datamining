-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:01:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local _AdCampaignEligibility = require(BuildExperienceParent.DataHydration.AdCampaignEligibility)
local _CreatorAgentChat = require(BuildExperienceParent.DataHydration.CreatorAgentChat)
local FFlagEnablePaidAds = require(BuildExperience.Flags.FFlagEnablePaidAds)

local function isUsableOffer(arg1): boolean
    if typeof(arg1) == "table"
        and (arg1.campaignOption == "feedback" or arg1.campaignOption == "plays")
        and (arg1.fundingType == "free" or arg1.fundingType == "paid")
        and typeof(arg1.durationDays) == "number"
        and arg1.durationDays % 1 == 0
        and arg1.durationDays > 0
        and typeof(arg1.priceRobux) == "number"
        and arg1.priceRobux % 1 == 0
        and arg1.priceRobux >= 0
    then
        return arg1.fundingType == "free" or arg1.priceRobux > 0
    end

    return false
end

local function getSelectableOffers(arg1)
    if arg1 == nil or typeof(arg1.offers) ~= "table" then
        return nil
    end

    local var1 = nil
    local var2 = nil
    for _, offer in arg1.offers do
        local bool1 = isUsableOffer(offer)

        if bool1 then
            if offer.fundingType == "paid" then
                bool1 = true
            elseif offer.fundingType == "free" then
                bool1 = arg1.freeCreditsRemaining > 0
            else
                bool1 = false
            end
        end

        if bool1 and offer.campaignOption == "feedback" then
            var1 = offer
        elseif bool1 and offer.campaignOption == "plays" then
            var2 = offer
        end
    end

    return if var1 == nil and var2 == nil then nil else { feedback = var1, plays = var2 }
end

local function isEligibleForFreePromotion(arg1)
    if arg1 == nil or arg1.userEligible ~= true or arg1.universeEligible ~= true then
        return false
    end
    if not FFlagEnablePaidAds then
        return arg1.cardType == "promote_free"
    end

    if typeof(arg1.offers) ~= "table" then
        return false
    end
    for _, offer in arg1.offers do
        if isUsableOffer(offer) and offer.fundingType == "free" then
            return true
        end
    end
    return false
end

local function freeCreditsRemaining(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    return if arg1 == nil then 0 else arg1.freeCreditsRemaining
end

local function hasFreeCredit(arg1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return freeCreditsRemaining(arg1) > 0
end

return {
    getDefaultOffer = function(arg1)
        if arg1.feedback == nil or arg1.feedback.fundingType ~= "free" then
            if arg1.plays == nil or arg1.plays.fundingType ~= "free" then
                return arg1.feedback or arg1.plays
            end

            return arg1.plays
        end

        return arg1.feedback
    end,
    isEligibleForFreePromotion = isEligibleForFreePromotion,
    freeCreditsRemaining = freeCreditsRemaining,
    hasFreeCredit = hasFreeCredit,
    hasUsableOffer = function(arg1): boolean
        if FFlagEnablePaidAds then
            return getSelectableOffers(arg1) ~= nil
        end

        local offer = if arg1 == nil then nil else arg1.offer
        return not (offer == nil) and offer.durationDays > 0
    end,
    getSelectableOffers = getSelectableOffers,
    canCreateCampaign = function(arg1)
        if arg1 == nil or arg1.userEligible ~= true or arg1.universeEligible ~= true then
            return false
        end
        if FFlagEnablePaidAds then
            return getSelectableOffers(arg1) ~= nil
        end

        local bool1 = isEligibleForFreePromotion(arg1) and hasFreeCredit(arg1)

        if bool1 then
            if FFlagEnablePaidAds then
                return getSelectableOffers(arg1) ~= nil
            end

            local offer = if arg1 == nil then nil else arg1.offer

            if offer == nil then
                bool1 = false
            else
                bool1 = offer.durationDays > 0
            end
        end

        return bool1
    end,
    campaignSheetTerms = function(arg1, runStartMs: number)
        local offer = if arg1 == nil then nil else arg1.offer
        return {
            runStartMs = runStartMs,
            durationDays = if offer == nil then nil else offer.durationDays,
            estimatedPriceRobux = if offer == nil then nil else offer.displayAmountRobux,
            campaignOffers = if FFlagEnablePaidAds then getSelectableOffers(arg1) else nil
        }
    end
}

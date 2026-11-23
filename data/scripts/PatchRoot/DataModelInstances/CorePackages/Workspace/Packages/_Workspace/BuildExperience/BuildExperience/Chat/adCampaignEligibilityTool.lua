-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T18:51:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local HttpService = game:GetService("HttpService")

local CreatorAgentChat = require(BuildExperienceParent.DataHydration.CreatorAgentChat)

local adCampaignEligibilityUtils = require(BuildExperience.Components.Ads.adCampaignEligibilityUtils)

return {
    isCompletedEligibilityToolCall = function(arg1): boolean
        return not (arg1 == nil
            or arg1.title ~= "check_ad_campaign_eligibility"
            or arg1.status ~= "completed"
            or type(arg1.toolCallId) ~= "string")
            and arg1.toolCallId ~= ""
    end,
    decodeCompletedEligibility = function(arg1)
        local bool1 = not (arg1 == nil
            or arg1.title ~= "check_ad_campaign_eligibility"
            or arg1.status ~= "completed"
            or type(arg1.toolCallId) ~= "string")
            and arg1.toolCallId ~= ""

        if not bool1 or arg1.content == nil then
            return nil
        end
        for _, value in arg1.content do
            local content = value.content
            if value.type ~= "content" or content == nil or content.type ~= "text" or type(content.text) ~= "string" then
                continue
            end

            local success, result = pcall(HttpService.JSONDecode, HttpService, content.text)
            if not success then
                continue
            end

            local var1 = CreatorAgentChat.decodeAdCampaignEligibilityResult(result)
            if var1 ~= nil then
                return var1
            end
        end

        return nil
    end,
    getCardOffers = function(arg1)
        if arg1 == nil or not arg1.userEligible or not arg1.universeEligible or arg1.cardType == "none" then
            return nil
        end
        return adCampaignEligibilityUtils.getSelectableOffers(arg1)
    end
}

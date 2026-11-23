-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:50:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local HttpService = game:GetService("HttpService")

local MomentsTypes = require(AppChatParent.MomentsTypes)
local _ShareLinksNetworking = require(AppChatParent.ShareLinksNetworking)
local ShareLinkClassification = require(script.Parent.ShareLinkClassification)

local FFlagAppChatPlusReferralAssetCard = require(AppChat.Flags.FFlagAppChatPlusReferralAssetCard)
local ShareLinkTargetIdType = MomentsTypes.Enums.ShareLinkTargetIdType

local function getTargetIdType(customData: string) -- Luacid: Inlined by compiler; 1 call site recovered
    if customData == "" then
        return nil
    end

    local success, result = pcall(HttpService.JSONDecode, HttpService, customData)
    return if success and type(result) == "table" and result.targetIdType == ShareLinkTargetIdType.FeedItemId then ShareLinkTargetIdType.FeedItemId else nil
end

local function classifyShareLinkV2(arg1)
    if arg1.status ~= "Valid" then
        return {
            type = ShareLinkClassification.Invalid
        }
    end

    if arg1.linkType == "Moments" then
        return {
            type = ShareLinkClassification.Moment,
            momentId = arg1.targetId,
            targetIdType = getTargetIdType(arg1.customData)
        }
    end

    if FFlagAppChatPlusReferralAssetCard and arg1.linkType == "Referral" then
        return {
            type = ShareLinkClassification.PlusReferral,
            referrerId = arg1.targetId
        }
    end

    return {
        type = ShareLinkClassification.Unhandled
    }
end

return classifyShareLinkV2

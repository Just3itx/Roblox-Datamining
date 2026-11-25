-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:51:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")
local PurchasePromptParent = PurchasePrompt.Parent
local SharedFlags = require(PurchasePromptParent.SharedFlags)
local UnifiedPurchaseModalTypeEnum = require(PurchasePromptParent.IAPExperience).Enums.UnifiedPurchaseModalTypeEnum
local isMultiItemPurchase = require(PurchasePrompt.Utils.isMultiItemPurchase)
local RequestType = require(PurchasePrompt.Enums.RequestType)

local FFlagEnableUnifiedPurchaseFlowForDevSubs = require(PurchasePrompt.Parent.SharedFlags).FFlagEnableUnifiedPurchaseFlowForDevSubs
local FFlagAXMISWithBlackbird = SharedFlags.FFlagAXMISWithBlackbird
local FFlagLuaAppsEnablePromptVIPServerPurchase = SharedFlags.FFlagLuaAppsEnablePromptVIPServerPurchase

local function getUnifiedPurchaseModalType(arg1)
    if arg1 == RequestType.Experience then
        return UnifiedPurchaseModalTypeEnum.Experience
    end

    if FFlagAXMISWithBlackbird and arg1 == RequestType.RobuxUpsell then
        return UnifiedPurchaseModalTypeEnum.MultiItem
    end

    if isMultiItemPurchase(arg1) then
        return UnifiedPurchaseModalTypeEnum.MultiItem
    end

    if FFlagEnableUnifiedPurchaseFlowForDevSubs and arg1 == RequestType.DeveloperSubscription then
        return UnifiedPurchaseModalTypeEnum.DeveloperSubscription
    end

    if FFlagLuaAppsEnablePromptVIPServerPurchase and arg1 == RequestType.VIPServer then
        return UnifiedPurchaseModalTypeEnum.VIPServer
    end

    return UnifiedPurchaseModalTypeEnum.SingleItem
end

return getUnifiedPurchaseModalType

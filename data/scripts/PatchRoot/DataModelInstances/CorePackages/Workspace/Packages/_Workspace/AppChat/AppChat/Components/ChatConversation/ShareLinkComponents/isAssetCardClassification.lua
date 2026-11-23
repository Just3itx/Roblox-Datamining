-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:40:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")

local ShareLinkClassification = require(AppChat.Components.ChatConversation.Utils.RobloxUrlUtils.ShareLinkClassification)

local FFlagAppChatPlusReferralAssetCard = require(AppChat.Flags.FFlagAppChatPlusReferralAssetCard)
local FFlagAppChatMomentAssetCard = require(AppChat.Flags.FFlagAppChatMomentAssetCard)

local function isAssetCardClassification(arg1): boolean
    return not (arg1 == nil)
        and (if FFlagAppChatPlusReferralAssetCard and arg1.type == ShareLinkClassification.PlusReferral then true else not not (FFlagAppChatMomentAssetCard and arg1.type == ShareLinkClassification.Moment))
end

return isAssetCardClassification

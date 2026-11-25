-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T16:41:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialUpsell = script:FindFirstAncestor("SocialUpsell")
local SocialUpsellParent = SocialUpsell.Parent

local Foundation = require(SocialUpsellParent.Foundation)

local _Types = require(SocialUpsell.Types)
local SocialUpsellType = require(SocialUpsell.Enum.SocialUpsellType)

local isCompactUpsellBanner = require(script.Parent.isCompactUpsellBanner)

local ShieldCheck = Foundation.Enums.IconName.ShieldCheck
local SpeechBubbleAlignCenter = Foundation.Enums.IconName.SpeechBubbleAlignCenter

local function getBannerIcon(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    if arg1.image then
        return nil
    end

    if arg1.icon then
        return arg1.icon
    end

    if arg1.type == SocialUpsellType.FacialAgeEstimation then
        if isCompactUpsellBanner(arg1) then
            return ShieldCheck
        end

        return SpeechBubbleAlignCenter
    end

    if arg1.type == SocialUpsellType.ConversationFacialAgeEstimation then
    end

    return nil
end

return function(arg1)
    arg1.icon = getBannerIcon(arg1)
    return arg1
end

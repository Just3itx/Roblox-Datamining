-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T16:41:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialUpsell = script:FindFirstAncestor("SocialUpsell")
local SocialUpsellParent = SocialUpsell.Parent

local getDeepValue = require(SocialUpsellParent.SocialCommon).Utils.getDeepValue
local createCommonSocialUpsellBannerConfig = require(script.Parent.createCommonSocialUpsellBannerConfig)

local _Types = require(SocialUpsell.Types)
local Constants = require(SocialUpsell.Constants)
local SocialUpsellType = require(SocialUpsell.Enum.SocialUpsellType)
local SharedFlags = require(SocialUpsellParent.SharedFlags)
local FFlagAgeBasedUXHomepageVerificationBannerLockIcon = SharedFlags.FFlagAgeBasedUXHomepageVerificationBannerLockIcon

local FFlagAgeBasedUXHomepageVerificationBannerGreyButton = SharedFlags.FFlagAgeBasedUXHomepageVerificationBannerGreyButton

local tbl1 = {
    OpenFaeUpsell = Constants.UPSELL_BUTTON_ACTION.Primary,
    OpenFaeViewDetails = Constants.UPSELL_BUTTON_ACTION.Secondary,
    Dismiss = Constants.UPSELL_BUTTON_ACTION.Dismiss
}

local tbl2 = {
    Fae = SocialUpsellType.FacialAgeEstimation
}

local function getButtonAction(tbl3) -- Luacid: Inlined by compiler; 1 call site recovered
    if tbl3.action and tbl3.action.type then
        return tbl1[tbl3.action.type]
    end

    return nil
end

return function(tbl3, tbl4)
    local type = tbl2[tbl3.upsellCardType] or SocialUpsellType.Unknown
    local upsellCardV2Config = tbl3.upsellCardV2Config

    local labelItems = {}
    local buttons = {}

    if upsellCardV2Config.label_items then
        for _, labelItem in upsellCardV2Config.label_items do
            if labelItem.type == "Countdown" and labelItem.metadata and labelItem.metadata.countdown_text then
                table.insert(
                    labelItems,
                    {
                        type = Constants.UPSELL_LABEL_ITEM_TYPE_COUNTDOWN,
                        text = labelItem.metadata.countdown_text
                    }
                )
            end
        end
    end
    if upsellCardV2Config.buttons then
        for _, button in upsellCardV2Config.buttons do
            local action = getButtonAction(button)

            if not action then
                continue
            end

            table.insert(buttons, {
                text = button.text,
                action = action,
                variantOverride = if FFlagAgeBasedUXHomepageVerificationBannerGreyButton and tbl4 and action == Constants.UPSELL_BUTTON_ACTION.Primary then tbl4.primaryButtonVariantOverride else nil
            })
        end
    end

    return createCommonSocialUpsellBannerConfig({
        type = type,
        title = getDeepValue(upsellCardV2Config, "header.text"),
        body = getDeepValue(upsellCardV2Config, "body.text"),
        image = getDeepValue(upsellCardV2Config, "image"),
        isDismissable = getDeepValue(upsellCardV2Config, "dismissable"),
        labelItems = labelItems,
        buttons = buttons,
        icon = if FFlagAgeBasedUXHomepageVerificationBannerLockIcon and tbl4 then tbl4.iconOverride else nil
    })
end

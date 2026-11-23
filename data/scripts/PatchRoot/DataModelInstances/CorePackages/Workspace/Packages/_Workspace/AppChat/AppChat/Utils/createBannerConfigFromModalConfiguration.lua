-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:31:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local Cryo = require(AppChatParent.Cryo)
local SocialCommon = require(AppChatParent.SocialCommon)
local SocialUpsell = require(AppChatParent.SocialUpsell)
local AppChatNetworking = require(AppChatParent.AppChatNetworking)
local SocialUpsellType = require(AppChatParent.SocialUpsell).Enums.SocialUpsellType

local getDeepValue = SocialCommon.Utils.getDeepValue
local createCommonSocialUpsellBannerConfig = SocialUpsell.Utils.createCommonSocialUpsellBannerConfig

local Constants = SocialUpsell.Constants

local ChatLandingModalVariant = AppChatNetworking.Constants.ChatLandingModalVariant
local ConversationBottomModal = AppChatNetworking.Constants.ConversationBottomModal

local tbl1 = {
    [ChatLandingModalVariant.ChatLandingAgeVerifiedCommsTimedModal] = SocialUpsellType.FacialAgeEstimation,
    [ChatLandingModalVariant.ChatLandingAgeVerifiedCommsUpsellModal] = SocialUpsellType.FacialAgeEstimation,
    [ConversationBottomModal.ConversationBottomAgeVerificationRequiredModal] = SocialUpsellType.ConversationFacialAgeEstimation,
    [ConversationBottomModal.NudgeToBottomChatUpsell] = SocialUpsellType.ConversationFacialAgeEstimation
}

local tbl2 = {
    open_fae_upsell = Constants.UPSELL_BUTTON_ACTION.Primary,
    open_fae_view_details = Constants.UPSELL_BUTTON_ACTION.Secondary,
    dismiss = Constants.UPSELL_BUTTON_ACTION.Dismiss
}

local function getCountdownLabelItem(arg1)
    local var1 = nil
    local deepValue = getDeepValue(arg1, "modal_layout.header.additional_content")
    if deepValue then
        local where = Cryo.List.findWhere(deepValue, function(arg2): boolean
            return arg2.type == AppChatNetworking.Constants.ModalContentType.Countdown
        end)
        if where then
            var1 = deepValue[where].text and {
                type = Constants.UPSELL_LABEL_ITEM_TYPE_COUNTDOWN,
                text = deepValue[where].text
            } or var1
        end
    end

    return var1
end

local function getButtonAction(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    if arg1.action and arg1.action.type then
        return tbl2[arg1.action.type]
    end

    return nil
end

return function(arg1)
    local type = tbl1[arg1.modal_variant] or SocialUpsellType.Unknown
    local labelItems = {}
    local deepValue = getDeepValue(arg1, "modal_layout.buttons")
    local countdownLabelItem = getCountdownLabelItem(arg1)

    if countdownLabelItem then
        table.insert(labelItems, countdownLabelItem)
    end

    local buttons = Cryo.List.filterMap(deepValue, function(arg2): {action: any, text: any}?
        local action = getButtonAction(arg2)
        return if action and arg2.text then {
            text = arg2.text,
            action = action
        } else nil
    end)

    return createCommonSocialUpsellBannerConfig({
        type = type,
        title = getDeepValue(arg1, "modal_layout.header.text"),
        body = getDeepValue(arg1, "modal_layout.body.text"),
        isDismissable = getDeepValue(arg1, "modal_layout.dismissible"),
        labelItems = labelItems,
        buttons = buttons
    })
end

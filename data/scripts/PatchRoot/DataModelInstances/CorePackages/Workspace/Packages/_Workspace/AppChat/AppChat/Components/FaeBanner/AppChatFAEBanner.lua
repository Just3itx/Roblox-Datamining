-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:21:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local AppChatNetworking = require(AppChatParent.AppChatNetworking)
local useDispatch = require(AppChatParent.RoactUtils).Hooks.RoactRodux.useDispatch
local useIsInExperience = require(AppChat.Hooks.useIsInExperience)
local createBannerConfigFromModalConfiguration = require(AppChat.Utils.createBannerConfigFromModalConfiguration)
local fetchChatMetadata = require(AppChat.Conversations.Thunks.fetchChatMetadata)

local React = require(AppChatParent.React)
local _types = require(AppChat.types)
local var1 = require(AppChat.Logger):new(script.Name)
local useCallback = React.useCallback

local SocialUpsell = require(AppChatParent.SocialUpsell)
local Foundation = require(AppChatParent.Foundation)

local UpsellBanner = SocialUpsell.UpsellBanner

local startFacialAgeEstimation = SocialUpsell.Thunks.startFacialAgeEstimation
local useSocialUpsellOverlayController = SocialUpsell.Hooks.useSocialUpsellOverlayController

local UpsellComponent = SocialUpsell.Analytics.Enum.UpsellComponent
local UpsellEntrySurfaceType = SocialUpsell.Analytics.Enum.UpsellEntrySurfaceType
local ChatLandingModalVariant = AppChatNetworking.Constants.ChatLandingModalVariant
local ConversationBottomModal = AppChatNetworking.Constants.ConversationBottomModal

local tbl1 = {
    [ChatLandingModalVariant.ChatLandingAgeVerifiedCommsTimedModal] = UpsellEntrySurfaceType.PartyTab,
    [ChatLandingModalVariant.ChatLandingAgeVerifiedCommsUpsellModal] = UpsellEntrySurfaceType.PartyTab,
    [ConversationBottomModal.ConversationBottomAgeVerificationRequiredModal] = UpsellEntrySurfaceType.PartyChatConversationUA,
    [ConversationBottomModal.NudgeToBottomChatUpsell] = UpsellEntrySurfaceType.PartyChatConversationUA
}

local tbl2 = {
    [ChatLandingModalVariant.ChatLandingAgeVerifiedCommsTimedModal] = UpsellEntrySurfaceType.PartyTabInExperience,
    [ChatLandingModalVariant.ChatLandingAgeVerifiedCommsUpsellModal] = UpsellEntrySurfaceType.PartyTabInExperience,
    [ConversationBottomModal.ConversationBottomAgeVerificationRequiredModal] = UpsellEntrySurfaceType.PartyChatConversationInExperience,
    [ConversationBottomModal.NudgeToBottomChatUpsell] = UpsellEntrySurfaceType.PartyChatConversationInExperience
}

local tbl3 = {
    [ChatLandingModalVariant.ChatLandingAgeVerifiedCommsTimedModal] = true,
    [ChatLandingModalVariant.ChatLandingAgeVerifiedCommsUpsellModal] = true,
    [ConversationBottomModal.ConversationBottomAgeVerificationRequiredModal] = false,
    [ConversationBottomModal.NudgeToBottomChatUpsell] = false
}

local tbl4 = {
    [ChatLandingModalVariant.ChatLandingAgeVerifiedCommsTimedModal] = "padding-x-medium padding-top-xxsmall padding-bottom-large align-x-center auto-y size-full-0",
    [ChatLandingModalVariant.ChatLandingAgeVerifiedCommsUpsellModal] = "padding-x-medium padding-top-xxsmall padding-bottom-large align-x-center auto-y size-full-0",
    [ConversationBottomModal.ConversationBottomAgeVerificationRequiredModal] = "padding-large align-x-center auto-y size-full-0 stroke-standard stroke-default bg-shift-100",
    [ConversationBottomModal.NudgeToBottomChatUpsell] = "padding-large align-x-center auto-y size-full-0 stroke-standard stroke-default bg-shift-100"
}

return React.memo(function(tbl5) -- name: AppChatFAEBanner
    local var2 = useDispatch()
    local var3 = useIsInExperience()
    local var4 = useCallback(function()
        var2(fetchChatMetadata())
    end, { var2, fetchChatMetadata })

    local modalConfiguration = tbl5.modalConfiguration
    local upsellEntrySurface = if var3 then tbl2[modalConfiguration.modal_variant] else tbl1[modalConfiguration.modal_variant]
    local var6 = useSocialUpsellOverlayController(var3)
    local onPrimaryAction = React.useCallback(function(_: string)
        var2(
            startFacialAgeEstimation(
                SocialUpsell.Enums.SocialUpsellType.FacialAgeEstimation .. upsellEntrySurface,
                var4,
                nil,
                upsellEntrySurface,
                var3
            )
        )
    end, { var2, upsellEntrySurface, var3 })
    local onSecondaryAction = React.useCallback(function(impressionId: string)
        var6.openSocialOverlay(
            SocialUpsell.Enums.SocialUpsellType.FacialAgeEstimation,
            {
                upsellEntrySurface = upsellEntrySurface,
                upsellEntryComponent = UpsellComponent.Banner,
                impressionId = impressionId
            }
        )
    end, { var6.openSocialOverlay, upsellEntrySurface })

    local config = createBannerConfigFromModalConfiguration(modalConfiguration)

    local var9 = React.useCallback(function(_: string)
        if not config.isDismissable then
            var1:warning("attempt to call AppChatFAEBanner onDismiss not provided and banner is not dismissable")
        end
    end, {})
    local onDismiss = tbl5.onDismiss or var9

    local isContained = tbl3[modalConfiguration.modal_variant]
    local tag = tbl4[modalConfiguration.modal_variant]

    return React.createElement(Foundation.View, { tag = tag }, {
        UpsellBanner = React.createElement(UpsellBanner, {
            config = config,
            isContained = isContained,
            onPrimaryAction = onPrimaryAction,
            onSecondaryAction = onSecondaryAction,
            onDismiss = onDismiss,
            upsellEntrySurface = upsellEntrySurface,
            upsellEntryComponent = UpsellComponent.Banner,
            conversationId = tbl5.conversationId
        })
    })
end)

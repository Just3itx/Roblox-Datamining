-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:20:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local Foundation = require(AppChatParent.Foundation)

local Cryo = require(AppChatParent.Cryo)
local React = require(AppChatParent.React)
local _types = require(AppChat.types)

local ConversationBottomModal = require(AppChatParent.AppChatNetworking).Constants.ConversationBottomModal
local ModalConfiguration = require(AppChat.Models.ModalConfiguration)
local useSelector = require(AppChatParent.RoactUtils).Hooks.RoactRodux.useSelector
local getDeepValue2 = require(AppChat.Utils.getDeepValue2)
local SocialExperiments = require(AppChatParent.SocialExperiments)
local FFlagTestDeviceForFAEUpsell = SocialExperiments.FFlagTestDeviceForFAEUpsell
local deviceMeetsRequirementsForFAE = SocialExperiments.deviceMeetsRequirementsForFAE

local ConversationModal = require(script.Parent.ConversationModal)
local AppChatFAEBanner = require(AppChat.Components.FaeBanner.AppChatFAEBanner)

local tbl1 = {
    shouldShowLegacyBottomModal = false,
    onHeightChanged = function(_) end
}

return React.memo(function(tbl2) -- name: ConversationBottomModalContainer
    local var1 = Cryo.Dictionary.union(tbl1, tbl2)

    local modalConfiguration = useSelector(function(arg1)
        return getDeepValue2(arg1, `ChatAppReducer.Modals.conversationBottomModals.{var1.conversationId}`)
            or ModalConfiguration.default
    end)

    local onAbsoluteSizeChanged = React.useCallback(function(arg1)
        var1.onHeightChanged(arg1.AbsoluteSize.Y)
    end, { var1.onHeightChanged })

    local element = if var1.shouldShowChatInputBar
        or not modalConfiguration
        or modalConfiguration.modal_variant == nil
        or modalConfiguration.modal_variant == ConversationBottomModal.None then nil else React.createElement(AppChatFAEBanner, { modalConfiguration = modalConfiguration, conversationId = var1.conversationId })

    if FFlagTestDeviceForFAEUpsell and not deviceMeetsRequirementsForFAE() then
        return nil
    end

    if not element and var1.shouldShowLegacyBottomModal then
        element = React.createElement(ConversationModal, { bodyText = var1.legacyBottomModalText })
    end

    return React.createElement(
        Foundation.View,
        {
            LayoutOrder = var1.layoutOrder,
            onAbsoluteSizeChanged = onAbsoluteSizeChanged,
            tag = "auto-y size-full-0"
        },
        { ConversationBottomModal = element }
    )
end)

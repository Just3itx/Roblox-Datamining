-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:21:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceGiftingParent = script:FindFirstAncestor("AvatarExperienceGifting").Parent

local React = require(AvatarExperienceGiftingParent.React)
local Gifting = require(AvatarExperienceGiftingParent.Gifting)

local AvatarGiftInfoPanelView = require(script.Parent.Parent.AvatarGiftInfoPanel.AvatarGiftInfoPanelView)

local GiftSendView = Gifting.Components.GiftSendView

return React.memo(function(arg1) -- name: AvatarGiftSendView
    local thumbnailUrl = arg1.thumbnailUrl
    local itemName = arg1.itemName
    local priceText = arg1.priceText
    local originalPriceText = arg1.originalPriceText
    local pricingNote = arg1.pricingNote

    local giftPresentation = React.useMemo(function()
        return React.createElement(AvatarGiftInfoPanelView, {
            thumbnailUrl = thumbnailUrl,
            itemName = itemName,
            priceText = priceText,
            originalPriceText = originalPriceText,
            pricingNote = pricingNote
        })
    end, {
        thumbnailUrl,
        itemName,
        priceText,
        originalPriceText,
        pricingNote
    })
    return React.createElement(GiftSendView, {
        isOpen = arg1.isOpen,
        titleText = arg1.titleText,
        onBack = arg1.onBack,
        allowance = arg1.allowance,
        userInfoProps = arg1.userInfoProps,
        giftPresentation = giftPresentation,
        savingsPresentation = arg1.savingsPresentation,
        state = arg1.state,
        buyLabel = arg1.buyLabel,
        isBuyLoading = arg1.isBuyLoading,
        isBuyDisabled = arg1.isBuyDisabled,
        onBuy = arg1.onBuy,
        disclaimerText = arg1.disclaimerText,
        onClose = arg1.onClose
    })
end)

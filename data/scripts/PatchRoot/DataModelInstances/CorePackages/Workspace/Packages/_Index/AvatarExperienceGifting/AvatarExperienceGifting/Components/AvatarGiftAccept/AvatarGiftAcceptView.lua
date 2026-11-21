-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:21:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceGiftingParent = script:FindFirstAncestor("AvatarExperienceGifting").Parent

local React = require(AvatarExperienceGiftingParent.React)
local Foundation = require(AvatarExperienceGiftingParent.Foundation)
local Gifting = require(AvatarExperienceGiftingParent.Gifting)

local AvatarGiftInfoPanelView = require(script.Parent.Parent.AvatarGiftInfoPanel.AvatarGiftInfoPanelView)

local GiftAcceptView = Gifting.Components.GiftAcceptView
local useTokens = Foundation.Hooks.useTokens

return React.memo(function(arg1) -- name: AvatarGiftAcceptView
    local var1 = useTokens()

    local thumbnailUrl = arg1.thumbnailUrl
    local itemName = arg1.itemName
    local captionText = arg1.captionText
    local size2000 = var1.Size.Size_2000

    local giftPresentation = React.useMemo(function()
        return React.createElement(
            AvatarGiftInfoPanelView,
            {
                thumbnailUrl = thumbnailUrl,
                itemName = itemName,
                captionText = captionText,
                thumbnailSize = size2000
            }
        )
    end, {
        thumbnailUrl,
        itemName,
        captionText,
        size2000
    })
    return React.createElement(GiftAcceptView, {
        isOpen = arg1.isOpen,
        titleText = arg1.titleText,
        userInfoProps = arg1.userInfoProps,
        giftPresentation = giftPresentation,
        state = arg1.state,
        acceptLabel = arg1.acceptLabel,
        isAcceptLoading = arg1.isAcceptLoading,
        isAcceptDisabled = arg1.isAcceptDisabled,
        onAccept = arg1.onAccept,
        rejectLabel = arg1.rejectLabel,
        isRejectLoading = arg1.isRejectLoading,
        isRejectDisabled = arg1.isRejectDisabled,
        onReject = arg1.onReject,
        disclaimerText = arg1.disclaimerText,
        onClose = arg1.onClose
    })
end)

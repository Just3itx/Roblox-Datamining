-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:21:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceGiftingParent = script:FindFirstAncestor("AvatarExperienceGifting").Parent

local React = require(AvatarExperienceGiftingParent.React)
local GiftSheetLayoutView = require(AvatarExperienceGiftingParent.Gifting).Components.GiftSheetLayoutView

local function AvatarItemGiftReviewSheetPlaceholderView(tbl1)
    if not tbl1.isVisible then
        return nil
    end

    return React.createElement(
        GiftSheetLayoutView,
        {
            isOpen = true,
            titleText = "Purchase prompt",
            content = nil,
            onBack = tbl1.onBack,
            onClose = tbl1.onClose
        }
    )
end
return AvatarItemGiftReviewSheetPlaceholderView

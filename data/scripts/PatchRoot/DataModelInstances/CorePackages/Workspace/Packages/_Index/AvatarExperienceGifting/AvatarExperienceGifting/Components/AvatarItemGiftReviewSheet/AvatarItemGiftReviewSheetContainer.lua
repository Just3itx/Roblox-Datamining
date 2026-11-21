-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:21:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceGifting = script:FindFirstAncestor("AvatarExperienceGifting")
local AvatarExperienceGiftingParent = AvatarExperienceGifting.Parent

local React = require(AvatarExperienceGiftingParent.React)
local _GiftSendFlowNavigationOverrides = require(AvatarExperienceGifting.Types.GiftSendFlowNavigationOverrides)

local AvatarItemGiftReviewSheetPlaceholderView = require(script.Parent.AvatarItemGiftReviewSheetPlaceholderView)
local useAvatarItemGiftReviewSheetViewModel = require(script.Parent.useAvatarItemGiftReviewSheetViewModel)

local function AvatarItemGiftReviewSheetContainer(tbl1)
    local var1 = useAvatarItemGiftReviewSheetViewModel(tbl1.navigationOverrides)
    return React.createElement(AvatarItemGiftReviewSheetPlaceholderView, var1)
end

return AvatarItemGiftReviewSheetContainer

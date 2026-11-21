-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:21:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceGifting = script:FindFirstAncestor("AvatarExperienceGifting")
local AvatarExperienceGiftingParent = AvatarExperienceGifting.Parent

local React = require(AvatarExperienceGiftingParent.React)
local _GiftSendFlowNavigationOverrides = require(AvatarExperienceGifting.Types.GiftSendFlowNavigationOverrides)

local AvatarItemGiftRecipientPickerView = require(script.Parent.AvatarItemGiftRecipientPickerView)
local useAvatarItemGiftRecipientPickerViewModel = require(script.Parent.useAvatarItemGiftRecipientPickerViewModel)

local function AvatarItemGiftRecipientPickerContainer(tbl1)
    local var1 = useAvatarItemGiftRecipientPickerViewModel(tbl1.navigationOverrides)
    return React.createElement(AvatarItemGiftRecipientPickerView, var1)
end

return AvatarItemGiftRecipientPickerContainer

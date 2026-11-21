-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:20:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local AvatarItemGiftEntryPointContainer = require(script.Components.AvatarItemGiftEntryPoint.AvatarItemGiftEntryPointContainer)

local AvatarItemGiftRecipientPickerContainer = require(script.Components.AvatarItemGiftRecipientPicker.AvatarItemGiftRecipientPickerContainer)

local AvatarItemGiftReviewSheetContainer = require(script.Components.AvatarItemGiftReviewSheet.AvatarItemGiftReviewSheetContainer)

local _GiftSendFlowNavigationOverrides = require(script.Types.GiftSendFlowNavigationOverrides)
local useAvatarItemGiftEligibility = require(script.Hooks.useAvatarItemGiftEligibility)

return {
    ["jest.config"] = script["jest.config"],
    Components = {
        AvatarItemGiftEntryPoint = AvatarItemGiftEntryPointContainer,
        AvatarItemGiftRecipientPicker = AvatarItemGiftRecipientPickerContainer,
        AvatarItemGiftReviewSheet = AvatarItemGiftReviewSheetContainer
    },
    Hooks = { useAvatarItemGiftEligibility = useAvatarItemGiftEligibility },
    Utils = {}
}

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:21:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceGifting = script:FindFirstAncestor("AvatarExperienceGifting")
local AvatarExperienceGiftingParent = AvatarExperienceGifting.Parent

local React = require(AvatarExperienceGiftingParent.React)
local _Gifting = require(AvatarExperienceGiftingParent.Gifting)
local AvatarExperienceNavigation = require(AvatarExperienceGiftingParent.AvatarExperienceNavigation)
local useNavigation = require(AvatarExperienceGiftingParent.Navigation).useNavigation

local _AvatarItemGiftEntryPointView = require(script.Parent.AvatarItemGiftEntryPointView)
local useAvatarItemGiftEligibility = require(AvatarExperienceGifting.Hooks.useAvatarItemGiftEligibility)

local AvatarScreen = AvatarExperienceNavigation.Enums.AvatarScreen

local function useAvatarItemGiftEntryPointViewModel(tbl1)
    local collectibleItemId = tbl1.collectibleItemId
    local isCircular = tbl1.isCircular
    local layoutOrder = tbl1.LayoutOrder

    local var1 = useNavigation()

    local var2 = useAvatarItemGiftEligibility(collectibleItemId, tbl1.eligibilityDeps)

    local areItemsGiftable = var2.areItemsGiftable

    local canGift = var2.canGift

    local onActivated = React.useCallback(function()
        if not canGift or collectibleItemId == nil or collectibleItemId == "" then
            return
        end

        var1.navigate(AvatarScreen.SendGiftRecipientPicker, { collectibleItemId = collectibleItemId })
    end, { canGift, collectibleItemId, var1 })

    return {
        isVisible = areItemsGiftable,
        buttonProps = React.useMemo(function()
            return { onActivated = onActivated, isCircular = isCircular, LayoutOrder = layoutOrder }
        end, { onActivated, isCircular, layoutOrder })
    }
end

return useAvatarItemGiftEntryPointViewModel

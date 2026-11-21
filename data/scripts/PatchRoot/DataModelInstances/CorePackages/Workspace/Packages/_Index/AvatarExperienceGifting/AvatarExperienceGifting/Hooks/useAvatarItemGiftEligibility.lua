-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:21:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceGifting = script:FindFirstAncestor("AvatarExperienceGifting")
local AvatarExperienceGiftingParent = AvatarExperienceGifting.Parent

local React = require(AvatarExperienceGiftingParent.React)
local Gifting = require(AvatarExperienceGiftingParent.Gifting)

local buildGiftItem = require(AvatarExperienceGifting.Utils.buildGiftItem)

local useGiftEligibility = Gifting.Hooks.useGiftEligibility

local function useAvatarItemGiftEligibility(str1: string?, arg1)
    local var1 = React.useMemo(function(): {any}?
        local giftItem = buildGiftItem(str1)
        return if giftItem == nil then nil else { giftItem }
    end, { str1 })

    return useGiftEligibility(var1, arg1)
end

return useAvatarItemGiftEligibility

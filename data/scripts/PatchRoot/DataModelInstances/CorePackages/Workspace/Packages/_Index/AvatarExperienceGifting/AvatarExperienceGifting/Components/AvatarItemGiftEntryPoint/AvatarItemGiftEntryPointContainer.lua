-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:21:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceGiftingParent = script:FindFirstAncestor("AvatarExperienceGifting").Parent

local React = require(AvatarExperienceGiftingParent.React)

local AvatarItemGiftEntryPointView = require(script.Parent.AvatarItemGiftEntryPointView)
local useAvatarItemGiftEntryPointViewModel = require(script.Parent.useAvatarItemGiftEntryPointViewModel)

local function AvatarItemGiftEntryPointContainer(arg1)
    local var1 = useAvatarItemGiftEntryPointViewModel(arg1)
    return React.createElement(AvatarItemGiftEntryPointView, var1)
end

return AvatarItemGiftEntryPointContainer

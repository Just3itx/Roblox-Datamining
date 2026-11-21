-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T05:10:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceUIKitParent = script:FindFirstAncestor("AvatarExperienceUIKit").Parent
local NumberLocalization = require(AvatarExperienceUIKitParent.Localization).NumberLocalization
local LocalizationService = game:GetService("LocalizationService")

local function getLocalizedPrice(num1: number)
    local str1 = string.format("%.0f", num1 or 0)
    return NumberLocalization.localize(str1, LocalizationService.RobloxLocaleId)
end

return getLocalizedPrice

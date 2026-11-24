-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:51:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local LocalizationService = game:GetService("LocalizationService")

local InExperienceShopParent = script:FindFirstAncestor("InExperienceShop").Parent
local NumberLocalization = require(InExperienceShopParent.Localization).NumberLocalization

local function formatPrice(num1: number?)
    local str1 = string.format("%.0f", num1 or 0)
    return NumberLocalization.localize(str1, LocalizationService.RobloxLocaleId)
end

return formatPrice

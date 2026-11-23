-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T16:31:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceInspectAndBuyParent = script:FindFirstAncestor("AvatarExperienceInspectAndBuy").Parent
local NumberLocalization = require(AvatarExperienceInspectAndBuyParent.Localization).NumberLocalization
local LocalizationService = game:GetService("LocalizationService")

local function formatNumber(num1: number?)
    local str1 = string.format("%.0f", num1 or 0)
    return NumberLocalization.localize(str1, LocalizationService.RobloxLocaleId)
end

return formatNumber

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T13:51:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local LocalizationService = game:GetService("LocalizationService")

local ReactionsParent = script:FindFirstAncestor("Reactions").Parent

local Localization = require(ReactionsParent.Localization)

local function abbreviateReactionCount(num1: number)
    return Localization.abbreviateCount(num1, LocalizationService.RobloxLocaleId)
end

return abbreviateReactionCount

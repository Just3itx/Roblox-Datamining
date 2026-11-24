-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T16:41:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericChallengesParent = script:FindFirstAncestor("GenericChallenges").Parent

local LocalizationService = game:GetService("LocalizationService")
local Localization = require(GenericChallengesParent.RobloxAppLocales).Localization
local localizeStrings = require(GenericChallengesParent.Localization).localizeStrings

return function(str1: string?)
    return localizeStrings(
        Localization.new(LocalizationService.RobloxLocaleId),
        {
            title = if str1 == nil then "Feature.AccountSettings.Heading.Tab.Security" else str1
        }
    ).title
end

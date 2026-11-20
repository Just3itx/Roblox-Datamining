-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T21:20:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local LocalizationService = game:GetService("LocalizationService")

local scriptParentParent = script.Parent.Parent

local function translate(str1: string)
    return require(scriptParentParent.InExperienceLocales).Localization.new(LocalizationService.RobloxLocaleId):Format(str1)
end

return translate

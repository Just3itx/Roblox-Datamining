-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T09:10:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local LocalizationService = game:GetService("LocalizationService")

local scriptParentParent = script.Parent.Parent

local Localization = require(scriptParentParent.InExperienceLocales).Localization

local localization = Localization.new(LocalizationService.RobloxLocaleId)

local module = {}

function module.FormatByKey(_, arg1, arg2)
    return localization:Format(arg1, arg2)
end

function module.FormatByKeyForLocale(_, arg1, arg2, arg3)
    return Localization.new(arg2):Format(arg1, arg3)
end

return module

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T02:51:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local LocalizationService = game:GetService("LocalizationService")

local scriptParentParentParent = script.Parent.Parent.Parent
local Localization = require(scriptParentParentParent.Localization)

local NumberLocalization = Localization.NumberLocalization
local RoundingBehaviour = Localization.RoundingBehaviour

return function(arg1)
    if arg1 == nil then
        return "-"
    elseif type(arg1) == "number" then
        if tostring(arg1):len() >= 7 then
            return NumberLocalization.abbreviate(arg1, LocalizationService.RobloxLocaleId, RoundingBehaviour.Truncate)
        end

        return NumberLocalization.localize(arg1, LocalizationService.RobloxLocaleId)
    else
        return tostring(arg1)
    end
end

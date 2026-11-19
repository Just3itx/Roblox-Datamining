-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:00:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local LocalizationService = game:GetService("LocalizationService")

local NumberLocalization = require(CorePackages.Workspace.Packages.Localization).NumberLocalization
local RoundingBehaviour = require(CorePackages.Workspace.Packages.Localization).RoundingBehaviour

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

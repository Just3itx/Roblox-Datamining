-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T23:01:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InterventionSharedParent = script:FindFirstAncestor("InterventionShared").Parent

local LocalizationService = game:GetService("LocalizationService")
local var1 = require(InterventionSharedParent.RobloxAppLocales).Localization.new(LocalizationService.RobloxLocaleId)

local tbl1 = {
    {
        threshold = 1380,
        unit = 1440,
        headingPlural = "Feature.InExperienceIntervention.Description.CannotSendDays",
        headingSingle = "Feature.InExperienceIntervention.Description.CannotSend1Day"
    },
    {
        threshold = 59,
        unit = 60,
        headingPlural = "Feature.InExperienceIntervention.Description.CannotSendHours",
        headingSingle = "Feature.InExperienceIntervention.Description.CannotSend1Hour"
    },
    {
        threshold = 1,
        unit = 1,
        headingPlural = "Feature.InExperienceIntervention.Description.CannotSend",
        headingSingle = "Feature.InExperienceIntervention.Description.CannotSend1Min"
    }
}

return function(threshold: number)
    local str1 = ""

    for _, value in tbl1 do
        if not (value.threshold <= threshold) then
            continue
        end

        local number = math.ceil(threshold / value.unit)

        if number == 1 then
            return (var1:Format(value.headingSingle))
        end
        return (var1:Format(value.headingPlural, { number = number }))
    end

    return str1
end

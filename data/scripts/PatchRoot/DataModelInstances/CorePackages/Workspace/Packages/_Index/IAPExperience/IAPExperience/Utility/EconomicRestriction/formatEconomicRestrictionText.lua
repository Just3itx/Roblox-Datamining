-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:30:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local IAPExperience = script:FindFirstAncestor("IAPExperience")
local IAPExperienceParent = IAPExperience.Parent

local getEconomicRestrictionLocalizedLabel = require(IAPExperience.Utility.EconomicRestriction.getEconomicRestrictionLocalizedLabel)
local default = require(IAPExperienceParent.LoggingProtocol).default
local EconomicRestrictionsPromptShownCounter = require(IAPExperience.Generic.Events.PurchaseErrorPromptCounter).EconomicRestrictionsPromptShownCounter
local logger = require(IAPExperience.Utility.logger)
local getAppContext = require(IAPExperience.Utility.getAppContext)

return function(tbl1, tbl2, bool1: boolean)
    local timeoutMinutes = tbl2.timeoutMinutes or tbl2.expirationTimeInMinutes or tbl2.ExpirationTimeInMinutes
    local violationType = tbl2.violationType or tbl2.failureReason or tbl2.FailureReason
    default:logRobloxTelemetryCounter(
        EconomicRestrictionsPromptShownCounter,
        1,
        {
            violationType = tostring(violationType),
            appContext = getAppContext()
        }
    )

    if not (timeoutMinutes and violationType) then
        logger.error({
            error = "Timeout and violationType is required for economic restriction text. Showing unknown error.",
            timeoutMinutes = timeoutMinutes,
            violationType = violationType
        })
        return tbl1.unknownText
    end

    local economicRestrictionLocalizedLabel = getEconomicRestrictionLocalizedLabel(tbl1, violationType)
    local num1 = math.ceil(timeoutMinutes / 60)

    if not (num1 >= 24) then
        return (if bool1 then tbl1.economicRestrictionBaseTextHoursGeneral else tbl1.economicRestrictionBaseTextHours):gsub(
            "{hour}",
            tostring(num1)
        ):gsub(
            "{violation}",
            economicRestrictionLocalizedLabel
        )
    end

    local num2 = math.ceil(num1 / 24)

    return (if bool1 then tbl1.economicRestrictionBaseTextDaysGeneral else tbl1.economicRestrictionBaseTextDays):gsub(
        "{day}",
        tostring(num2)
    ):gsub(
        "{violation}",
        economicRestrictionLocalizedLabel
    )
end

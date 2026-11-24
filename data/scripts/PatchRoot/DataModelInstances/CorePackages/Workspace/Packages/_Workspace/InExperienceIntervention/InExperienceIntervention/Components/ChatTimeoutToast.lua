-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T19:10:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceIntervention = script:FindFirstAncestor("InExperienceIntervention")
local InExperienceInterventionParent = InExperienceIntervention.Parent

local React = require(InExperienceInterventionParent.React)

local Constants = require(InExperienceInterventionParent.InterventionShared).Utils.Constants
local InExperienceInterventionAnalytics = require(InExperienceIntervention.InExperienceInterventionAnalytics)
local ChatInterventionGenericToast = require(InExperienceIntervention.Components.ChatInterventionGenericToast)

local useLocalization = require(InExperienceInterventionParent.Localization).Hooks.useLocalization
local determineToastDuration = require(InExperienceInterventionParent.InterventionShared).Utils.determineToastDuration

function ChatTimeoutToast(tbl1)
    local remainingDurationSec, var2 = React.useState(0)

    local var3 = useLocalization({
        cannotSend1MinText = Constants.localizationKeys.CannotSend1MinText,
        beRespectfulText = Constants.localizationKeys.BeRespectfulText
    })

    React.useEffect(function()
        if tbl1.endTime then
            local unixTimestamp = DateTime.now().UnixTimestamp
            local num1 = math.ceil((tbl1.endTime - unixTimestamp) / 60)
            var2(num1)
        end
    end, { tbl1.endTime, tbl1.dispatchTimestamp })

    local toastTitle = determineToastDuration(remainingDurationSec)

    return React.createElement(ChatInterventionGenericToast, {
        toastTitle = toastTitle,
        toastBody = var3.beRespectfulText,
        interventionType = InExperienceInterventionAnalytics.Constants.InterventionTypes.Timeout,
        remainingDurationSec = remainingDurationSec,
        toastAppearEventName = InExperienceInterventionAnalytics.Constants.EventTypes.ChatAttemptToastAppeared,
        toastDismissEventName = InExperienceInterventionAnalytics.Constants.EventTypes.ChatAttemptToastDismissed
    })
end

return ChatTimeoutToast

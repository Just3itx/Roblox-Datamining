-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T19:11:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceIntervention = script:FindFirstAncestor("InExperienceIntervention")
local InExperienceInterventionParent = InExperienceIntervention.Parent

local _Types = require(InExperienceIntervention.Utils.Types)
local Constants = require(InExperienceInterventionParent.InterventionShared).Utils.Constants
local UIStateActions = Constants.UIStateActions
local num1 = game:DefineFastInt("ChatInterventionUIRateLimitWindowSec", 5)
local bool1 = game:DefineFastFlag("RateLimitNudgeToast", false)
local bool2 = game:DefineFastFlag("RateLimitTimeoutToast", false)
local bool3 = game:DefineFastFlag("RateLimitNudgeDialog", false)
local bool4 = game:DefineFastFlag("RateLimitTimeoutDialog", false)

local function InExperienceInterventionUIStateReducer(arg1, arg2)
    local var1 = table.clone(arg1)
    local type = arg2.type

    local bool5 = DateTime.now().UnixTimestamp - arg1.dispatchTimestamp < num1
    local bool6 = arg2.treatmentType == arg1.treatmentType
    local bool7

    if bool2 then
        if arg2.treatmentType == Constants.TreatmentType.ChatTimeoutChatAttempt
            and arg1.treatmentType == Constants.TreatmentType.ChatTimeoutGameJoin
        then
            bool7 = true
        elseif arg2.treatmentType == Constants.TreatmentType.ChatTimeoutGameJoin then
            bool7 = arg1.treatmentType == Constants.TreatmentType.ChatTimeoutChatAttempt
        else
            bool7 = false
        end
        local bool8 = arg2.treatmentType == Constants.TreatmentType.ChatTimeoutChatAttempt
            or arg2.treatmentType == Constants.TreatmentType.ChatTimeoutGameJoin
        if bool6 then
            bool7 = bool8 or bool7
        end
    else
        bool7 = false
    end

    local bool8 = if bool1 then arg2.treatmentType == Constants.TreatmentType.ChatNudgeToast and bool6 else false
    local bool9 = if bool3 then arg2.treatmentType == Constants.TreatmentType.ChatNudgeDialog and bool6 else false
    local bool10 = if bool4 then arg2.treatmentType == Constants.TreatmentType.ChatTimeoutDialog and bool6 else false

    if not (bool7 or bool8 or bool9 or bool10) then
        bool5 = bool10
    end

    if type ~= UIStateActions.ToggleNotificationDialog or bool5 then
        if bool5 then
            print("Chat intervention UI treatment rate limited: ", arg2.treatmentType)
        end

        return arg1
    end

    var1.isShown = arg2.isShown
    var1.treatmentType = arg2.treatmentType
    var1.detail = arg2.detail or {}
    var1.endTime = arg2.endTime or 0
    var1.dispatchTimestamp = arg2.dispatchTimestamp
    return var1
end

return InExperienceInterventionUIStateReducer

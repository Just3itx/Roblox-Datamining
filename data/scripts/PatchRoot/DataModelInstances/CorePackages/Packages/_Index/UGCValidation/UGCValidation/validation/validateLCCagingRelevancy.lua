-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:41:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UGCValidationService = game:GetService("UGCValidationService")

local scriptParentParent = script.Parent.Parent

local Analytics = require(scriptParentParent.Analytics)

local _Types = require(scriptParentParent.util.Types)
local pcallDeferred = require(scriptParentParent.util.pcallDeferred)
local getFIntUGCLCCagingRelevancyMinimum = require(scriptParentParent.flags.getFIntUGCLCCagingRelevancyMinimum)

local function validateLCCagingRelevancy(arg1, arg2, arg3, offsetInner: vector, offsetOuter: vector, arg4)
    local var1, var2, var3 = pcallDeferred(function()
        return UGCValidationService:GetEditableCagingRelevancyMetrics(
            arg1.editableMesh,
            arg2.editableMesh,
            arg3.editableMesh,
            offsetInner,
            offsetOuter
        )
    end, arg4)

    if not var1 then
        Analytics.reportFailure(Analytics.ErrorType.validateCagingRelevancy_FailedToExecute, nil, arg4)
        return false, { string.format(
                "Failed to execute cage relevancy detection for '%s'. Make sure the cage mesh exists and try again.",
                arg3.fullName
            ) }
    end

    if var3 == 0 then
        return true
    end

    local num1 = math.floor(100 * var2 / var3)

    if not (num1 < getFIntUGCLCCagingRelevancyMinimum()) then
        return true
    end

    Analytics.reportFailure(Analytics.ErrorType.validateCagingRelevancy_IrrelevantCaging, nil, arg4)

    return false, { string.format(
            "Validation detected %d%% of the outer cage edits do not cover the accessory. Make sure you are moving the outer cage only where needed.[Read more](https://create.roblox.com/docs/art/validation-errors#cageRelevancy)",
            100 - num1
        ) }
end

return validateLCCagingRelevancy

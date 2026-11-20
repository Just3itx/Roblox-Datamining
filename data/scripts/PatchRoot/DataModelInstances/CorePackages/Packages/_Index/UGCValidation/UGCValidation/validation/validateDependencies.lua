-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:41:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local RunService = game:GetService("RunService")

local bool1 = game:DefineFastFlag("NoStudioOwnershipCheck", false)

local Analytics = require(scriptParentParent.Analytics)
local Constants = require(scriptParentParent.Constants)

local ParseContentIds = require(scriptParentParent.util.ParseContentIds)
local FailureReasonsAccumulator = require(scriptParentParent.util.FailureReasonsAccumulator)
local getAssetCreationDetailsRCC = require(scriptParentParent.util.getAssetCreationDetailsRCC)
local _Types = require(scriptParentParent.util.Types)

local validateCanLoad = require(scriptParentParent.validation.validateCanLoad)
local validateAssetCreator = require(scriptParentParent.validation.validateAssetCreator)

local function validateExistance(tbl1, arg1)
    for _, value in pairs(tbl1) do
        if not validateCanLoad(value.instance[value.fieldName], arg1) then
            error(
                string.format(
                    "Failed to load children assets (Meshes, Textures, etc.) for '%s'. Make sure the assets exist and try again.",
                    value.instance.Name
                )
            )
        end
    end
end

local tbl1 = {
    MODERATION_STATE_REVIEWING = { MODERATION_STATE_REVIEWING = true, Reviewing = true },
    MODERATION_STATE_APPROVED = { MODERATION_STATE_APPROVED = true, Approved = true }
}

local function validateCreatorId(tbl2, arg1, instance, fieldName, arg2, arg3)
    if tbl2[tonumber(arg1)] then
        return true
    end

    Analytics.reportFailure(Analytics.ErrorType.validateDependencies_IsRestrictedUserId, nil, arg3)
    return false, { `{instance:GetFullName()}.{fieldName} ( {arg2} ) is not owned by the current user. You can only validate assets that you or a group you belong to owns.` }
end

local function validateModerationState(moderationState, instance, fieldName, arg1, arg2)
    if tbl1.MODERATION_STATE_REVIEWING[moderationState] then
        Analytics.reportFailure(Analytics.ErrorType.validateDependencies_IsReviewing, nil, arg2)
        error(
            "Failed to load asset {instance:GetFullName()}.{fieldName} ( {id} ) that is still going through the review process. Please, wait for a notification of completion from the review process and try again."
        )
    end

    if tbl1.MODERATION_STATE_APPROVED[moderationState] then
        return true
    end

    Analytics.reportFailure(Analytics.ErrorType.validateDependencies_IsNotApproved, nil, arg2)
    return false, { `{instance:GetFullName()}.{fieldName} ( {arg1} ) is not owned by the current user. You can only validate assets that you or a group you belong to owns.` }
end

local function validateModerationRCC(arg1, tbl2, arg2)
    if not arg1 or #arg1 == 0 then
        return true
    end

    local tbl3 = {}
    for _, value in ipairs(arg1) do
        local id = value.id
        tbl3[tonumber(id)] = true
    end

    local failureReasonsAccumulator = FailureReasonsAccumulator.new()

    for k, value in pairs(tbl2) do
        local var1, var2 = getAssetCreationDetailsRCC(k)
        if not var1 then
            error("Failed to load asset")
        end

        local creator = var2.creationContext.creator
        local var3 = if creator.userId then creator.userId else creator.groupId
        failureReasonsAccumulator:updateReasons(validateCreatorId(tbl3, var3, value.instance, value.fieldName, k, arg2))

        failureReasonsAccumulator:updateReasons(
            validateModerationState(var2.moderationResult.moderationState, value.instance, value.fieldName, k, arg2)
        )
    end

    return failureReasonsAccumulator:getFinalResults()
end

local function validateAssetCreatorsRCC(tbl2, arg1)
    assert(arg1.isServer, "isServer must be true for validateAssetCreatorsRCC")
    return validateAssetCreator(tbl2, arg1)
end

local function validateDependencies(arg1, arg2, tbl2)
    local now = tick()
    local isServer = if arg2 then arg2.isServer else nil
    local allowEditableInstances = arg2.allowEditableInstances
    local restrictedUserIds = if arg2 then arg2.restrictedUserIds else nil
    local universeId = if arg2 then arg2.universeId else nil
    local skipExistenceCheck = if tbl2 then tbl2.skipExistenceCheck or false else false
    local skipOwnershipCheck = tbl2 and tbl2.skipOwnershipCheck or false

    if skipExistenceCheck and skipOwnershipCheck then
        return true
    end

    local tbl3 = {}
    local var1, var2 = ParseContentIds.parseWithErrorCheck({}, tbl3, arg1, nil, Constants.CONTENT_ID_REQUIRED_FIELDS, arg2)

    if not var1 then
        Analytics.reportFailure(Analytics.ErrorType.validateDependencies_ParseFailure, nil, arg2)
        return false, var2
    end

    if isServer and not (allowEditableInstances or skipExistenceCheck) then
        validateExistance(tbl3, arg2)
    end

    local failureReasonsAccumulator = FailureReasonsAccumulator.new()

    if not skipOwnershipCheck and (not bool1 or bool1 and not RunService:IsStudio()) and isServer then
        if universeId then
            failureReasonsAccumulator:updateReasons(validateAssetCreatorsRCC(tbl3, arg2))
        else
            failureReasonsAccumulator:updateReasons(validateModerationRCC(restrictedUserIds, tbl3, arg2))
        end
    end

    if arg2 then
        Analytics.recordScriptTime(script.Name, now, arg2)
    end

    return failureReasonsAccumulator:getFinalResults()
end

return validateDependencies

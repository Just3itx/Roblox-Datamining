-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:00:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local Constants = require(scriptParentParentParent.Constants)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)
local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local RunService = game:GetService("RunService")

local canPublishAssets = require(scriptParentParentParent.util.canPublishAssets)
local getAssetCreationDetails = require(scriptParentParentParent.util.getAssetCreationDetails)
local getAssetCreationDetailsRCC = require(scriptParentParentParent.util.getAssetCreationDetailsRCC)

local getFFlagUGCValidateForwardIECRestrictedUserIds = require(scriptParentParentParent.flags.getFFlagUGCValidateForwardIECRestrictedUserIds)

local getFFlagUGCValidateBackendInExperienceViaCanPublish = require(scriptParentParentParent.flags.getFFlagUGCValidateBackendInExperienceViaCanPublish)
local getFFlagUGCValidateMakeupCategoryParity = require(scriptParentParentParent.flags.getFFlagUGCValidateMakeupCategoryParity)

local getFFlagUGCValidateRejectUnsupportedCreatorTypes = require(scriptParentParentParent.flags.getFFlagUGCValidateRejectUnsupportedCreatorTypes)

local tbl1 = { MODERATION_STATE_REVIEWING = true, Reviewing = true }
local tbl2 = { MODERATION_STATE_APPROVED = true, Approved = true }

local function validateConfiguredCreators(arg1, arg2)
    for _, value in arg2 do
        if value.creatorType == "Experience" then
            arg1:fail(
                ErrorSourceStrings.Keys.ExperienceCreatorNotSupported,
                {
                    CreatorType = value.creatorType,
                    CreatorId = value.id
                }
            )
            return false
        end
        if value.creatorType == "User" or value.creatorType == "Group" then
            continue
        end

        arg1:fail(ErrorSourceStrings.Keys.UnsupportedCreatorType, { CreatorType = value.creatorType, CreatorId = value.id })

        return false
    end

    return true
end

local function collectContentIdsArray(contentIds) -- Luacid: Inlined by compiler; 1 call site recovered
    local result = {}
    for k, _ in contentIds do
        table.insert(result, k)
    end
    return result
end

local function runStudio(arg1, rootInstance, contentIds)
    local tbl3 = collectContentIdsArray(contentIds)

    if #tbl3 == 0 then
        return
    end

    local var1, var2 = getAssetCreationDetails(tbl3)
    if not var1 or #var2 ~= #tbl3 then
        arg1:fail(ErrorSourceStrings.Keys.DescendantIdFetchFailed, { InstanceFullName = rootInstance:GetFullName() })

        return
    end

    for _, value in var2 do
        if value.status ~= Constants.ASSET_STATUS.UNKNOWN
            and value.status ~= Constants.ASSET_STATUS.REVIEW_PENDING
            and value.status ~= Constants.ASSET_STATUS.MODERATED
        then
            continue
        end

        local str1 = tostring(value.assetId)
        local contentId = contentIds[str1]
        if contentId then
            str1 = string.format("%s.%s ( %s )", contentId[1].instance:GetFullName(), contentId[1].fieldName, str1)
        end

        arg1:fail(ErrorSourceStrings.Keys.DescendantIdNotApproved, { ModerationMessages = str1 })
    end
end

local function buildOwnerLookup(restrictedUserIds) -- Luacid: Inlined by compiler; 1 call site recovered
    local ownerLookup = {}
    for _, restrictedUserId in restrictedUserIds do
        local id = restrictedUserId.id
        ownerLookup[tonumber(id)] = true
    end
    return ownerLookup
end

local function buildTypedCreatorLookup(restrictedUserIds)
    local tbl3 = {
        User = {},
        Group = {}
    }
    for _, restrictedUserId in restrictedUserIds do
        local var1 = tbl3[restrictedUserId.creatorType]
        local id = restrictedUserId.id
        var1[tonumber(id)] = true
    end
    return tbl3
end

local function runBackend(arg1, contentIds, backendConfigs)
    local restrictedUserIds = backendConfigs.restrictedUserIds
    if not restrictedUserIds or #restrictedUserIds == 0 then
        return
    end
    local fFlagUgcValidateRejectUnsupportedCreatorTypes = getFFlagUGCValidateRejectUnsupportedCreatorTypes()
    local typedCreatorLookup

    if fFlagUgcValidateRejectUnsupportedCreatorTypes then
        if not validateConfiguredCreators(arg1, restrictedUserIds) then
            return
        end
        typedCreatorLookup = buildTypedCreatorLookup(restrictedUserIds)
    else
        typedCreatorLookup = {}
    end

    local ownerLookup = buildOwnerLookup(restrictedUserIds)

    for assetId, contentId in contentIds do
        local var1 = contentId[1]
        local var2, var3 = getAssetCreationDetailsRCC(assetId)
        if not var2 then
            arg1:forceError("Failed to load asset")
        end

        local creator = var3.creationContext.creator
        local bool1 = not fFlagUgcValidateRejectUnsupportedCreatorTypes
            or (if creator.userId ~= nil then typedCreatorLookup.User[tonumber(creator.userId)] == true else not (creator.groupId == nil) and typedCreatorLookup.Group[tonumber(creator.groupId)] == true)

        if not (ownerLookup[tonumber(if creator.userId then creator.userId else creator.groupId)] and bool1) then
            local descendantIdNotOwned = ErrorSourceStrings.Keys.DescendantIdNotOwned
            local tbl3 = {
                AssetId = assetId,
                InstanceFullName = var1.instance:GetFullName(),
                FieldName = var1.fieldName
            }
            arg1:fail(descendantIdNotOwned, tbl3)
        end

        local moderationState = var3.moderationResult.moderationState
        if tbl1[moderationState] then
            arg1:forceError(
                "Failed to load asset "
                    .. var1.instance:GetFullName() .. "." .. var1.fieldName .. " ( " .. assetId .. " ) that is still going through the review process. Please, wait for a notification of completion from the review process and try again."
            )
        end

        if tbl2[moderationState] then
            continue
        end

        local descendantIdNotApproved = ErrorSourceStrings.Keys.DescendantIdNotApproved
        local tbl3 = {
            ModerationMessages = string.format("%s.%s ( %s )", var1.instance:GetFullName(), var1.fieldName, assetId)
        }
        arg1:fail(descendantIdNotApproved, tbl3)
    end
end

local function runCanPublishOwnershipCheck(arg1, rootInstance, contentIds, arg2)
    if getFFlagUGCValidateRejectUnsupportedCreatorTypes() then
        local var1 = arg2.restrictedUserIds or {}
        if not validateConfiguredCreators(arg1, var1) then
            return
        end
    end

    local fFlagUgcValidateBackendInExperienceViaCanPublish = getFFlagUGCValidateBackendInExperienceViaCanPublish()

    if fFlagUgcValidateBackendInExperienceViaCanPublish then
        if arg2.token == nil then
            fFlagUgcValidateBackendInExperienceViaCanPublish = arg2.universeId ~= nil
        else
            fFlagUgcValidateBackendInExperienceViaCanPublish = false
        end
    end
    if not (arg2.token or fFlagUgcValidateBackendInExperienceViaCanPublish)
        or getFFlagUGCValidateForwardIECRestrictedUserIds() and RunService:IsStudio()
    then
        return
    end

    local var1 = not (getFFlagUGCValidateForwardIECRestrictedUserIds() or fFlagUgcValidateBackendInExperienceViaCanPublish) and {}
        or arg2.restrictedUserIds
        or {}

    local var2 = canPublishAssets(contentIds, var1, arg2.token, arg2.universeId, true)

    if var2.status == "tooManyAssets" then
        arg1:fail(ErrorSourceStrings.Keys.DescendantIdsTooMany, { InstanceFullName = rootInstance:GetFullName() })
        return
    elseif var2.status == "loadFailed" then
        arg1:fail(ErrorSourceStrings.Keys.DescendantIdFetchFailed, { InstanceFullName = rootInstance:GetFullName() })
        return
    end

    local verdicts = var2.verdicts
    if not verdicts then
        return
    end

    for _, verdict in verdicts do
        if verdict.allowed then
            continue
        end

        local descendantIdNotOwned = ErrorSourceStrings.Keys.DescendantIdNotOwned
        local tbl3 = {
            AssetId = verdict.assetId,
            InstanceFullName = verdict.entry.instance:GetFullName(),
            FieldName = verdict.entry.fieldName
        }
        arg1:fail(descendantIdNotOwned, tbl3)
    end
end

local module = {
    categories = if getFFlagUGCValidateMakeupCategoryParity() then Constants.AllAssetUploadCategories else Constants.AllAssetUploadCategoriesIncludingMakeup,
    requiredData = { ValidationEnums.SharedDataMember.rootInstance, ValidationEnums.SharedDataMember.consumerConfig, ValidationEnums.SharedDataMember.contentIds },
    expectedFailures = {}
}
function module.run(arg1, arg2)
    local consumerConfig = arg2.consumerConfig

    if consumerConfig.source == "AutoSetup" then
        return
    end

    local rootInstance = arg2.rootInstance
    local contentIds = arg2.contentIds

    local validationEnv = consumerConfig.validationEnv

    if validationEnv == ValidationEnums.ValidationEnv.Studio then
        runStudio(arg1, rootInstance, contentIds)
        return
    end

    if validationEnv ~= ValidationEnums.ValidationEnv.Backend then
        if validationEnv == ValidationEnums.ValidationEnv.IEC then
            runCanPublishOwnershipCheck(arg1, rootInstance, contentIds, consumerConfig.iecConfigs)
        end

        return
    end

    local backendConfigs = consumerConfig.backendConfigs

    if not getFFlagUGCValidateBackendInExperienceViaCanPublish() or not backendConfigs.universeId then
        runBackend(arg1, contentIds, backendConfigs)
        return
    end

    runCanPublishOwnershipCheck(
        arg1,
        rootInstance,
        contentIds,
        {
            universeId = backendConfigs.universeId,
            restrictedUserIds = backendConfigs.restrictedUserIds
        }
    )
end
return module

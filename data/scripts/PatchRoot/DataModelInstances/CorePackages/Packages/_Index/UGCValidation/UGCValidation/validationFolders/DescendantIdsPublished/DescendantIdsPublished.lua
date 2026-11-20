-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:01:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local Constants = require(scriptParentParentParent.Constants)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)
local ParseContentIds = require(scriptParentParentParent.util.ParseContentIds)
local _Types = require(scriptParentParentParent.util.Types)
local UnpublishedDependencies = require(scriptParentParentParent.util.UnpublishedDependencies)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)

local getFFlagUGCValidateDescendantIdsPublished = require(scriptParentParentParent.flags.getFFlagUGCValidateDescendantIdsPublished)

local getFFlagUGCValidateDescendantIdsPublishedShadow = require(scriptParentParentParent.flags.getFFlagUGCValidateDescendantIdsPublishedShadow)

local tbl1 = { AnimationId = true, TexturePack = true, HSRAssetId = true }

local tbl2 = { MODERATION_STATE_REJECTED = true, Rejected = true }

local module = {
    categories = Constants.AllUploadCategories,
    requiredData = { ValidationEnums.SharedDataMember.consumerConfig, ValidationEnums.SharedDataMember.contentIds },
    fflag = getFFlagUGCValidateDescendantIdsPublished,
    shadowFlag = getFFlagUGCValidateDescendantIdsPublishedShadow
}
function module.run(arg1, arg2)
    if arg2.consumerConfig.validationEnv ~= ValidationEnums.ValidationEnv.Backend then
        return
    end

    for _, value in ParseContentIds.getDistinctReferences(arg2.contentIds) do
        local entry = value.entry
        if tbl1[entry.fieldName] then
            continue
        end

        local success, result = pcall(UnpublishedDependencies.getVersion, value.assetId, entry.version)
        if not success then
            arg1:fetchError(`Failed to read asset {value.key}: {result}`)
        end

        if result.published then
            continue
        end

        local instanceFullName = entry.instance:GetFullName()
        local moderationState = if result.moderationResult then result.moderationResult.moderationState else nil

        if moderationState ~= nil and tbl2[moderationState] then
            local descendantIdNotApproved = ErrorSourceStrings.Keys.DescendantIdNotApproved
            local tbl3 = {
                ModerationMessages = `{instanceFullName}.{entry.fieldName} ( {value.key} )`
            }
            arg1:fail(descendantIdNotApproved, tbl3, entry.instance)
        else
            local descendantIdNotPublished = ErrorSourceStrings.Keys.DescendantIdNotPublished
            local tbl3 = {
                AssetId = value.key,
                InstanceFullName = instanceFullName,
                FieldName = entry.fieldName
            }
            arg1:fail(descendantIdNotPublished, tbl3, entry.instance)
        end
    end
end

return module

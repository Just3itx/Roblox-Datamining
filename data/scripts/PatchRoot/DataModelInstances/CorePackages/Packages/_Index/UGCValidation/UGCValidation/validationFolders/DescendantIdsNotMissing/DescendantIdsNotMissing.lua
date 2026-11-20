-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:01:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UGCValidationService = game:GetService("UGCValidationService")

local scriptParentParentParent = script.Parent.Parent.Parent

local Constants = require(scriptParentParentParent.Constants)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)
local ParseContentIds = require(scriptParentParentParent.util.ParseContentIds)
local _Types = require(scriptParentParentParent.util.Types)
local UnpublishedDependencies = require(scriptParentParentParent.util.UnpublishedDependencies)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)

local getFFlagUGCValidateAllowAnimationVersionPins = require(scriptParentParentParent.flags.getFFlagUGCValidateAllowAnimationVersionPins)
local getFFlagUGCValidateCheckDescendantIdsLoadable = require(scriptParentParentParent.flags.getFFlagUGCValidateCheckDescendantIdsLoadable)
local getFFlagUGCValidateVersionedContentIds = require(scriptParentParentParent.flags.getFFlagUGCValidateVersionedContentIds)

local function hasEditableBacking(arg1, str1: string): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    local var1 = Constants.CONTENT_ID_EDITABLE_PROPERTY[arg1.ClassName]
    local var2 = var1 and var1[str1]
    return if var2 then arg1[var2].SourceType == Enum.ContentSourceType.Object else false
end

local function canLoadAsset(assetId: string) -- Luacid: Inlined by compiler; 2 call sites recovered
    local success, result = pcall(function(): boolean
        return UGCValidationService:CanLoadAsset(assetId)
    end)
    return success and result
end

local function reportUnloadable(arg1, bool1: boolean, assetId: string, arg2)
    if bool1 then
        arg1:fetchError(
            string.format(
                "Failed to load asset referenced by %s.%s. Make sure the asset exists and try again.",
                arg2.instance:GetFullName(),
                arg2.fieldName
            )
        )
        return
    end

    arg1:fail(ErrorSourceStrings.Keys.AssetDoesNotExist, { AssetId = assetId, InstancePath = arg2.instance:GetFullName() })
end

local module = {
    categories = Constants.AllAssetUploadCategories,
    requiredData = { ValidationEnums.SharedDataMember.rootInstance, ValidationEnums.SharedDataMember.consumerConfig, ValidationEnums.SharedDataMember.contentIds },
    expectedFailures = {}
}
function module.run(arg1, arg2)
    local bool1 = arg2.consumerConfig.consumerEnv == ValidationEnums.ConsumerEnv.IEC

    local tbl1 = {}
    for _, contentId in arg2.contentIds do
        for _, value in contentId do
            local tbl2 = tbl1[value.instance]
            if not tbl2 then
                tbl2 = {}
                tbl1[value.instance] = tbl2
            end
            tbl2[value.fieldName] = true
        end
    end

    local descendants = arg2.rootInstance:GetDescendants()
    table.insert(descendants, arg2.rootInstance)

    for _, descendant in descendants do
        local var1 = Constants.CONTENT_ID_FIELDS[descendant.ClassName]
        if not var1 then
            continue
        end

        local var2 = Constants.CONTENT_ID_REQUIRED_FIELDS[descendant.ClassName]
        local var3 = tbl1[descendant]

        for _, fieldName in var1 do
            local var4 = descendant[fieldName]
            local bool2 = not (var2 == nil) and var2[fieldName] == true

            if var4 ~= "" then
                if not (var3 and var3[fieldName]) then
                    local descendantIdMalformed = ErrorSourceStrings.Keys.DescendantIdMalformed
                    local tbl2 = {
                        InstanceFullName = descendant:GetFullName(),
                        FieldName = fieldName
                    }
                    arg1:fail(descendantIdMalformed, tbl2)
                end
            elseif bool2 and not (bool1 and hasEditableBacking(descendant, fieldName)) then
                local descendantIdMissing = ErrorSourceStrings.Keys.DescendantIdMissing
                local tbl2 = {
                    InstanceFullName = descendant:GetFullName(),
                    FieldName = fieldName
                }
                arg1:fail(descendantIdMissing, tbl2)
            end
        end

        local var4 = Constants.CONTENT_FIELDS_WITHOUT_CONTENTID[descendant.ClassName]
        if not var4 then
            continue
        end

        for _, fieldName in var4 do
            local var5 = descendant[fieldName]
            if var5.SourceType ~= Enum.ContentSourceType.Uri or var5.Uri == "" or var3 and var3[fieldName] then
                continue
            end

            local descendantIdMalformed = ErrorSourceStrings.Keys.DescendantIdMalformed
            local tbl2 = {
                InstanceFullName = descendant:GetFullName(),
                FieldName = fieldName
            }
            arg1:fail(descendantIdMalformed, tbl2)
        end
    end

    local bool2 = arg2.consumerConfig.validationEnv == ValidationEnums.ValidationEnv.Backend
    if getFFlagUGCValidateVersionedContentIds() and bool2 then
        local tbl2 = ({})
        for assetId, contentId in arg2.contentIds do
            for _, value in contentId do
                local version = value.version
                if version == nil then
                    continue
                end

                local tbl3 = {
                    InstanceFullName = value.instance:GetFullName(),
                    FieldName = value.fieldName,
                    Version = tostring(version),
                    AssetId = assetId
                }
                if value.fieldName == "AnimationId" and not getFFlagUGCValidateAllowAnimationVersionPins() then
                    arg1:fail(ErrorSourceStrings.Keys.DescendantIdAnimationVersionNotSupported, tbl3)
                else
                    local result = tbl2[assetId]
                    if result == nil then
                        local getLatestVersionNumber = UnpublishedDependencies.getLatestVersionNumber
                        local success
                        success, result = pcall(getLatestVersionNumber, assetId)
                        if not success then
                            arg1:fetchError(`Failed to read asset {assetId}: {result}`)
                        end

                        tbl2[assetId] = result
                    end

                    if version ~= result then
                        tbl3.LatestVersion = tostring(result)
                        arg1:fail(ErrorSourceStrings.Keys.DescendantIdVersionNotLatest, tbl3)
                    end
                end
            end
        end
    end

    if not bool2 and not getFFlagUGCValidateCheckDescendantIdsLoadable() then
        return
    end

    if getFFlagUGCValidateVersionedContentIds() then
        for _, value in ParseContentIds.getDistinctReferences(arg2.contentIds) do
            if not canLoadAsset(value.uri) then
                reportUnloadable(arg1, bool2, value.key, value.entry)
            end
        end

        return
    end

    for k, contentId in arg2.contentIds do
        if not canLoadAsset("rbxassetid://" .. k) then
            reportUnloadable(arg1, bool2, k, contentId[1])
        end
    end
end

return module

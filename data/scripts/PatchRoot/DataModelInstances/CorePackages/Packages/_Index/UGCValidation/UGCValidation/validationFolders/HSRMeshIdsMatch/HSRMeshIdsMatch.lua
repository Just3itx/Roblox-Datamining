-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:01:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UGCValidationService = game:GetService("UGCValidationService")

local scriptParentParentParent = script.Parent.Parent.Parent

local getFFlagUGCValidateVersionedContentIds = require(scriptParentParentParent.flags.getFFlagUGCValidateVersionedContentIds)

local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)
local ParseContentIds = require(scriptParentParentParent.util.ParseContentIds)
local pcallDeferred = require(scriptParentParentParent.util.pcallDeferred)

local module = {
    categories = {
        ValidationEnums.UploadCategory.TORSO_AND_LIMBS,
        ValidationEnums.UploadCategory.DYNAMIC_HEAD,
        ValidationEnums.UploadCategory.LAYERED_CLOTHING,
        ValidationEnums.UploadCategory.EYEBROW_EYELASH
    },
    requiredData = { ValidationEnums.SharedDataMember.rootInstance, ValidationEnums.SharedDataMember.consumerConfig, ValidationEnums.SharedDataMember.hsrAssets },
    expectedFailures = {}
}
local function validateHSRStructure(hsrAsset, wrapLayerInstance, arg1)
    if #hsrAsset ~= 1 then
        arg1:fail(ErrorSourceStrings.Keys.HSRAssetInvalidRoot, { InstancePath = wrapLayerInstance:GetFullName() })

        return nil
    end

    local var1 = hsrAsset[1]
    if not var1:IsA("HiddenSurfaceRemovalAsset") then
        arg1:fail(ErrorSourceStrings.Keys.HSRAssetInvalidRoot, { InstancePath = wrapLayerInstance:GetFullName() })

        return nil
    end

    if not (#var1:GetDescendants() > 0) then
        return var1
    end

    arg1:fail(ErrorSourceStrings.Keys.HSRAssetHasChildren, { InstancePath = wrapLayerInstance:GetFullName() })

    return nil
end

function module.run(arg1, arg2)
    if arg2.consumerConfig.consumerEnv == ValidationEnums.ConsumerEnv.IEC then
        return
    end

    local bool1 = arg2.consumerConfig.consumerEnv == ValidationEnums.ConsumerEnv.Backend

    local descendants = arg2.rootInstance:GetDescendants()
    table.insert(descendants, arg2.rootInstance)

    for _, descendant in descendants do
        if not descendant:IsA("WrapLayer") then
            continue
        end

        local hsrAssetId = descendant.HSRAssetId

        if hsrAssetId and hsrAssetId ~= "" then
            local referenceKey

            if getFFlagUGCValidateVersionedContentIds() then
                local var1, var2 = ParseContentIds.tryParseContentId(hsrAssetId)
                if var1 then
                    referenceKey = ParseContentIds.getReferenceKey(var1, var2)
                else
                    referenceKey = nil
                end
            else
                referenceKey = ParseContentIds.tryGetAssetIdFromContentId(hsrAssetId)
            end
            if not referenceKey then
                local hsrAssetIdInvalidUrl = ErrorSourceStrings.Keys.HSRAssetIdInvalidUrl
                local tbl1 = {
                    InstancePath = descendant:GetFullName()
                }
                arg1:fail(hsrAssetIdInvalidUrl, tbl1)
            else
                local hsrAsset = arg2.hsrAssets[referenceKey]
                if hsrAsset then
                    local hsrInstance = validateHSRStructure(hsrAsset, descendant, arg1)
                    if hsrInstance then
                        local var1, var2 = pcallDeferred(function(): boolean
                            return UGCValidationService:ValidateHSRMeshIds(descendant, hsrInstance)
                        end, {})

                        if not var1 then
                            local hsrMeshIdValidationError = ErrorSourceStrings.Keys.HSRMeshIdValidationError
                            local tbl1 = {
                                InstancePath = descendant:GetFullName()
                            }
                            arg1:fail(hsrMeshIdValidationError, tbl1)
                        elseif not var2 then
                            local hsrMeshIdsMismatch = ErrorSourceStrings.Keys.HSRMeshIdsMismatch
                            local tbl1 = {
                                InstancePath = descendant:GetFullName()
                            }
                            arg1:fail(hsrMeshIdsMismatch, tbl1)
                        end
                    end
                end
            end
        elseif bool1 then
            local hsrAssetIdRequired = ErrorSourceStrings.Keys.HSRAssetIdRequired
            local tbl1 = {
                InstancePath = descendant:GetFullName()
            }
            arg1:fail(hsrAssetIdRequired, tbl1)
        end
    end
end

return module

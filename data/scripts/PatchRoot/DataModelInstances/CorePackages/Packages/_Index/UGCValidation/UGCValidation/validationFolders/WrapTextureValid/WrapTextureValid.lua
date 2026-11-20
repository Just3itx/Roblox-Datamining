-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:11:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UGCValidationService = game:GetService("UGCValidationService")

local scriptParentParentParent = script.Parent.Parent.Parent

local Constants = require(scriptParentParentParent.Constants)
local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)
local WrapTargetCageUVReferenceValues = require(scriptParentParentParent.WrapTargetCageUVReferenceValues)
local createEditableInstancesForContext = require(scriptParentParentParent.util.createEditableInstancesForContext)

local getFFlagUGCValidationAllowFullVaas = require(scriptParentParentParent.flags.getFFlagUGCValidationAllowFullVaas)
local getFFlagUGCValidateTransitionMakeupBounds = require(scriptParentParentParent.flags.getFFlagUGCValidateTransitionMakeupBounds)

local tbl1 = { Publish = true, Backend = true, Internal = true, InExpServer = true }

local tbl2 = { InExpServer = true, InExpClient = true }

local vector2 = Vector2.new(3.28941798, 0.313124001)
local vector2_2 = Vector2.new(3.71058202, 0.734287024)

local module = {
    categories = { ValidationEnums.UploadCategory.MAKEUP },
    requiredData = { ValidationEnums.SharedDataMember.rootInstance, ValidationEnums.SharedDataMember.consumerConfig },
    expectedFailures = {}
}
function module.run(arg1, arg2)
    local rootInstance = arg2.rootInstance
    local wrapTextureTransfer = rootInstance:FindFirstChildOfClass("WrapTextureTransfer")
    if wrapTextureTransfer == nil then
        error(string.format("WrapTextureTransfer child not found for %s", rootInstance.Name))
    end

    local consumerConfig = arg2.consumerConfig
    local bool1 = if getFFlagUGCValidationAllowFullVaas() and consumerConfig.isVaaS then consumerConfig.validationEnv == ValidationEnums.ValidationEnv.Backend else tbl1[consumerConfig.source] == true
    local bool2 = tbl2[consumerConfig.source] == true

    arg1:setReportingInstance(wrapTextureTransfer)

    local referenceCageMeshContent = wrapTextureTransfer.ReferenceCageMeshContent
    local bool3 = not (referenceCageMeshContent.Uri == nil) and referenceCageMeshContent.Uri ~= ""
    local preloadedEditableMeshes = arg2.consumerConfig.preloadedEditableMeshes
    local var1, var2 = createEditableInstancesForContext.getEditableInstanceInfo(
        referenceCageMeshContent,
        preloadedEditableMeshes,
        "EditableMesh",
        bool2
    )

    if not (var1 and var2 and var2.instance) then
        if not bool3 then
            arg1:fail(ErrorSourceStrings.Keys.WrapTexture_NoCage, { instanceName = wrapTextureTransfer:GetFullName() })
            return
        end

        if bool1 then
            arg1:forceError(string.format("Failed to load ReferenceCageContent for %s", wrapTextureTransfer:GetFullName()))
        end

        arg1:fail(ErrorSourceStrings.Keys.WrapTexture_FailedToLoadCage, { instanceName = wrapTextureTransfer:GetFullName() })

        return
    end

    local instance = var2.instance

    local success, result = pcall(function(): boolean
        return UGCValidationService:ValidateEditableMeshUVValuesInReference(WrapTargetCageUVReferenceValues.Head, instance)
    end)

    if not success then
        if bool1 then
            arg1:forceError(
                string.format(
                    "Failed to load UVs for '%s'. Make sure the UV map exists and try again.",
                    wrapTextureTransfer:GetFullName()
                )
            )
        end

        arg1:fail(ErrorSourceStrings.Keys.WrapTexture_FailedToLoadUV, { instanceName = wrapTextureTransfer:GetFullName() })
        return
    end

    if not result then
        arg1:fail(ErrorSourceStrings.Keys.WrapTexture_InvalidUV, { instanceName = wrapTextureTransfer:GetFullName() })
        return
    end

    local makeupInfo = Constants.MAKEUP_INFO
    local var3 = if getFFlagUGCValidateTransitionMakeupBounds() then wrapTextureTransfer.UVMinBound:FuzzyEq(vector2) and wrapTextureTransfer.UVMaxBound:FuzzyEq(vector2_2) else false

    if not var3 then
        if not wrapTextureTransfer.UVMinBound:FuzzyEq(makeupInfo.WrapTextureTransferUVBounds.MinBound) then
            local wrapTextureInvalidMinBound = ErrorSourceStrings.Keys.WrapTexture_InvalidMinBound
            local tbl3 = {
                instanceName = wrapTextureTransfer:GetFullName(),
                actual = tostring(wrapTextureTransfer.UVMinBound),
                expected = tostring(makeupInfo.WrapTextureTransferUVBounds.MinBound)
            }
            arg1:fail(wrapTextureInvalidMinBound, tbl3)

            return
        end
        if not wrapTextureTransfer.UVMaxBound:FuzzyEq(makeupInfo.WrapTextureTransferUVBounds.MaxBound) then
            local wrapTextureInvalidMaxBound = ErrorSourceStrings.Keys.WrapTexture_InvalidMaxBound
            local tbl3 = {
                instanceName = wrapTextureTransfer:GetFullName(),
                actual = tostring(wrapTextureTransfer.UVMaxBound),
                expected = tostring(makeupInfo.WrapTextureTransferUVBounds.MaxBound)
            }
            arg1:fail(wrapTextureInvalidMaxBound, tbl3)

            if getFFlagUGCValidateTransitionMakeupBounds() then
                return
            end
        end
    end

    if not getFFlagUGCValidateTransitionMakeupBounds() or not bool1 then
        return
    end

    if var3 then
        arg1:setTelemetryContext("makeupBounds=Old")
        return
    end
    arg1:setTelemetryContext("makeupBounds=New")
end

return module

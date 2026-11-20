-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:01:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UGCValidationService = game:GetService("UGCValidationService")

local scriptParentParentParent = script.Parent.Parent.Parent

local Constants = require(scriptParentParentParent.Constants)
local ConstantsInterface = require(scriptParentParentParent.ConstantsInterface)
local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)
local createEditableInstancesForContext = require(scriptParentParentParent.util.createEditableInstancesForContext)

local getFFlagUGCValidateDecalTextureLimits = require(scriptParentParentParent.flags.getFFlagUGCValidateDecalTextureLimits)
local getFFlagUGCValidationAllowFullVaas = require(scriptParentParentParent.flags.getFFlagUGCValidationAllowFullVaas)

local num1 = game:DefineFastInt("ValidateMakeupZoneIncludeToleranceHundredthsPercent", 100)

local num2 = game:DefineFastInt("ValidateMakeupZoneExcludeHundredthsPercent", 200)

local tbl1 = { Publish = true, Backend = true, Internal = true, InExpServer = true }

local tbl2 = { InExpServer = true, InExpClient = true }

local module = {
    categories = { ValidationEnums.UploadCategory.MAKEUP },
    requiredData = { ValidationEnums.SharedDataMember.rootInstance, ValidationEnums.SharedDataMember.consumerConfig, ValidationEnums.SharedDataMember.uploadEnum },
    expectedFailures = {}
}

local function validateTextureSize(arg1, editableImage: EditableImage, fullName: string, fieldName: string, num3: number, bool1: boolean)
    local success, result = pcall(function(): Vector2
        return UGCValidationService:GetEditableImageSize(editableImage)
    end)

    if not success then
        if bool1 then
            arg1:forceError(
                string.format("Failed to load texture data for '%s'. Make sure the texture exists and try again.", fullName)
            )
        end

        arg1:fail(ErrorSourceStrings.Keys.MakeupDecal_FailedToLoadTextureData, { fullName = fullName })

        return
    end

    if not (num3 < result.X) and not (num3 < result.Y) then
        return
    end

    local makeupDecalTextureTooBig = ErrorSourceStrings.Keys.MakeupDecal_TextureTooBig
    local tbl3 = {
        sizeX = tostring(result.X),
        sizeY = tostring(result.Y),
        fullName = fullName,
        maxSize = tostring(num3),
        fieldName = fieldName
    }
    arg1:fail(makeupDecalTextureTooBig, tbl3)
end

local function validateCoverageOutsideIncludeBounds(arg1, rootInstance, arg2, vector2: Vector2, vector2_2: Vector2, arg3, assetTypeName: string)
    local var1 = (vector2_2.X - vector2.X) * (vector2_2.Y - vector2.Y) * num1 / 10000 * 255

    local num3 = 0

    local buf = arg2:ReadPixelsBuffer(Vector2.new(0, 0), arg2.Size)
    local num4 = 0
    local var2 = arg2.Size.Y - 1
    for i = 0, buffer.len(buf) - 1, 4 do
        if num4 == arg2.Size.X then
            var2 -= 1
            num4 = 0
        end

        local num5 = buffer.readu8(buf, i + 3)
        if num5 > 0 and (num4 < vector2.X or var2 < vector2.Y or vector2_2.X < num4 or vector2_2.Y < var2) then
            num3 += num5
        end

        num4 += 1
    end

    if not (var1 < num3) then
        return
    end

    local makeupDecalUvZoneIncludeViolation = ErrorSourceStrings.Keys.MakeupDecal_UVZoneIncludeViolation
    local tbl3 = {
        instanceName = rootInstance.Name,
        minBound = tostring(arg3.MinBound),
        maxBound = tostring(arg3.MaxBound),
        assetTypeName = assetTypeName
    }
    arg1:fail(makeupDecalUvZoneIncludeViolation, tbl3)
end

local function validateCoverageInsideExcludeBounds(arg1, rootInstance, arg2, vector2: Vector2, vector2_2: Vector2, arg3, assetTypeName: string)
    local var1 = (vector2_2.X - vector2.X) * (vector2_2.Y - vector2.Y) * num2 / 10000 * 255

    local num3 = 0

    local buf = arg2:ReadPixelsBuffer(Vector2.new(0, 0), arg2.Size)
    local num4 = 0
    local var2 = arg2.Size.Y - 1
    for i = 0, buffer.len(buf) - 1, 4 do
        if num4 == arg2.Size.X then
            var2 -= 1
            num4 = 0
        end

        local num5 = buffer.readu8(buf, i + 3)
        if num5 > 0 and vector2.X < num4 and vector2.Y < var2 and num4 < vector2_2.X and var2 < vector2_2.Y then
            num3 += num5
        end

        num4 += 1
    end

    if not (var1 < num3) then
        return
    end

    local makeupDecalUvZoneExcludeViolation = ErrorSourceStrings.Keys.MakeupDecal_UVZoneExcludeViolation
    local tbl3 = {
        instanceName = rootInstance.Name,
        minBound = tostring(arg3.MinBound),
        maxBound = tostring(arg3.MaxBound),
        assetTypeName = assetTypeName
    }
    arg1:fail(makeupDecalUvZoneExcludeViolation, tbl3)
end

local function validateUVZones(arg1, rootInstance, arg2, wrapTextureTransfer: WrapTextureTransfer, assetUvBound, name: string)
    local var1 = wrapTextureTransfer.UVMaxBound - wrapTextureTransfer.UVMinBound

    for _, value in assetUvBound do
        local var2 = (value.MinBound - wrapTextureTransfer.UVMinBound) / var1
        local var3 = (value.MaxBound - wrapTextureTransfer.UVMinBound) / var1

        local var4 = var2 * arg2.Size
        local var5 = var3 * arg2.Size

        if value.isIncludeBound then
            validateCoverageOutsideIncludeBounds(arg1, rootInstance, arg2, var4, var5, value, name)
        else
            validateCoverageInsideExcludeBounds(arg1, rootInstance, arg2, var4, var5, value, name)
        end
    end
end

function module.run(arg1, arg2)
    local rootInstance = arg2.rootInstance
    local assetType = arg2.uploadEnum.assetType
    local consumerConfig = arg2.consumerConfig
    local bool1 = if getFFlagUGCValidationAllowFullVaas() and consumerConfig.isVaaS then consumerConfig.validationEnv == ValidationEnums.ValidationEnv.Backend else tbl1[consumerConfig.source] == true
    local wrapTextureTransfer = rootInstance:FindFirstChildOfClass("WrapTextureTransfer")
    if wrapTextureTransfer == nil then
        error(string.format("WrapTextureTransfer child not found for %s", rootInstance.Name))
    end

    arg1:setReportingInstance(rootInstance)

    local preloadedEditableImages = arg2.consumerConfig.preloadedEditableImages

    local bool2 = tbl2[consumerConfig.source] == true

    local decal = Constants.TEXTURE_CONTENT_ID_FIELDS.Decal
    if not decal then
        error("No texture content ID fields defined for Decal class")
    end

    local var1 = nil

    for _, fieldName in decal do
        local var2 = rootInstance[fieldName .. "Content"]
        if (not var2 or var2.Uri == nil or var2.Uri == "") and not (bool2 and var2 and var2.Object) then
            continue
        end

        local var3, var4 = createEditableInstancesForContext.getEditableInstanceInfo(var2, preloadedEditableImages, "EditableImage", bool2)

        if not (var3 and var4 and var4.instance) then
            if bool1 then
                arg1:forceError(string.format("Failed to load %s for Decal %s", fieldName, rootInstance.Name))
            end
            local makeupDecalFailedToLoadTexture = ErrorSourceStrings.Keys.MakeupDecal_FailedToLoadTexture
            local tbl3 = {
                fieldName = fieldName,
                instanceName = rootInstance.Name
            }
            arg1:fail(makeupDecalFailedToLoadTexture, tbl3)
        else
            local instance = var4.instance

            if fieldName == "ColorMap" then
                var1 = instance
            end

            local maxTextureSize = Constants.MAX_TEXTURE_SIZE
            if getFFlagUGCValidateDecalTextureLimits() and assetType then
                maxTextureSize = ConstantsInterface.getTextureLimit(assetType, rootInstance, fieldName)
            end

            local fullName = rootInstance:GetFullName() .. "." .. fieldName
            validateTextureSize(arg1, instance, fullName, fieldName, maxTextureSize, bool1)
        end
    end
    if not var1 then
        arg1:fail(ErrorSourceStrings.Keys.MakeupDecal_NoColorMap, { instanceName = rootInstance.Name })

        return
    end

    local assetUvBound = Constants.MAKEUP_INFO.AssetUVBounds[assetType]
    if assetUvBound then
        validateUVZones(arg1, rootInstance, var1, wrapTextureTransfer, assetUvBound, assetType.Name)
    end
end

return module

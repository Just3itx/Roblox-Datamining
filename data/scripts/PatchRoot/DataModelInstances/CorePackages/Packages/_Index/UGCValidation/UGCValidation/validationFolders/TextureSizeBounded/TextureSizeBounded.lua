-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:11:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UGCValidationService = game:GetService("UGCValidationService")

local scriptParentParentParent = script.Parent.Parent.Parent

local ConstantsInterface = require(scriptParentParentParent.ConstantsInterface)
local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)
local FetchAllDesiredData = require(scriptParentParentParent.validationSystem.dataFetchModules.FetchAllDesiredData)

local module = {
    categories = {
        ValidationEnums.UploadCategory.TORSO_AND_LIMBS,
        ValidationEnums.UploadCategory.DYNAMIC_HEAD,
        ValidationEnums.UploadCategory.LAYERED_CLOTHING,
        ValidationEnums.UploadCategory.EYEBROW_EYELASH,
        ValidationEnums.UploadCategory.RIGID_ACCESSORY
    },
    requiredData = {},
    conditionalData = { ValidationEnums.SharedDataMember.meshTextures },
    expectedFailures = {}
}
local function checkEditableImageSize(editableImage: EditableImage, textureLimit: number, fullName: string, fieldName: string, arg1, arg2, consumerConfig)
    local success, result = pcall(function(): Vector2
        return UGCValidationService:GetEditableImageSize(editableImage)
    end)

    if not success then
        if consumerConfig and consumerConfig.validationEnv == ValidationEnums.ValidationEnv.Backend then
            arg1:fetchError(
                string.format("Failed to get texture size for '%s'. Make sure the texture exists and try again.", fullName)
            )
        end

        arg1:fail(ErrorSourceStrings.Keys.TextureSize_FailedToLoad, { FullName = fullName }, arg2)

        return
    end

    if not (textureLimit < result.X) and not (textureLimit < result.Y) then
        return
    end

    local textureSizeTooBig = ErrorSourceStrings.Keys.TextureSize_TooBig
    local tbl1 = {
        Width = tostring(result.X),
        Height = tostring(result.Y),
        FullName = fullName,
        MaxSize = tostring(textureLimit),
        FieldName = fieldName
    }
    arg1:fail(textureSizeTooBig, tbl1, arg2)
end

function module.run(arg1, arg2)
    local rootInstance = arg2.rootInstance
    local assetType = arg2.uploadEnum.assetType
    local meshTextures = arg2.meshTextures
    local consumerConfig = arg2.consumerConfig
    local uploadCategory = arg2.uploadCategory

    if not meshTextures or meshTextures == FetchAllDesiredData.DATA_FETCH_FAILURE then
        arg1:fetchError("Failed to load texture data for texture size check")
        return
    end

    local descendants = rootInstance:GetDescendants()
    table.insert(descendants, rootInstance)

    for _, descendant in descendants do
        local var1 = nil
        local str1 = ""

        if descendant:IsA("MeshPart") then
            str1 = descendant.Name
            var1 = descendant
        elseif descendant:IsA("Part") then
            local specialMesh = descendant:FindFirstChildOfClass("SpecialMesh")
            if specialMesh then
                str1 = descendant.Name
                var1 = specialMesh
            end
        end

        if not var1 then
            continue
        end

        local var2 = meshTextures[str1]
        if not var2 then
            continue
        end

        local bool1 = uploadCategory == ValidationEnums.UploadCategory.TORSO_AND_LIMBS
            or uploadCategory == ValidationEnums.UploadCategory.DYNAMIC_HEAD
        if var2.isPBR and bool1 then
            local surfaceAppearance = var1:FindFirstChildWhichIsA("SurfaceAppearance")
            if surfaceAppearance then
                for _, value in {
                    "ColorMap",
                    "MetalnessMap",
                    "NormalMap",
                    "RoughnessMap",
                    "EmissiveMask"
                } do
                    local var3 = var2[value]
                    if var3 and var3.editable then
                        local textureLimit = ConstantsInterface.getTextureLimit(assetType, surfaceAppearance, value)
                        checkEditableImageSize(
                            var3.editable,
                            textureLimit,
                            surfaceAppearance:GetFullName() .. "." .. value,
                            value,
                            arg1,
                            surfaceAppearance,
                            consumerConfig
                        )
                    end
                end
            end
        elseif not var2.isPBR and var2.Texture and var2.Texture.editable then
            local str2 = if var1:IsA("MeshPart") then "TextureID" else "TextureId"

            local textureLimit = ConstantsInterface.getTextureLimit(assetType, var1, str2)
            checkEditableImageSize(var2.Texture.editable, textureLimit, var1:GetFullName(), str2, arg1, var1, consumerConfig)
        end
    end
end

return module

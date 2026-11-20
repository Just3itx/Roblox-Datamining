-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:11:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UGCValidationService = game:GetService("UGCValidationService")

local scriptParentParentParent = script.Parent.Parent.Parent

local ConstantsInterface = require(scriptParentParentParent.ConstantsInterface)
local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)
local FetchAllDesiredData = require(scriptParentParentParent.validationSystem.dataFetchModules.FetchAllDesiredData)

local tbl1 = {
    ColorMap = game:DefineFastInt("AccessoryColorMapMaxSize", 1024),
    MetalnessMap = game:DefineFastInt("AccessoryMetalnessMapMaxSize", 256),
    NormalMap = game:DefineFastInt("AccessoryNormalMapMaxSize", 256),
    RoughnessMap = game:DefineFastInt("AccessoryRoughnessMapMaxSize", 256)
}

local module = {
    categories = { ValidationEnums.UploadCategory.RIGID_ACCESSORY, ValidationEnums.UploadCategory.LAYERED_CLOTHING, ValidationEnums.UploadCategory.EYEBROW_EYELASH },
    requiredData = {},
    conditionalData = { ValidationEnums.SharedDataMember.meshTextures },
    expectedFailures = {}
}
function module.run(arg1, arg2)
    local rootInstance = arg2.rootInstance
    local assetType = arg2.uploadEnum.assetType
    local meshTextures = arg2.meshTextures
    local consumerConfig = arg2.consumerConfig

    if not meshTextures or meshTextures == FetchAllDesiredData.DATA_FETCH_FAILURE then
        arg1:fetchError("Failed to load texture data for surface appearance texture bounds check")
        return
    end

    local bool1 = consumerConfig.validationEnv == ValidationEnums.ValidationEnv.Backend

    local descendants = rootInstance:GetDescendants()
    table.insert(descendants, rootInstance)

    for _, descendant in descendants do
        if not descendant:IsA("MeshPart") then
            continue
        end

        local surfaceAppearance = descendant:FindFirstChildWhichIsA("SurfaceAppearance")
        if not surfaceAppearance then
            continue
        end

        local var1 = meshTextures[descendant.Name]
        if not (var1 and var1.isPBR) then
            continue
        end

        for _, fieldName in {
            "ColorMap",
            "MetalnessMap",
            "NormalMap",
            "RoughnessMap",
            "EmissiveMask"
        } do
            local var2 = var1[fieldName]
            if not (var2 and var2.editable) then
                continue
            end

            local var3 = if assetType then ConstantsInterface.getTextureLimit(assetType, surfaceAppearance, fieldName) else tbl1[fieldName]

            local success, result = pcall(function(): Vector2
                return UGCValidationService:GetEditableImageSize(var2.editable)
            end)

            if not success then
                if bool1 then
                    arg1:fetchError(
                        string.format(
                            "Failed to get texture size for '%s'. Make sure the texture exists and try again.",
                            surfaceAppearance:GetFullName() .. "." .. fieldName
                        )
                    )
                end
                local textureSizeFailedToLoad = ErrorSourceStrings.Keys.TextureSize_FailedToLoad
                local tbl2 = {
                    FullName = surfaceAppearance:GetFullName() .. "." .. fieldName
                }
                arg1:fail(textureSizeFailedToLoad, tbl2, surfaceAppearance)
            elseif var3 < result.X or var3 < result.Y then
                local textureSizeTooBig = ErrorSourceStrings.Keys.TextureSize_TooBig
                local tbl2 = {
                    Width = tostring(result.X),
                    Height = tostring(result.Y),
                    FullName = surfaceAppearance:GetFullName() .. "." .. fieldName,
                    MaxSize = tostring(var3),
                    FieldName = fieldName
                }
                arg1:fail(textureSizeTooBig, tbl2, surfaceAppearance)
            end
        end
    end
end

return module

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:01:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local AssetService = game:GetService("AssetService")

local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)

local getFFlagUGCValidateEmissiveAreaChecks = require(scriptParentParentParent.flags.getFFlagUGCValidateEmissiveAreaChecks)
local getFIntUGCValidateMaxEmissivePercentageBody = require(scriptParentParentParent.flags.getFIntUGCValidateMaxEmissivePercentageBody)

local getFIntUGCValidateMaxEmissivePercentageDynamicHead = require(scriptParentParentParent.flags.getFIntUGCValidateMaxEmissivePercentageDynamicHead)

local getFIntUGCValidateMaxEmissiveAreaRigidAccessory = require(scriptParentParentParent.flags.getFIntUGCValidateMaxEmissiveAreaRigidAccessory)

local getFIntUGCValidateMaxEmissiveAreaLayeredClothing = require(scriptParentParentParent.flags.getFIntUGCValidateMaxEmissiveAreaLayeredClothing)

local getFIntUGCValidateEmissiveR15BlockyBoundingBoxVolume = require(scriptParentParentParent.flags.getFIntUGCValidateEmissiveR15BlockyBoundingBoxVolume)

local getFIntUGCValidationMaxEmissiveStrengthForAreaChecks = require(scriptParentParentParent.flags.getFIntUGCValidationMaxEmissiveStrengthForAreaChecks)
local getFFlagUGCValidateEmissiveFixAreaChecks = require(scriptParentParentParent.flags.getFFlagUGCValidateEmissiveFixAreaChecks)

local getFFlagUGCValidateEmissiveAreaChecksFixedAlgo = require(scriptParentParentParent.flags.getFFlagUGCValidateEmissiveAreaChecksFixedAlgo)

local module = {
    fflag = getFFlagUGCValidateEmissiveAreaChecks,
    categories = {
        ValidationEnums.UploadCategory.TORSO_AND_LIMBS,
        ValidationEnums.UploadCategory.DYNAMIC_HEAD,
        ValidationEnums.UploadCategory.LAYERED_CLOTHING,
        ValidationEnums.UploadCategory.EYEBROW_EYELASH,
        ValidationEnums.UploadCategory.RIGID_ACCESSORY
    },
    requiredData = {
        ValidationEnums.SharedDataMember.renderMeshesData,
        ValidationEnums.SharedDataMember.innerCagesData,
        ValidationEnums.SharedDataMember.meshTextures,
        ValidationEnums.SharedDataMember.rootInstance,
        ValidationEnums.SharedDataMember.uploadCategory
    },
    expectedFailures = {}
}
local function getEmissiveStrength(arg1, name: string) -- Luacid: Inlined by compiler; 4 call sites recovered
    local rootInstance = arg1.rootInstance
    if rootInstance.Name ~= name then
        rootInstance = arg1.rootInstance:FindFirstChild(name, true)
    end
    if not rootInstance then
        return 0
    end
    local var1 = rootInstance:FindFirstChildWhichIsA("SurfaceAppearance", true)
    return if var1 then var1.EmissiveStrength else 0
end

local function getWeightedAreaForTextures(arg1, editable, arg2)
    local editable2 = arg1.editable
    local editableSize = editable.Size
    local buf = editable:ReadPixelsBuffer(Vector2.zero, editableSize)
    local buf2 = if arg2 then arg2:ReadPixelsBuffer(Vector2.zero, arg2.Size) else nil
    local num1 = 0
    local num2 = 0

    for _, value in editable2:GetFaces() do
        local faceVertices = editable2:GetFaceVertices(value)
        local position = editable2:GetPosition(faceVertices[1])
        local var1 = ((editable2:GetPosition(faceVertices[2]) - position) * arg1.scale):Cross(
            (editable2:GetPosition(faceVertices[3]) - position) * arg1.scale
        ).Magnitude * 0.5
        if var1 == 0 then
            continue
        end

        num2 += var1

        local faceUVs = editable2:GetFaceUVs(value)
        local uV = editable2:GetUV(faceUVs[1])
        local uV2 = editable2:GetUV(faceUVs[2])
        local uV3 = editable2:GetUV(faceUVs[3])
        if not (uV and uV2 and uV3) then
            continue
        end

        local var2 = (uV + uV2 + uV3) / 3
        local num3 = math.floor(var2.X % 1 * editableSize.X)
        local num4 = buffer.readu8(buf, (math.floor(var2.Y % 1 * editableSize.Y) * editableSize.X + num3) * 4)
        local var3

        if arg2 then
            local size = arg2.Size
            local num5 = math.floor(var2.X % 1 * size.X)
            local offset = (math.floor(var2.Y % 1 * size.Y) * size.X + num5) * 4
            local num6 = buffer.readu8(buf2, offset)
            local num7 = buffer.readu8(buf2, offset + 1)
            local num8 = buffer.readu8(buf2, offset + 2)
            var3 = (num6 + num7 + num8) / 765
        else
            var3 = 1
        end

        num1 += var1 * num4 * var3
    end

    return num1 / 255, num2
end

local function getTotalEmissiveSurfaceArea(arg1, editable)
    local editable2 = arg1.editable
    local editableSize = editable.Size
    local buf = editable:ReadPixelsBuffer(Vector2.zero, editableSize)
    local num1 = 0
    local num2 = 0

    for _, value in editable2:GetFaces() do
        local faceVertices = editable2:GetFaceVertices(value)
        local position = editable2:GetPosition(faceVertices[1])
        local var1 = ((editable2:GetPosition(faceVertices[2]) - position) * arg1.scale):Cross(
            (editable2:GetPosition(faceVertices[3]) - position) * arg1.scale
        ).Magnitude * 0.5
        if var1 == 0 then
            continue
        end

        local faceUVs = editable2:GetFaceUVs(value)
        local uV = editable2:GetUV(faceUVs[1])
        local uV2 = editable2:GetUV(faceUVs[2])
        local uV3 = editable2:GetUV(faceUVs[3])
        if not (uV and uV2 and uV3) then
            continue
        end

        local var2 = (uV + uV2 + uV3) / 3
        local num3 = math.floor(var2.X % 1 * editableSize.X)
        local num4 = buffer.readu8(buf, (math.floor(var2.Y % 1 * editableSize.Y) * editableSize.X + num3) * 4)

        num1 += var1
        num2 += var1 * num4
    end

    return num2 / 255, num1
end

local function getEmissiveFraction(arg1, editable, arg2, name: string) -- Luacid: Inlined by compiler; 1 call site recovered
    local var1, var2 = getTotalEmissiveSurfaceArea(arg1, editable)

    if var2 > 0 then
        return var1 / var2 * getEmissiveStrength(arg2, name) / getFIntUGCValidationMaxEmissiveStrengthForAreaChecks()
    end

    return 0
end

local function getTotalEmissiveArea(arg1, arg2, arg3, str1: string) -- Luacid: Inlined by compiler; 1 call site recovered
    local editable = arg2.editable
    local colorMap = arg3.meshTextures[str1].ColorMap
    local editable2 = if colorMap then colorMap.editable else nil
    return getWeightedAreaForTextures(arg1, editable, editable2)
end

local function runEmissiveAreaChecks(arg1, arg2)
    for meshName, value2 in arg2.renderMeshesData do
        local var1 = arg2.meshTextures[meshName]
        local emissiveMask = if var1 then var1.EmissiveMask else nil

        if not emissiveMask then
            continue
        end

        local assetTypeName = arg2.uploadEnum.assetType.Name
        local var2, var3 = getTotalEmissiveArea(value2, emissiveMask, arg2, meshName)
        local emissiveStrength = var1.EmissiveStrength
        local emissiveTint = var1.EmissiveTint
        local var4 = (emissiveTint.R + emissiveTint.G + emissiveTint.B) / 3
        local var5 = emissiveStrength / getFIntUGCValidationMaxEmissiveStrengthForAreaChecks()
        local var6 = var2 * var4 * var5

        if arg2.uploadCategory == ValidationEnums.UploadCategory.RIGID_ACCESSORY then
            if getFIntUGCValidateMaxEmissiveAreaRigidAccessory() < var6 then
                local emissiveAreaSurfaceAreaExceededNew = ErrorSourceStrings.Keys.EmissiveArea_SurfaceAreaExceededNew
                local tbl1 = {
                    assetTypeName = assetTypeName,
                    emissiveArea = string.format("%.2f", var6),
                    maxEmissiveArea = tostring(getFIntUGCValidateMaxEmissiveAreaRigidAccessory())
                }
                arg1:fail(emissiveAreaSurfaceAreaExceededNew, tbl1)
            end
        elseif arg2.uploadCategory == ValidationEnums.UploadCategory.TORSO_AND_LIMBS
            or arg2.uploadCategory == ValidationEnums.UploadCategory.DYNAMIC_HEAD
        then
            local var7 = var6 / var3
            local fIntUgcValidateMaxEmissivePercentageBody = getFIntUGCValidateMaxEmissivePercentageBody()
            if arg2.uploadCategory == ValidationEnums.UploadCategory.DYNAMIC_HEAD then
                fIntUgcValidateMaxEmissivePercentageBody = getFIntUGCValidateMaxEmissivePercentageDynamicHead()
            end
            if fIntUgcValidateMaxEmissivePercentageBody / 100 < var7 then
                local emissiveAreaAboveThresholdNew = ErrorSourceStrings.Keys.EmissiveArea_AboveThresholdNew
                local tbl1 = {
                    meshName = meshName,
                    emissivePercentage = string.format("%.2f", var7 * 100),
                    maxEmissivePercentage = tostring(fIntUgcValidateMaxEmissivePercentageBody)
                }
                arg1:fail(emissiveAreaAboveThresholdNew, tbl1)
            end
        else
            local var7 = arg2.innerCagesData[meshName]
            local model = Instance.new("Model")
            AssetService:CreateMeshPartAsync(Content.fromObject(var7.editable)).Parent = model
            local _, var8 = model:GetBoundingBox()
            local var9 = var8.X * var8.Y * var8.Z
            local var10 = var6 * (getFIntUGCValidateEmissiveR15BlockyBoundingBoxVolume() / var9) ^ (2 / 3)

            if getFIntUGCValidateMaxEmissiveAreaLayeredClothing() < var10 then
                local emissiveAreaSurfaceAreaExceededNew = ErrorSourceStrings.Keys.EmissiveArea_SurfaceAreaExceededNew
                local tbl1 = {
                    assetTypeName = assetTypeName,
                    emissiveArea = string.format("%.2f", var10),
                    maxEmissiveArea = tostring(getFIntUGCValidateMaxEmissiveAreaLayeredClothing())
                }
                arg1:fail(emissiveAreaSurfaceAreaExceededNew, tbl1)
            end
        end
    end
end

function module.run(arg1, arg2)
    if getFFlagUGCValidateEmissiveAreaChecksFixedAlgo() then
        runEmissiveAreaChecks(arg1, arg2)
        return
    end
    for meshName, value2 in arg2.renderMeshesData do
        local var1 = arg2.meshTextures[meshName]
        local emissiveMask = if var1 then var1.EmissiveMask else nil

        if not emissiveMask then
            continue
        end

        if arg2.uploadCategory == ValidationEnums.UploadCategory.RIGID_ACCESSORY then
            local totalEmissiveSurfaceArea = getTotalEmissiveSurfaceArea(value2, emissiveMask.editable)
            if getFFlagUGCValidateEmissiveFixAreaChecks() then
                totalEmissiveSurfaceArea = totalEmissiveSurfaceArea * getEmissiveStrength(arg2, meshName) / getFIntUGCValidationMaxEmissiveStrengthForAreaChecks()
            end
            if getFIntUGCValidateMaxEmissiveAreaRigidAccessory() < totalEmissiveSurfaceArea then
                local emissiveAreaSurfaceAreaExceeded = ErrorSourceStrings.Keys.EmissiveArea_SurfaceAreaExceeded
                local tbl1 = {
                    meshName = meshName,
                    emissiveArea = string.format("%.2f", totalEmissiveSurfaceArea),
                    maxEmissiveArea = tostring(getFIntUGCValidateMaxEmissiveAreaRigidAccessory())
                }
                arg1:fail(emissiveAreaSurfaceAreaExceeded, tbl1)
            end
        elseif arg2.uploadCategory == ValidationEnums.UploadCategory.TORSO_AND_LIMBS
            or arg2.uploadCategory == ValidationEnums.UploadCategory.DYNAMIC_HEAD
        then
            local emissiveFraction = getEmissiveFraction(value2, emissiveMask.editable, arg2, meshName)
            local fIntUgcValidateMaxEmissivePercentageBody = getFIntUGCValidateMaxEmissivePercentageBody()
            if arg2.uploadCategory == ValidationEnums.UploadCategory.DYNAMIC_HEAD then
                fIntUgcValidateMaxEmissivePercentageBody = getFIntUGCValidateMaxEmissivePercentageDynamicHead()
            end
            if fIntUgcValidateMaxEmissivePercentageBody / 100 < emissiveFraction then
                local emissiveAreaAboveThreshold = ErrorSourceStrings.Keys.EmissiveArea_AboveThreshold
                local tbl1 = {
                    meshName = meshName,
                    emissivePercentage = string.format("%.2f", emissiveFraction * 100),
                    maxEmissivePercentage = tostring(fIntUgcValidateMaxEmissivePercentageBody)
                }
                arg1:fail(emissiveAreaAboveThreshold, tbl1)
            end
        else
            local var2 = arg2.innerCagesData[meshName]
            local model = Instance.new("Model")
            AssetService:CreateMeshPartAsync(Content.fromObject(var2.editable)).Parent = model
            local _, var3 = model:GetBoundingBox()
            local var4 = var3.X * var3.Y * var3.Z
            local var5 = ((getFIntUGCValidateEmissiveR15BlockyBoundingBoxVolume() / var4) ^ (1 / 3)) ^ 2
            local totalEmissiveSurfaceArea = getTotalEmissiveSurfaceArea(value2, emissiveMask.editable)
            if getFFlagUGCValidateEmissiveFixAreaChecks() then
                totalEmissiveSurfaceArea = totalEmissiveSurfaceArea * getEmissiveStrength(arg2, meshName) / getFIntUGCValidationMaxEmissiveStrengthForAreaChecks()
            end
            local var6 = totalEmissiveSurfaceArea * var5

            if getFIntUGCValidateMaxEmissiveAreaLayeredClothing() < var6 then
                local emissiveAreaSurfaceAreaExceeded = ErrorSourceStrings.Keys.EmissiveArea_SurfaceAreaExceeded
                local tbl1 = {
                    meshName = meshName,
                    emissiveArea = string.format("%.2f", var6),
                    maxEmissiveArea = tostring(getFIntUGCValidateMaxEmissiveAreaLayeredClothing())
                }
                arg1:fail(emissiveAreaSurfaceAreaExceeded, tbl1)
            end
        end
    end
end

return module

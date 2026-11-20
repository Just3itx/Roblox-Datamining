-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:10:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UGCValidationService = game:GetService("UGCValidationService")

local scriptParentParentParent = script.Parent.Parent.Parent

local Constants = require(scriptParentParentParent.Constants)
local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)

local getAccessoryScale = require(scriptParentParentParent.util.getAccessoryScale)
local getAttachment = require(scriptParentParentParent.util.getAttachment)
local getMeshMinMax = require(scriptParentParentParent.util.getMeshMinMax)
local isMeshPartAccessory = require(scriptParentParentParent.util.isMeshPartAccessory)
local valueToString = require(scriptParentParentParent.util.valueToString)
local getFFlagUGCValidateMeshMaxScale = require(scriptParentParentParent.flags.getFFlagUGCValidateMeshMaxScale)
local getFFlagUGCValidateMeshScaleErrorMessage = require(scriptParentParentParent.flags.getFFlagUGCValidateMeshScaleErrorMessage)

local getFIntUGCValidateMeshCenteringHundredsThreshold = require(scriptParentParentParent.flags.getFIntUGCValidateMeshCenteringHundredsThreshold)

local bool1 = game:DefineFastFlag("LegacyAccessoryCheckAvatarPartScaleType", false)

local bool2 = game:DefineFastFlag("MeshpartAccessoryCheckAvatarPartScaleType", false)

local num1 = game:DefineFastInt("UGCValidationScaleMinimumThousandths", 10)
local num2 = game:DefineFastInt("FIntUGCValidationScaleMaximumThousandths", 10000)

local module = {
    categories = { ValidationEnums.UploadCategory.LAYERED_CLOTHING, ValidationEnums.UploadCategory.EYEBROW_EYELASH, ValidationEnums.UploadCategory.RIGID_ACCESSORY },
    requiredData = { ValidationEnums.SharedDataMember.renderMeshesData },
    expectedFailures = {}
}
local function pointInBounds(vec1: vector, cFrame: CFrame, vec2: vector): boolean
    local localPoint = cFrame:PointToObjectSpace(vec1)

    if localPoint.X >= -vec2.X / 2
        and localPoint.X <= vec2.X / 2
        and localPoint.Y >= -vec2.Y / 2
        and localPoint.Y <= vec2.Y / 2
        and localPoint.Z >= -vec2.Z / 2
    then
        return localPoint.Z <= vec2.Z / 2
    end

    return false
end

local function truncate(num3: number): number -- Luacid: Inlined by compiler; 6 call sites recovered
    return math.floor(num3 * 100) / 100
end

function module.run(arg1, arg2)
    local rootInstance = arg2.rootInstance
    local assetType = arg2.uploadEnum.assetType
    local isServer = arg2.consumerConfig.validationEnv == ValidationEnums.ValidationEnv.Backend

    local var1 = Constants.ASSET_TYPE_INFO[assetType]
    if not var1 then
        return
    end

    local handle = rootInstance:FindFirstChild("Handle")
    if not handle then
        return
    end

    local handle2 = arg2.renderMeshesData.Handle
    if not handle2 then
        return
    end

    local attachment = getAttachment(handle, var1.attachmentNames)
    if not attachment then
        return
    end

    local bound = var1.bounds[attachment.Name]
    if not bound then
        return
    end

    local scale = handle2.scale
    local size = bound.size
    local offset = bound.offset or Vector3.new(0, 0, 0)

    if arg2.uploadCategory == ValidationEnums.UploadCategory.RIGID_ACCESSORY then
        local bool4 = if isMeshPartAccessory(rootInstance) then bool2 else bool1

        if bool4 and handle:FindFirstChild("AvatarPartScaleType") then
            local accessoryScale = getAccessoryScale(handle, attachment)
            size /= accessoryScale
            if bound.offset then
                offset = bound.offset / accessoryScale
            else
                offset = Vector3.new(0, 0, 0)
            end
        end
    end
    local cFrame = handle.CFrame * attachment.CFrame * CFrame.new(offset)

    if handle.Position.X > 10000
        or handle.Position.X < -10000
        or handle.Position.Y > 10000
        or handle.Position.Y < -10000
        or handle.Position.Z > 10000
        or handle.Position.Z < -10000
        or cFrame.Position.X > 10000
        or cFrame.Position.X < -10000
        or cFrame.Position.Y > 10000
        or cFrame.Position.Y < -10000
        or cFrame.Position.Z > 10000
        or cFrame.Position.Z < -10000
    then
        arg1:fail(ErrorSourceStrings.Keys.MeshGeometry_PositionOutOfBounds, {})
        return
    end

    if scale.X < num1 / 1000 or scale.Y < num1 / 1000 or scale.Z < num1 / 1000 then
        local num3 = math.min(scale.X, scale.Y, scale.Z)

        if not getFFlagUGCValidateMeshScaleErrorMessage() or num3 ~= num3 then
            arg1:fail(ErrorSourceStrings.Keys.MeshGeometry_ScaleTooSmall, {})
        elseif num3 <= 0 then
            arg1:fail(ErrorSourceStrings.Keys.MeshGeometry_ScaleNotPositive, { meshName = handle:GetFullName() })
        else
            local num4 = num1 / 10
            local num5 = math.clamp(math.round(num3 * 10000) / 100, 0.01, num4 - 0.01)
            arg1:fail(
                ErrorSourceStrings.Keys.MeshGeometry_ScaleBelowMinimum,
                {
                    meshName = handle:GetFullName(),
                    scalePercent = valueToString(num5),
                    minScalePercent = valueToString(num4)
                }
            )
        end

        return
    end

    if getFFlagUGCValidateMeshMaxScale() and (scale.X > num2 / 1000 or scale.Y > num2 / 1000 or scale.Z > num2 / 1000) then
        local num3 = math.max(scale.X, scale.Y, scale.Z)

        if getFFlagUGCValidateMeshScaleErrorMessage() and num3 < math.huge then
            local num4 = num2 / 1000
            local num5 = math.max(math.round(num3 * 100) / 100, num4 + 0.01)
            arg1:fail(
                ErrorSourceStrings.Keys.MeshGeometry_ScaleAboveMaximum,
                {
                    meshName = handle:GetFullName(),
                    scaleMultiple = valueToString(num5),
                    maxScaleMultiple = valueToString(num4)
                }
            )
            return
        end

        arg1:fail(ErrorSourceStrings.Keys.MeshGeometry_ScaleTooLarge, { meshName = handle.Name })
        return
    end

    local editableMeshVerts = UGCValidationService:GetEditableMeshVerts(handle2.editable)

    for _, editableMeshVert in pairs(editableMeshVerts) do
        local var2 = handle.CFrame:PointToWorldSpace(editableMeshVert * scale)
        if pointInBounds(var2, cFrame, size) then
            continue
        end

        arg1:fail(ErrorSourceStrings.Keys.MeshGeometry_ExceedsBounds, {
            meshName = rootInstance.Name,
            assetTypeName = assetType.Name,
            maxSizeX = string.format("%.2f", (truncate(size.X))),
            maxSizeY = string.format("%.2f", (truncate(size.Y))),
            maxSizeZ = string.format("%.2f", (truncate(size.Z)))
        })
        return
    end

    local var2 = (attachment.CFrame.Rotation * handle.Size):Abs()

    if not (var2.X <= size.X and var2.Y <= size.Y and var2.Z <= size.Z) then
        arg1:fail(ErrorSourceStrings.Keys.MeshGeometry_ExceedsBounds, {
            meshName = handle:GetFullName(),
            assetTypeName = assetType.Name,
            maxSizeX = string.format("%.2f", (truncate(size.X))),
            maxSizeY = string.format("%.2f", (truncate(size.Y))),
            maxSizeZ = string.format("%.2f", (truncate(size.Z)))
        })
        return
    end

    if arg2.consumerConfig.consumerEnv == ValidationEnums.ConsumerEnv.IEC then
        return
    end

    local tbl1 = {
        fullName = handle:GetFullName(),
        fieldName = "MeshId",
        editableMesh = handle2.editable,
        scale = scale,
        context = rootInstance.Name
    }

    local var3, _, var4, var5 = getMeshMinMax(tbl1, { isServer = isServer, shouldYield = false })
    if not var3 then
        arg1:fetchError(string.format("Failed to compute mesh min/max for %s", handle:GetFullName()))
    end

    if not var4 or not var5 then
        return
    end

    local var6 = (var4 + var5) / 2
    if getFIntUGCValidateMeshCenteringHundredsThreshold() / 100 < var6.Magnitude then
        arg1:fail(ErrorSourceStrings.Keys.MeshGeometry_NotCentered, { meshName = handle:GetFullName(), fieldName = "MeshId" })
    end
end

return module

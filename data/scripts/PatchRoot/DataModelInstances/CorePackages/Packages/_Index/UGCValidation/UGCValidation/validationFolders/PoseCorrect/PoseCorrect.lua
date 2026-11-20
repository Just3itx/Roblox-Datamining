-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:10:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)

local AssetCalculator = require(scriptParentParentParent.util.AssetCalculator)
local canBeNormalized = require(scriptParentParentParent.util.canBeNormalized)
local prettyPrintVector3 = require(scriptParentParentParent.util.prettyPrintVector3)

local num1 = game:DefineFastInt("UGCValidatePoseDegFromXYPlane", 20)

local num2 = game:DefineFastInt("UGCValidatePoseArmMinDegFromXVectorOnXYPlane", -90)

local num3 = game:DefineFastInt("UGCValidatePoseArmMaxDegFromXVectorOnXYPlane", 30)

local num4 = game:DefineFastInt("UGCValidatePoseLegMinDegFromXVectorOnXYPlane", -93)

local num5 = game:DefineFastInt("UGCValidatePoseLegMaxDegFromXVectorOnXYPlane", -60)

local module = {
    categories = { ValidationEnums.UploadCategory.TORSO_AND_LIMBS },
    requiredData = { ValidationEnums.SharedDataMember.rootInstance },
    expectedFailures = {}
}
local function validateAngleFromXYPlane(arg1, assetTypeFromUploadEnum, vec1: vector, vec2: vector)
    local num6 = math.deg(math.acos((vec1:Dot(vec2))))
    if not (num1 < num6) then
        return
    end

    arg1:fail(
        ErrorSourceStrings.Keys.Pose_AngleFromXYPlane,
        {
            assetName = assetTypeFromUploadEnum.Name,
            angle = string.format("%d", num6),
            limit = string.format("%d", num1)
        }
    )
end

local function validateAngleFromWorldXVectorOnXYPlane(arg1, assetTypeFromUploadEnum, vec1: vector, vec2: vector, num6: number, num7: number)
    local num8 = math.deg(math.acos((vec1:Dot(vec2))))
    if not (vec1.Y > 0) then
        num8 = -num8
    end
    if not (num8 < num6) and not (num7 < num8) then
        return
    end

    arg1:fail(ErrorSourceStrings.Keys.Pose_AngleOnXYPlane, {
        assetName = assetTypeFromUploadEnum.Name,
        angle = string.format("%d", num8),
        xVector = prettyPrintVector3(vec2),
        minAngle = string.format("%d", num6),
        maxAngle = string.format("%d", num7)
    })
end

local function getAssetTypeFromUploadEnum(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    return if arg1.uploadEnum and arg1.uploadEnum.assetType then arg1.uploadEnum.assetType else nil
end

function module.run(arg1, arg2)
    local rootInstance = arg2.rootInstance
    local assetTypeFromUploadEnum = getAssetTypeFromUploadEnum(arg2)

    if not assetTypeFromUploadEnum
        or assetTypeFromUploadEnum ~= Enum.AssetType.LeftArm
            and assetTypeFromUploadEnum ~= Enum.AssetType.RightArm
            and assetTypeFromUploadEnum ~= Enum.AssetType.LeftLeg
            and assetTypeFromUploadEnum ~= Enum.AssetType.RightLeg
    then
        return
    end

    local assetCFrame = AssetCalculator.calculateAssetCFrame(assetTypeFromUploadEnum, rootInstance)
    if not assetCFrame then
        arg1:fail(ErrorSourceStrings.Keys.Pose_CFrameCalculationFailed, { assetName = assetTypeFromUploadEnum.Name })

        return
    end

    local var1 = assetCFrame.YVector.Unit - Vector3.new(0, 0, 1) * assetCFrame.YVector.Unit:Dot(Vector3.new(0, 0, 1))
    if not canBeNormalized(var1) then
        arg1:fail(ErrorSourceStrings.Keys.Pose_PointingAlongZVector, { assetName = assetTypeFromUploadEnum.Name })

        return
    end
    local var2 = -var1.Unit
    local var3 = -assetCFrame.YVector.Unit

    validateAngleFromXYPlane(arg1, assetTypeFromUploadEnum, var2, var3)

    local var4 = if assetTypeFromUploadEnum == Enum.AssetType.RightArm or assetTypeFromUploadEnum == Enum.AssetType.RightLeg then Vector3.new(1, 0, 0) else vector.create(-1, -0, -0, -0)
    local var5, var6

    if assetTypeFromUploadEnum == Enum.AssetType.RightArm or assetTypeFromUploadEnum == Enum.AssetType.LeftArm then
        var5 = num2
        var6 = num3
    else
        var5 = num4
        var6 = num5
    end
    validateAngleFromWorldXVectorOnXYPlane(arg1, assetTypeFromUploadEnum, var2, var4, var5, var6)
end

return module

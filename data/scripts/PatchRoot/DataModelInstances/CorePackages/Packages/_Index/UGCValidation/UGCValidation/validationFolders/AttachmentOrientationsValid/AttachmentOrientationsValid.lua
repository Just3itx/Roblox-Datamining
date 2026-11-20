-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:50:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)
local getDiffBetweenOrientations = require(scriptParentParentParent.util.getDiffBetweenOrientations)
local floatEquals = require(scriptParentParentParent.util.floatEquals)
local valueToString = require(scriptParentParentParent.util.valueToString)
local R15plusUtils = require(scriptParentParentParent.util.R15plusUtils)
local getAttachmentCFrameInPartSpace = require(scriptParentParentParent.util.getAttachmentCFrameInPartSpace)
local AttachmentRotationFInts = require(scriptParentParentParent.util.AttachmentRotationFInts)

local bool1 = game:DefineFastFlag("UGCValidateRigAttachmentRotationUsesDiff", false)

local thresholdGetters = AttachmentRotationFInts.thresholdGetters

local var1 = CFrame.new(Vector3.new(0, 0, 0), Vector3.new(0, 0, -1)) * CFrame.fromEulerAnglesXYZ(-(math.pi / 2), 0, 0)

local module = {
    categories = { ValidationEnums.UploadCategory.TORSO_AND_LIMBS, ValidationEnums.UploadCategory.DYNAMIC_HEAD },
    requiredData = { ValidationEnums.SharedDataMember.rootInstance, ValidationEnums.SharedDataMember.uploadEnum },
    expectedFailures = {}
}
local function expectedGripAttCFrameRotation(rootInstance, assetType)
    local str1 = if assetType == Enum.AssetType.RightArm then "Right" else "Left"

    local var2 = rootInstance:FindFirstChild(str1 .. "LowerArm")
    local var3 = rootInstance:FindFirstChild(str1 .. "Hand")
    if not (var2 and var3) then
        return CFrame.identity
    end

    local var4 = var2:FindFirstChild(str1 .. "ElbowRigAttachment", R15plusUtils.checkFlagEnabledForAllowHrd())

    local var5 = var2:FindFirstChild(str1 .. "WristRigAttachment", R15plusUtils.checkFlagEnabledForAllowHrd())

    local var6 = var3:FindFirstChild(str1 .. "WristRigAttachment", R15plusUtils.checkFlagEnabledForAllowHrd())

    local var7 = var3:FindFirstChild(str1 .. "GripAttachment", R15plusUtils.checkFlagEnabledForAllowHrd())
    if not (var4 and var5 and var6 and var7) then
        return CFrame.identity
    end

    local attachmentCFrameInPartSpace = getAttachmentCFrameInPartSpace(var6)

    local var8 = attachmentCFrameInPartSpace * getAttachmentCFrameInPartSpace(var5):Inverse() * getAttachmentCFrameInPartSpace(var4)
    local var9 = attachmentCFrameInPartSpace.Position - var8.Position

    local rz = math.pi / 2 - math.acos(Vector3.new(var9.X, math.max(0, -var9.Y), 0).Unit.X)

    return CFrame.fromEulerAnglesXYZ(0, 0, rz) * var1.Rotation
end

function module.run(arg1, arg2)
    local rootInstance = arg2.rootInstance
    local assetType = arg2.uploadEnum.assetType

    for _, descendant in (rootInstance:GetDescendants()) do
        if descendant.ClassName ~= "Attachment" then
            continue
        end

        local bool2 = string.sub(descendant.Name, -13) == "RigAttachment"
        local bool3 = string.sub(descendant.Name, -14) == "GripAttachment"

        if bool2 then
            local bool4

            if bool1 then
                bool4 = getDiffBetweenOrientations(CFrame.identity, getAttachmentCFrameInPartSpace(descendant)) > thresholdGetters.RigAttachment()
            else
                local var2, var3, var4 = getAttachmentCFrameInPartSpace(descendant):ToOrientation()
                bool4 = not (floatEquals(var2, 0) and floatEquals(var3, 0) and floatEquals(var4, 0))
            end
            if bool4 then
                local attachmentOrientationRigRotated = ErrorSourceStrings.Keys.AttachmentOrientationRigRotated
                local tbl1 = {
                    InstancePath = descendant:GetFullName()
                }
                arg1:fail(attachmentOrientationRigRotated, tbl1)
            end
        elseif thresholdGetters[descendant.Name] ~= nil then
            local cFrame = CFrame.new()
            if bool3 and assetType and (assetType == Enum.AssetType.RightArm or assetType == Enum.AssetType.LeftArm) then
                cFrame = expectedGripAttCFrameRotation(rootInstance, assetType)
            end

            if getDiffBetweenOrientations(cFrame, getAttachmentCFrameInPartSpace(descendant)) > thresholdGetters[descendant.Name]() then
                local vec3 = Vector3.new(cFrame:ToOrientation())
                local vec3_2 = Vector3.new(math.deg(vec3.X), math.deg(vec3.Y), math.deg(vec3.Z))

                local attachmentOrientationDeviation = ErrorSourceStrings.Keys.AttachmentOrientationDeviation
                local tbl1 = {
                    InstancePath = descendant:GetFullName(),
                    ExpectedOrientation = valueToString(vec3_2),
                    MaxDeviation = tostring(thresholdGetters[descendant.Name]())
                }
                arg1:fail(attachmentOrientationDeviation, tbl1)
            end
        end
    end
end

return module

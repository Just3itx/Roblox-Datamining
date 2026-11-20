-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T16:11:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CameraUtility = require(script.Parent.CameraUtility)
local CFrameUtility = require(script.Parent.CFrameUtility)
local CharacterUtility = require(script.Parent.CharacterUtility)
local MannequinUtility = require(script.Parent.MannequinUtility)

local num1 = game:DefineFastInt("CameraPresetHeadshotExtentScaleHundredths", 130)

local module = {
    GOLDEN_RATIO = game:DefineFastInt("AvatarGoldenRatio", 618) / 1000,
    UPVECTOR_ORENTATION_TRESHOLD = game:DefineFastInt("UpVectorOrentationThreshold1", -60) / 100,
    AVATAR_ROTATION_DEGREE = game:DefineFastInt("LookAvatarRotationDegree1", 23)
}
local function getTorsoOrUpperTorso(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    return arg1:FindFirstChild("Torso") or arg1:FindFirstChild("UpperTorso")
end

local function getMannequinBodyParts(arg1, humanoid: Humanoid)
    local mannequinBodyParts = {}
    if humanoid.RigType == Enum.HumanoidRigType.R6 then
        for value, _ in MannequinUtility.CharacterPartNames.R6 do
            if value ~= "CharacterMesh" and value ~= "HumanoidRootPart" then
                table.insert(mannequinBodyParts, (arg1:FindFirstChild(value)))
            end
        end

        return mannequinBodyParts
    end

    if humanoid.RigType == Enum.HumanoidRigType.R15 then
        for value, _ in MannequinUtility.CharacterPartNames.R15 do
            if value ~= "HumanoidRootPart" then
                table.insert(mannequinBodyParts, (arg1:FindFirstChild(value)))
            end
        end
    end
    return mannequinBodyParts
end

function module.GetCharacterTorsoCFrame(arg1)
    return getTorsoOrUpperTorso(arg1).CFrame
end

function module.GetFullBodyCameraCFrame(arg1, func1: ((...any) -> (...any))?, bool1: boolean?, num2: number?, cFrame: CFrame?)
    local num3 = num2 or 56
    local var1 = cFrame or module.GetCharacterTorsoCFrame(arg1)
    local lookVector = var1.LookVector
    if type(func1) == "function" then
        func1()
    end

    local humanoid = arg1:FindFirstChildOfClass("Humanoid")
    if not humanoid then
        return
    end

    local mannequinBodyParts = getMannequinBodyParts(arg1, humanoid)

    local torsoOrUpperTorsoCFrame = getTorsoOrUpperTorso(arg1).CFrame
    local upVector = torsoOrUpperTorsoCFrame.UpVector

    local rx, ry, rz = arg1:FindFirstChild("Head").CFrame:ToEulerAnglesXYZ()

    if bool1 then
        local angles = CFrame.Angles
        local num4 = module.AVATAR_ROTATION_DEGREE * -1
        arg1:PivotTo(var1 * angles(0, math.rad(num4), 0))
    end

    local var2, var3 = CharacterUtility.CalculateBodyPartsExtents(torsoOrUpperTorsoCFrame, mannequinBodyParts)

    local num4 = math.tan(math.rad(num3 / 2))

    local var4 = var2:Lerp(var3, module.GOLDEN_RATIO)
    local var5 = var2:Lerp(var3, 0.5)
    local vec3 = Vector3.new(var5.X, var4.Y, var5.Z)

    local var6 = torsoOrUpperTorsoCFrame:PointToWorldSpace(vec3)

    local var7 = torsoOrUpperTorsoCFrame - torsoOrUpperTorsoCFrame.Position + var6

    if not bool1 then
        local cFrame2 = CFrame.fromEulerAnglesXYZ(rx, ry, rz)
        var7 = cFrame2 - cFrame2.Position + var6
    end

    local num5 = math.max(vec3.X - var2.X, vec3.Y - var2.Y)
    local num6 = math.max(var3.X - vec3.X, var3.Y - vec3.Y)

    local var8 = num5 * CameraUtility.DefaultBodyMarginScale / num4
    local var9 = num6 * CameraUtility.DefaultBodyMarginScale / num4

    local bool2 = upVector.Y < module.UPVECTOR_ORENTATION_TRESHOLD
    local bool3 = upVector.X < module.UPVECTOR_ORENTATION_TRESHOLD

    if bool2 or bool3 then
        var8 = math.max(var8, var9)
    end

    local var10 = var8 * CameraUtility.DistanceScaleForFullBody * lookVector
    return CameraUtility.GetCameraCFrame(var7, var10)
end

module.GetCameraCFrame_ForAvatarR15Action_LookAtGoldenRatioOfTheHumanoid = module.GetFullBodyCameraCFrame

function module.GetHeadshotCameraCFrame(arg1, func1: ((...any) -> (...any))?, bool1: boolean?, num2: number?)
    local optFieldOfView = num2 or 30
    if type(func1) == "function" then
        func1()
    end

    if bool1 then
        local characterTorsoCFrame = module.GetCharacterTorsoCFrame(arg1)

        local angles = CFrame.Angles
        local num4 = module.AVATAR_ROTATION_DEGREE * -1
        arg1:PivotTo(characterTorsoCFrame * angles(0, math.rad(num4), 0))
    end

    local head = arg1:FindFirstChild("Head")
    if not head then
        error("Character is missing a Head, cannot apply upper body camera preset.")
    end

    local headCFrame = head.CFrame
    local faceFrontAttachment = head:FindFirstChild("FaceFrontAttachment")
    if faceFrontAttachment then
        headCFrame = faceFrontAttachment.WorldCFrame
    end

    local targetCFrame = CFrameUtility.CalculateTargetCFrame(headCFrame)

    local minExtent, maxExtent = CharacterUtility.CalculateHeadExtents(arg1, targetCFrame)

    local thumbnailCamera = CameraUtility.CreateThumbnailCamera()
    local tbl1 = {
        extentScale = num1 / 100,
        maxExtent = maxExtent,
        minExtent = minExtent,
        optCameraXRot = CameraUtility.XRotForCloseup,
        optFieldOfView = optFieldOfView,
        targetCFrame = targetCFrame
    }
    CameraUtility.SetupCamera(thumbnailCamera, tbl1)
end

return module

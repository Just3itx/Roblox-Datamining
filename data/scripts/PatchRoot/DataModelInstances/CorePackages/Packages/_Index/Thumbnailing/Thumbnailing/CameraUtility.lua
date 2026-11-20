-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T16:20:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}

local CFrameUtility = require(script.Parent.CFrameUtility)
local VectorUtility = require(script.Parent.VectorUtility)
local CharacterUtility = require(script.Parent.CharacterUtility)

module.DefaultHeadMarginScale = 1.1

module.DefaultBodyMarginScale = 1.1

module.DefaultBodyPartMarginScale = 1.2

module.XRotForFullBody = 15
module.XRotForCloseup = 0
module.DistanceScaleForFullBody = 1

local cFrame = CFrame.fromEulerAnglesYXZ(-math.rad(20), math.rad(20), 0)
local cFrame2 = CFrame.fromEulerAnglesYXZ(-math.rad(20), -math.rad(20), 0)

local cFrame3 = CFrame.Angles(math.rad(25), math.rad(25), 0)

local cFrame4 = CFrame.Angles(0, math.pi / 2, 0)

local cFrame5 = CFrame.Angles(0, -(math.pi / 2), 0)

function module.GetCameraCFrame(cFrame6: CFrame, vec1: vector): CFrame
    local at = cFrame6 * vec1
    return CFrame.lookAt(at, cFrame6.Position)
end

function module.CreateThumbnailCamera(): Camera
    local thumbnailCamera = Instance.new("Camera")
    thumbnailCamera.Name = "ThumbnailCamera"
    thumbnailCamera.CameraType = Enum.CameraType.Scriptable
    thumbnailCamera.Parent = workspace:GetChildren()[1]
    return thumbnailCamera
end

function module.CalculateBaseDistanceToCamera(num1: number, minExtent: vector, maxExtent: vector, extentScale: number): number
    local num2 = math.max((maxExtent.X - minExtent.X) / 2, (maxExtent.Y - minExtent.Y) / 2)
    local num3 = math.tan(num1 / 2)
    return num2 * extentScale / num3
end

function module.SetupCamera(arg1, tbl1)
    if tbl1.optFieldOfView then
        arg1.FieldOfView = tbl1.optFieldOfView
    end

    local var1 = tbl1.optFieldOfViewForDistanceScale or arg1.FieldOfView
    local baseDistanceToCamera = module.CalculateBaseDistanceToCamera(math.rad(var1), tbl1.minExtent, tbl1.maxExtent, tbl1.extentScale)

    if tbl1.optCameraDistanceScale then
        baseDistanceToCamera *= tbl1.optCameraDistanceScale
    end

    local cFrame6 = CFrameUtility.AdjustTargetCFrameWithExtents(tbl1.targetCFrame, tbl1.minExtent, tbl1.maxExtent)

    local optCameraXRot = tbl1.optCameraXRot or 0
    local optCameraYRot = tbl1.optCameraYRot or 0

    local var2 = VectorUtility.Vector3FromXYRotPlusDistance(optCameraXRot, optCameraYRot, baseDistanceToCamera)
    arg1.CFrame = module.GetCameraCFrame(cFrame6, var2)
end

function module.SetupBodyPartCamera(arg1, bool1: boolean, tbl1, arg2)
    local tbl2 = {}
    if #tbl1 > 0 then
        for _, value in pairs(tbl1) do
            local var1 = arg1:FindFirstChild(value, true)
            if var1 then
                table.insert(tbl2, var1)
            end
        end
    end
    local humanoidRootPartCFrame = arg1:FindFirstChild("HumanoidRootPart").CFrame

    local targetCFrame = (if bool1 then cFrame2 else cFrame) * humanoidRootPartCFrame

    local minExtent, maxExtent = CharacterUtility.CalculateBodyPartsExtents(targetCFrame, tbl2)

    local tbl3 = {
        optFieldOfView = 30,
        targetCFrame = targetCFrame,
        minExtent = minExtent,
        maxExtent = maxExtent,
        extentScale = module.DefaultBodyPartMarginScale
    }
    module.SetupCamera(arg2, tbl3)
end

function module.SetupHeadCamera(arg1, arg2)
    local head = arg1:FindFirstChild("Head")

    local targetCFrame = CFrameUtility.CalculateTargetCFrame(head.CFrame)

    local var1 = CFrame.fromEulerAnglesYXZ(math.rad(15), math.pi / 6, 0) * targetCFrame

    local minExtent, maxExtent = CharacterUtility.CalculateHeadExtents(arg1, var1)

    module.SetupCamera(
        arg2,
        {
            optFieldOfView = 30,
            targetCFrame = var1,
            minExtent = minExtent,
            maxExtent = maxExtent,
            extentScale = 1.1
        }
    )
end

local function isLeftShoe(arg1): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    local meshPart = arg1:FindFirstChildWhichIsA("MeshPart")
    if not meshPart then
        return false
    end
    assert(meshPart, "Assert handle is not nil to silence type checker")
    return meshPart:FindFirstChild("LeftFootAttachment") ~= nil
end

local function isRightShoe(arg1): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    local meshPart = arg1:FindFirstChildWhichIsA("MeshPart")
    if not meshPart then
        return false
    end
    assert(meshPart, "Assert handle is not nil to silence type checker")
    return meshPart:FindFirstChild("RightFootAttachment") ~= nil
end

local function getAccessoryAngle(arg1): CFrame -- Luacid: Inlined by compiler; 1 call site recovered
    return if isLeftShoe(arg1) then cFrame4 elseif isRightShoe(arg1) then cFrame5 else cFrame3
end

function module.SetupAccessoryCamera(arg1, arg2)
    local children = arg1:GetChildren()
    assert(#children == 1, "Assert SetupMeshPartAccessoryCamera accessoryModel only has accessory as a child.")
    local child = children[1]
    local handle = child:FindFirstChild("Handle")
    assert(handle, "Assert Accessory has handle for camera setup.")
    handle.CFrame = CFrame.new()
    local targetCFrame = handle.CFrame * getAccessoryAngle(child)

    local minExtent, maxExtent = CharacterUtility.CalculateModelExtents(arg1, targetCFrame)

    module.SetupCamera(
        arg2,
        {
            optFieldOfView = 20,
            targetCFrame = targetCFrame,
            minExtent = minExtent,
            maxExtent = maxExtent,
            extentScale = 1.1
        }
    )
end

return module

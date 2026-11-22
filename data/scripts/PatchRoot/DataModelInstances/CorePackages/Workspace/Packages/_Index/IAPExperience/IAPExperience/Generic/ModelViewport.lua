-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:10:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RunService = game:GetService("RunService")

local scriptParentParentParent = script.Parent.Parent.Parent
local React = require(scriptParentParentParent.React)
local CharacterUtility = require(scriptParentParentParent.Thumbnailing).CharacterUtility
local CameraUtility = require(scriptParentParentParent.Thumbnailing).CameraUtility
local CFrameUtility = require(scriptParentParentParent.Thumbnailing).CFrameUtility
local EmoteUtility = require(scriptParentParentParent.Thumbnailing).EmoteUtility

local bool1 = game:DefineFastFlag("PurchasePromptPreviewMakeupHead2", false)

local function ModelViewport(tbl1)
    local ref = React.useRef(nil)
    local currentCamera, var3 = React.useBinding(nil)
    local var4 = React.useRef(false)

    React.useEffect(function()
        var4.current = true
        return function()
            var4.current = false
        end
    end, {})

    React.useEffect(function()
        task.spawn(function()
            local modelClone = tbl1.model:Clone()
            local camera = Instance.new("Camera")
            camera.CameraType = Enum.CameraType.Scriptable
            camera.Parent = ref.current
            camera.HeadLocked = true
            camera.VRTiltAndRollEnabled = true
            modelClone.Parent = ref.current
            if modelClone:IsA("Model") and modelClone.PrimaryPart then
                modelClone:MoveTo(Vector3.new(0, 0, 0))

                EmoteUtility.SetPlayerCharacterPoseWithMoodFallback(modelClone)

                RunService.PostSimulation:Wait()
                if not var4.current then
                    return
                end

                local targetCFrame = CFrameUtility.CalculateTargetCFrame(modelClone.Head.CFrame)
                local var1 = targetCFrame - targetCFrame.Position + modelClone.PrimaryPart.CFrame.Position

                local minExtent, maxExtent = CharacterUtility.CalculateModelExtents(modelClone, var1)
                local tbl2 = {
                    optFieldOfView = 30,
                    targetCFrame = var1,
                    minExtent = minExtent,
                    maxExtent = maxExtent,
                    extentScale = 1
                }

                tbl2.optCameraXRot = CameraUtility.XRotForFullBody
                tbl2.optCameraDistanceScale = CameraUtility.DistanceScaleForFullBody
                tbl2.extentScale = CameraUtility.DefaultBodyMarginScale
                CameraUtility.SetupCamera(camera, tbl2)
                var3(camera)
                return
            end
            if not var4.current then
                return
            end

            local model

            if modelClone:IsA("Model") then
                model = modelClone
            else
                model = Instance.new("Model")
                modelClone.Parent = model
                model.Parent = ref.current
            end

            if not bool1 then
                CameraUtility.SetupAccessoryCamera(model, camera)
                var3(camera)
                return
            end

            local head = model:FindFirstChild("Head")
            if not head or not head:IsA("MeshPart") or model:FindFirstChild("HumanoidRootPart") then
                CameraUtility.SetupAccessoryCamera(model, camera)
                var3(camera)
                return
            end

            local headCFrame = head.CFrame

            local minExtent, maxExtent = CharacterUtility.CalculateBodyPartsExtents(headCFrame, { head })
            CameraUtility.SetupCamera(camera, {
                optFieldOfView = 30,
                targetCFrame = headCFrame,
                minExtent = minExtent,
                maxExtent = maxExtent,
                extentScale = 1.2,
                optCameraXRot = 5,
                optCameraYRot = 20
            })
            var3(camera)
        end)
    end, {})

    return React.createElement(
        "Frame",
        {
            BackgroundTransparency = 1,
            Size = tbl1.Size,
            Position = tbl1.Position,
            LayoutOrder = tbl1.LayoutOrder
        },
        {
            ViewportFrame = React.createElement(
                "ViewportFrame",
                {
                    BackgroundTransparency = 1,
                    Size = UDim2.fromScale(1, 1),
                    Position = UDim2.fromScale(0.5, 0.5),
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    LightColor = Color3.fromRGB(240, 240, 240),
                    Ambient = Color3.fromRGB(160, 160, 160),
                    LightDirection = Vector3.new(9.5, -12, 7.5),
                    CurrentCamera = currentCamera
                },
                {
                    WorldModel = React.createElement("WorldModel", { ref = ref })
                }
            )
        }
    )
end
return ModelViewport

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:11:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local Roact = require(CorePackages.Packages.Roact)
local t = require(CorePackages.Packages.t)
local ExternalEventConnection = require(CorePackages.Workspace.Packages.RoactUtils).ExternalEventConnection
local RunService = game:GetService("RunService")

local var1 = Roact.PureComponent:extend("ObjectViewport")

var1.validateProps = t.strictInterface({ model = t.instanceOf("Model") })

local function getCameraDistance(arg1, arg2) -- Luacid: unused: defined but never referenced
    local x = arg2.X
    local y = arg2.Y
    local z = arg2.Z

    local num1 = math.max(x, y, z)

    local num2 = 1 / math.tan(math.rad(arg1) / 2)
    return num1 / 2 * num2 + z / 2
end

local function rotateVectorAround(initialLookVector: Vector3, r: number, vec3: Vector3): Vector3 -- Luacid: Inlined by compiler; 1 call site recovered
    return CFrame.fromAxisAngle(vec3, r):VectorToWorldSpace(initialLookVector)
end

function var1.init(arg1)
    arg1.cameraRef = Roact.createRef()
    arg1.worldModelRef = Roact.createRef()

    local cameraCFrameBinding, updateCameraCFrameBinding = Roact.createBinding(CFrame.new())
    arg1.cameraCFrameBinding = cameraCFrameBinding
    arg1.updateCameraCFrameBinding = updateCameraCFrameBinding
    local cameraRotationBinding, updateCameraRotationBinding = Roact.createBinding(0)
    arg1.cameraRotationBinding = cameraRotationBinding
    arg1.updateCameraRotationBinding = updateCameraRotationBinding
    local cameraFocusBinding, updateCameraFocusBinding = Roact.createBinding(CFrame.new())
    arg1.cameraFocusBinding = cameraFocusBinding
    arg1.updateCameraFocusBinding = updateCameraFocusBinding

    arg1:OnModelChanged()
end

function var1.OnModelChanged(arg1)
    if arg1.props.model == nil then
        return
    end

    arg1.modelCFrame = arg1.props.model:GetModelCFrame()
    arg1.initialLookVector = arg1.modelCFrame.lookVector
    arg1.modelExtentsSize = arg1.props.model:GetExtentsSize()
    local modelExtentsSize = arg1.modelExtentsSize
    local modelExtentsSizeX = modelExtentsSize.X
    local modelExtentsSizeY = modelExtentsSize.Y
    local modelExtentsSizeZ = modelExtentsSize.Z

    arg1.cameraDistance = math.max(modelExtentsSizeX, modelExtentsSizeY, modelExtentsSizeZ) / 2 * 1.4281480067421146 + modelExtentsSizeZ / 2
end

function var1.render(arg1)
    local createElement = Roact.createElement
    local tbl1 = {
        BackgroundTransparency = 1,
        Position = UDim2.fromScale(0, 0),
        AnchorPoint = Vector2.new(0, 0),
        Size = UDim2.fromScale(1, 1)
    }
    local tbl2 = {
        AspectRatioConstraint = Roact.createElement(
            "UIAspectRatioConstraint",
            {
                AspectRatio = 1,
                AspectType = Enum.AspectType.FitWithinMaxSize,
                DominantAxis = Enum.DominantAxis.Width
            }
        ),
        ViewportFrame = 0
    }

    local createElement2 = Roact.createElement
    local tbl3 = {
        BackgroundTransparency = 0,
        BackgroundColor3 = Color3.new(0, 0, 0),
        Size = UDim2.fromScale(1, 1),
        Position = UDim2.fromScale(0.5, 0.5),
        AnchorPoint = Vector2.new(0.5, 0.5),
        LightColor = Color3.fromRGB(240, 240, 240),
        LightDirection = Vector3.new(1, 1, 1),
        Ambient = Color3.fromRGB(240, 240, 240),
        CurrentCamera = arg1.cameraRef
    }

    local tbl4 = {
        Camera = Roact.createElement("Camera", {
            CameraType = Enum.CameraType.Scriptable,
            FieldOfView = 70,
            CFrame = arg1.cameraCFrameBinding,
            Focus = arg1.cameraFocusBinding,
            [Roact.Ref] = arg1.cameraRef
        }),
        WorldModel = Roact.createElement("WorldModel", { [Roact.Ref] = arg1.worldModelRef }),
        RenderSteppedConnection = Roact.createElement(ExternalEventConnection, {
            event = RunService.RenderStepped,
            callback = function()
                arg1.updateCameraRotationBinding(arg1.cameraRotationBinding:getValue() + 0.01)
                local worldVector = rotateVectorAround(arg1.initialLookVector, arg1.cameraRotationBinding:getValue(), Vector3.new(0, 1, 0))

                local cFrame = CFrame.new(arg1.modelCFrame.p + worldVector * arg1.cameraDistance, arg1.modelCFrame.p)
                arg1.updateCameraCFrameBinding(cFrame)
            end
        })
    }

    tbl2.ViewportFrame = createElement2("ViewportFrame", tbl3, tbl4)
    return createElement("Frame", tbl1, tbl2)
end

function var1.didMount(arg1)
    if arg1.worldModelRef:getValue() and arg1.props.model ~= nil then
        arg1.props.model.Parent = arg1.worldModelRef:getValue()
    end
end

function var1.willUnmount(arg1)
    if arg1.props.model then
        arg1.props.model.Parent = nil
    end
end

function var1.didUpdate(arg1, arg2)
    if arg1.props.model == arg2.model then
        return
    end
    if arg2.model ~= nil then
        arg2.model.Parent = nil
    end

    if arg1.props.model ~= nil then
        arg1.props.model.Parent = arg1.worldModelRef:getValue()
    end
    arg1:OnModelChanged()
end

return var1

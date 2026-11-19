-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:10:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local GuiService = game:GetService("GuiService")

local module = { initStarted = false, TestModel = nil, hrp = nil, humanoid = nil, player = nil }

function module.Init()
    if module.initStarted then
        return
    end

    module.initStarted = true

    local player = module.WaitForExpression(function(): Player
        return Players.LocalPlayer
    end, 10, "Players.LocalPlayer not found")
    module.player = player

    if player.Character == nil and RunService:IsServer() then
        player:LoadCharacterAsync()
    end

    module.WaitForExpression(function()
        return player.Character
    end, 10, "LocalPlayer.Character not found")

    module.hrp = player.Character:WaitForChild("HumanoidRootPart")
    module.humanoid = player.Character:WaitForChild("Humanoid")

    if module.TestModel == nil then
        module.TestModel = Instance.new("Model")
        module.TestModel.Name = "_TestContainer"
        module.TestModel.Parent = workspace
    end

    module.PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
end

function module.AddInstance(className: string): Instance
    local instance = Instance.new(className)
    instance.Parent = module.TestModel
    return instance
end

function module.CleanUpAfterTest()
    module.TestModel:ClearAllChildren()
end

function module.SetCameraFOV(fieldOfView)
    workspace.CurrentCamera.FieldOfView = fieldOfView
end

function module.IsPartOnscreen(arg1): boolean
    local _vec3, bool1 = workspace.CurrentCamera:WorldToViewportPoint(arg1.Position)
    return bool1
end

function module.GetPartViewportPixelPosition(adornee): Vector2
    local vec3, _ = workspace.CurrentCamera:WorldToViewportPoint(adornee.Position)
    return Vector2.new(vec3.x, vec3.y)
end

function module.MovePlayerToPosition(arg1)
    if module.hrp ~= nil then
        local var1 = CFrame.new() + arg1 + Vector3.new(0, 1 + module.humanoid.HipHeight, 0)
        module.hrp.CFrame = var1
    end
end

function module.SetPlayerCamera(lookAt: Vector3, arg1)
    local head = module.player.Character:WaitForChild("Head", 10)
    local currentCameraCFrame = CFrame.new(Vector3.new(), lookAt) + head.Position - arg1 * lookAt.Unit

    local currentCamera = workspace.CurrentCamera
    currentCamera.CameraType = Enum.CameraType.Scriptable
    currentCamera.CFrame = currentCameraCFrame
end

function module.WaitNFrames(arg1)
    for _ = 1, arg1 do
        RunService.RenderStepped:Wait()
    end
end

function module.WaitWallTime(arg1)
    local startTime = tick()

    if arg1 > 2 then
        warn("Requested wait time too long, waiting 2s")
        arg1 = 2
    end

    while not (arg1 < tick() - startTime) do
        module.WaitNFrames(1)
    end
end

function module.WaitGameTime(arg1)
    local time, _deltaTime = RunService.Stepped:Wait()

    while time - time < arg1 do
        local _deltaTime2
        time, _deltaTime2 = RunService.Stepped:Wait()
    end
end

function module.WaitForExpression(arg1, arg2, arg3)
    local startTime = tick()
    local var1 = arg1()
    while not var1 and tick() - startTime < arg2 do
        module.WaitNFrames(1)
        var1 = arg1()
    end

    if not var1 then
        error(arg3)
    end

    return var1
end

function module.GetCornersOfBillboardGui(arg1)
    local partViewportPixelPosition = module.GetPartViewportPixelPosition(arg1.Adornee)
    local vector2 = Vector2.new(arg1.SizeOffset.x * arg1.AbsoluteSize.x, arg1.SizeOffset.y * arg1.AbsoluteSize.y)
    local center = partViewportPixelPosition - GuiService:GetGuiInset() + vector2
    local absoluteSize = arg1.AbsoluteSize

    return {
        center = center,
        topLeft = center - absoluteSize / 2 + Vector2.new(1, 1),
        topRight = center + Vector2.new(absoluteSize.x / 2 - 1, -absoluteSize.y / 2 + 1),
        bottomRight = center + Vector2.new(absoluteSize.x / 2 - 1, absoluteSize.y / 2 - 1),
        bottomLeft = center + Vector2.new(-absoluteSize.x / 2 + 1, absoluteSize.y / 2 - 1)
    }
end

return module

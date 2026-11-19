-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:40:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local _CorePackages = game:GetService("CorePackages")
while not Players.LocalPlayer do
    wait()
end
local LocalPlayer = Players.LocalPlayer
local var1 = nil
local connection = nil
local connection2 = nil

local RobloxGui = game:GetService("CoreGui").RobloxGui
local isEnabled = require(RobloxGui.Modules.TenFootInterface):IsEnabled()

local function createImageLabel(imageLabelName: string, uDim2: UDim2, uDim2_2: UDim2, image: string, frame: Frame): ImageLabel -- Luacid: Inlined by compiler; 3 call sites recovered
    local imageLabel = Instance.new("ImageLabel")
    imageLabel.Name = imageLabelName
    imageLabel.Size = uDim2
    imageLabel.Position = uDim2_2
    imageLabel.BackgroundTransparency = 1
    imageLabel.Image = image
    imageLabel.Parent = frame

    return imageLabel
end

local function createTextLabel(textLabelName: string, textXAlignment: Enum.TextXAlignment, textLabelText: string, frame: Frame): TextLabel
    local textLabel = Instance.new("TextLabel")
    textLabel.Name = textLabelName
    textLabel.Size = UDim2.new(1, -4, 0, if isEnabled then 50 else 20)
    textLabel.Position = UDim2.new(0, 2, 0, if isEnabled then -50 else -20)
    textLabel.BackgroundTransparency = 1
    textLabel.TextXAlignment = textXAlignment
    textLabel.Font = Enum.Font.SourceSans
    textLabel.FontSize = isEnabled and Enum.FontSize.Size48 or Enum.FontSize.Size18
    textLabel.TextColor3 = Color3.new(1, 1, 1)
    textLabel.TextStrokeTransparency = 0.5
    textLabel.TextStrokeColor3 = Color3.new(49 / 255, 49 / 255, 49 / 255)
    textLabel.Text = textLabelText
    textLabel.Parent = frame

    return textLabel
end

local VehicleHudFrame = Instance.new("Frame")
VehicleHudFrame.Name = "VehicleHudFrame"
VehicleHudFrame.Size = UDim2.new(0, if isEnabled then 316 else 158, 0, if isEnabled then 50 else 14)
VehicleHudFrame.Position = UDim2.new(
    0.5,
    -(VehicleHudFrame.Size.X.Offset / 2),
    1,
    -(if isEnabled then 100 else 70) - VehicleHudFrame.Size.Y.Offset
)
VehicleHudFrame.BackgroundTransparency = 1
VehicleHudFrame.Visible = false
VehicleHudFrame.Parent = RobloxGui

local SpeedBarClippingFrame = Instance.new("Frame")
SpeedBarClippingFrame.Name = "SpeedBarClippingFrame"
SpeedBarClippingFrame.Size = UDim2.new(0, 0, 0, if isEnabled then 24 else 4)
SpeedBarClippingFrame.Position = UDim2.new(0.5, if isEnabled then -142 else -71, 0.5, if isEnabled then -13 else -2)
SpeedBarClippingFrame.BackgroundTransparency = 1
SpeedBarClippingFrame.ClipsDescendants = true
SpeedBarClippingFrame.ZIndex = 2
SpeedBarClippingFrame.Parent = VehicleHudFrame

local _imageLabel = createImageLabel(
    "HudBG",
    UDim2.new(1, 0, 1, 0),
    UDim2.new(0, 0, 0, 1),
    "rbxasset://textures/ui/Vehicle/SpeedBarBKG.png",
    VehicleHudFrame
)
local imageLabel = createImageLabel(
    "SpeedBG",
    UDim2.new(0, if isEnabled then 284 else 142, 0, if isEnabled then 24 else 4),
    UDim2.new(0.5, if isEnabled then -142 else -71, 0.5, if isEnabled then -13 else -2),
    "rbxasset://textures/ui/Vehicle/SpeedBarEmpty.png",
    VehicleHudFrame
)
local _imageLabel2 = createImageLabel(
    "SpeedBarImage",
    UDim2.new(0, if isEnabled then 284 else 142, 1, 0),
    UDim2.new(0, 0, 0, 0),
    "rbxasset://textures/ui/Vehicle/SpeedBar.png",
    SpeedBarClippingFrame
)
createTextLabel("SpeedLabel", Enum.TextXAlignment.Left, "Speed", VehicleHudFrame)
local textLabel = createTextLabel("SpeedText", Enum.TextXAlignment.Right, "0", VehicleHudFrame)

local function getHumanoid() -- Luacid: unused: defined but never referenced
    local character = LocalPlayer and LocalPlayer.Character
    if not character then
        return
    end

    for _, child in pairs(character:GetChildren()) do
        if child:IsA("Humanoid") then
            return child
        end
    end
end

local function onHeartbeat()
    if not var1 then
        return
    end

    local magnitude = var1.Velocity.magnitude
    local textLabel2 = textLabel
    textLabel2.Text = tostring(math.min(math.floor(magnitude), 9999))
    local xOffset = math.min(math.floor(magnitude / var1.MaxSpeed * imageLabel.Size.X.Offset), imageLabel.Size.X.Offset)
    SpeedBarClippingFrame.Size = UDim2.new(0, xOffset, 0, if isEnabled then 24 else 4)
end

local function onVehicleSeatChanged(property: string)
    if property == "HeadsUpDisplay" then
        VehicleHudFrame.Visible = not VehicleHudFrame.Visible
    end
end

local function onSeated(arg1, arg2) -- Luacid: Inlined by compiler; 1 call site recovered
    if arg1 then
        if arg2 and arg2:IsA("VehicleSeat") then
            var1 = arg2
            VehicleHudFrame.Visible = var1.HeadsUpDisplay
            connection = RunService.Heartbeat:connect(onHeartbeat)
            connection2 = var1.Changed:connect(onVehicleSeatChanged)
        end

        return
    end

    if not var1 then
        return
    end

    VehicleHudFrame.Visible = false
    var1 = nil
    if connection then
        connection:disconnect()
        connection = nil
    end
    if connection2 then
        connection2:disconnect()
        connection2 = nil
    end
end

local connection3 = nil
local connection4 = nil

local function disconnectSeatedConnection() -- Luacid: Inlined by compiler; 2 call sites recovered
    if connection3 then
        connection3:Disconnect()
        connection3 = nil
    end
end

local function disconnectChildAddedConnection() -- Luacid: Inlined by compiler; 2 call sites recovered
    if connection4 then
        connection4:Disconnect()
        connection4 = nil
    end
end

local function characterAdded(model: Model)
    disconnectSeatedConnection()
    disconnectChildAddedConnection()
    local humanoid = model:FindFirstChildWhichIsA("Humanoid")
    if humanoid then
        connection3 = humanoid.Seated:connect(onSeated)
        return
    end

    connection4 = model.ChildAdded:Connect(function(child: Instance)
        if child:IsA("Humanoid") then
            disconnectSeatedConnection()
            disconnectChildAddedConnection()
            connection3 = child.Seated:connect(onSeated)
        end
    end)
end
if LocalPlayer.Character then
    characterAdded(LocalPlayer.Character)
end
LocalPlayer.CharacterAdded:connect(function(character: Model)
    onSeated(false, nil)
    characterAdded(character)
end)

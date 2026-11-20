-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:21:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local pearl = Color3.new(76 / 85, 236 / 255, 82 / 85)
local reallyRed = Color3.new(1, 28 / 255, 0)
local newYeller = Color3.new(50 / 51, 47 / 51, 0)
local teal = Color3.new(9 / 85, 84 / 85, 107 / 255)

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local StarterGui = game:GetService("StarterGui")
local UserInputService = game:GetService("UserInputService")
local CorePackages = game:GetService("CorePackages")

local _RobloxGui = CoreGui:WaitForChild("RobloxGui")

local HealthbarContainer = Instance.new("Frame")
HealthbarContainer.Name = "HealthbarContainer"
HealthbarContainer.BackgroundTransparency = 1
HealthbarContainer.Size = UDim2.new(1, 0, 1, 0)

local HealthbarBack = Instance.new("ImageLabel")
HealthbarBack.ImageColor3 = pearl
HealthbarBack.BackgroundTransparency = 1
HealthbarBack.ScaleType = Enum.ScaleType.Slice
HealthbarBack.SliceCenter = Rect.new(10, 10, 10, 10)
HealthbarBack.Name = "HealthbarBack"
HealthbarBack.Image = "rbxasset://textures/ui/VR/rectBackgroundWhite.png"
HealthbarBack.Size = UDim2.new(1, 0, 0.3, 0)
HealthbarBack.Position = UDim2.new(0, 0, 0.7, 0)
HealthbarBack.Parent = HealthbarContainer

local HealthbarFill = Instance.new("ImageLabel")
HealthbarFill.ImageColor3 = teal
HealthbarFill.BackgroundTransparency = 1
HealthbarFill.ScaleType = Enum.ScaleType.Slice
HealthbarFill.SliceCenter = Rect.new(10, 10, 10, 10)
HealthbarFill.Size = UDim2.new(1, 0, 1, 0)
HealthbarFill.Position = UDim2.new(0, 0, 0, 0)
HealthbarFill.Name = "HealthbarFill"
HealthbarFill.Image = "rbxasset://textures/ui/VR/rectBackgroundWhite.png"
HealthbarFill.Parent = HealthbarBack

local PlayerName = Instance.new("TextLabel")
PlayerName.Name = "PlayerName"
PlayerName.BackgroundTransparency = 1
PlayerName.TextColor3 = Color3.new(1, 1, 1)
PlayerName.Text = ""
PlayerName.Font = Enum.Font.SourceSansBold
PlayerName.FontSize = Enum.FontSize.Size24
PlayerName.TextXAlignment = Enum.TextXAlignment.Left
PlayerName.Size = UDim2.new(1, 0, 0, 14)
PlayerName.Parent = HealthbarContainer

local function Color3ToVec3(color3: Color3): Vector3 -- Luacid: Inlined by compiler; 3 call sites recovered
    return Vector3.new(color3.r, color3.g, color3.b)
end

local function FindChildOfType(arg1, str1: string)
    for _, child in pairs(arg1:GetChildren()) do
        if child:IsA(str1) then
            return child
        end
    end
end

local tbl1 = {
    [Color3ToVec3(reallyRed)] = 0.1,
    [Color3ToVec3(newYeller)] = 0.5,
    [Color3ToVec3(teal)] = 0.8
}

local function HealthbarColorTransferFunction(xScale)
    if xScale <= 0.1 then
        return reallyRed
    end

    if xScale >= 0.8 then
        return teal
    end

    local vec3 = Vector3.new(0, 0, 0)
    local num1 = 0
    for k, value in pairs(tbl1) do
        local var1 = xScale - value
        if var1 == 0 then
            return Color3.new(k.x, k.y, k.z)
        end
        local var2 = 1 / (var1 * var1)
        vec3 += var2 * k
        num1 += var2
    end

    local var1 = vec3 / num1
    return Color3.new(var1.x, var1.y, var1.z)
end

local function UpdateHealth(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    local var1 = arg1.Health / arg1.MaxHealth
    local xScale = if var1 ~= var1 then 1 else var1

    HealthbarFill.ImageColor3 = HealthbarColorTransferFunction(xScale)
    HealthbarFill.Size = UDim2.new(xScale, 0, 1, 0)
end

local connection = nil
local connection2 = nil
local function RegisterHumanoid(arg1)
    if connection2 then
        connection2:disconnect()
        connection2 = nil
    end
    if connection then
        connection:disconnect()
        connection = nil
    end

    if not arg1 then
        return
    end

    connection2 = arg1.AncestryChanged:connect(function(child: Instance, parent: Instance)
        local localPlayer = Players.LocalPlayer
        if child == arg1 and (not localPlayer or parent ~= localPlayer.Character) then
            RegisterHumanoid(nil)
        end
    end)
    connection = arg1.HealthChanged:connect(function()
        UpdateHealth(arg1)
    end)

    UpdateHealth(arg1)
end

local function OnCharacterChildAdded(child: Instance)
    local localPlayer = Players.LocalPlayer
    if localPlayer and child.Parent == localPlayer.Character and child:IsA("Humanoid") then
        RegisterHumanoid(child)
    end
end

local connection3 = nil
local function OnCharacterAdded(arg1) -- Luacid: Inlined by compiler; 3 call sites recovered
    local childOfType = FindChildOfType(arg1, "Humanoid")
    if childOfType then
        RegisterHumanoid(childOfType)
    end

    if connection3 then
        connection3:disconnect()
        connection3 = nil
    end
    connection3 = arg1.ChildAdded:connect(OnCharacterChildAdded)
end

local function OnPlayerAdded(player: Player) -- Luacid: Inlined by compiler; 2 call sites recovered
    PlayerName.Text = player.Name

    player.CharacterAdded:connect(OnCharacterAdded)
    if player.Character then
        OnCharacterAdded(player.Character)
    end
end

if Players.LocalPlayer then
    OnPlayerAdded(Players.LocalPlayer)
else
    spawn(function()
        while not Players.LocalPlayer do
            Players.ChildAdded:wait()
        end
        OnPlayerAdded(Players.LocalPlayer)
    end)
end

local tbl2 = {
    ModuleName = "Healthbar",
    KeepVRTopbarOpen = false,
    VRIsExclusive = false,
    VRClosesNonExclusive = false
}
local connection4 = nil
local connection5 = nil
local connection6 = nil
local function OnVREnabled(property: string)
    if property ~= "VREnabled" then
        return
    end

    if not UserInputService.VREnabled then
        if connection4 then
            connection4:disconnect()
            connection4 = nil
        end
        if connection5 then
            connection5:disconnect()
            connection5 = nil
        end
        if connection6 then
            connection6:disconnect()
            connection6 = nil
        end
        HealthbarContainer.Parent = nil
        return
    end

    local vrHub = require(CorePackages.Workspace.Packages.VrCommon).VRHub
    local panel3D = require(CorePackages.Workspace.Packages.VrCommon).Panel3D

    local var1 = panel3D.Get("Healthbar")
    var1:ResizeStuds(1.5, 0.25, 128)
    var1:SetType(panel3D.Type.Fixed, { CFrame = CFrame.new(0, 0, -5) })
    var1:SetVisible(true)

    function var1.PreUpdate(arg1, _, _, _, _)
        local var2 = panel3D.Get("Backpack") or panel3D.Get("Topbar3D")
        local var3 = panel3D.Get("Topbar3D")
        if var2 and var3 then
            arg1.localCF = (var2.localCF or CFrame.new()) * CFrame.new(math.max(var3.width, var2.width) / 2 - var1.width / 2 - 0.11, 0.25, 0.1)
        end
    end

    function var1.CalculateTransparency(_): number
        local var2 = panel3D.Get("Backpack")
        local var3 = panel3D.Get("Topbar3D")
        local num1 = math.min(
            var2 and var2:IsVisible() and var2:CalculateTransparency() or 1,
            var3 and var3:IsVisible() and var3:CalculateTransparency() or 1
        )
        HealthbarBack.ImageTransparency = num1
        HealthbarFill.ImageTransparency = num1
        PlayerName.TextTransparency = num1

        return num1
    end

    local bool1 = false
    local function UpdateExclusivePanelOpen() -- Luacid: Inlined by compiler; 3 call sites recovered
        for _, value in pairs(vrHub:GetOpenedModules()) do
            if value.VRIsExclusive then
                bool1 = true
                return
            end
        end
        bool1 = false
    end

    local function CalculateVisibility(): boolean -- Luacid: Inlined by compiler; 4 call sites recovered
        return StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType.Health) and not bool1
    end

    connection4 = StarterGui.CoreGuiChangedSignal:connect(function()
        var1:SetVisible((CalculateVisibility()))
    end)

    connection5 = vrHub.ModuleOpened.Event:connect(function(_)
        UpdateExclusivePanelOpen()
        var1:SetVisible((CalculateVisibility()))
    end)
    connection6 = vrHub.ModuleClosed.Event:connect(function(_)
        UpdateExclusivePanelOpen()
        var1:SetVisible((CalculateVisibility()))
    end)

    UpdateExclusivePanelOpen()
    var1:SetVisible((CalculateVisibility()))
    HealthbarContainer.Parent = var1:GetGUI()

    vrHub:RegisterModule(tbl2)
end

UserInputService.Changed:connect(OnVREnabled)
if UserInputService.VREnabled then
    OnVREnabled("VREnabled")
end

return tbl2

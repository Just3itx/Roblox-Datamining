-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T21:21:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VirtualCursor = script:FindFirstAncestor("VirtualCursor")
local _VirtualCursorParent = VirtualCursor.Parent

local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")

local VRService = game:GetService("VRService")
local _RobloxGui = CoreGui.RobloxGui
local Properties = require(VirtualCursor.Properties)

local module = {}

local tbl1 = {
    Default = "rbxasset://textures/ui/VirtualCursor/cursorDefault.png",
    Hover = "rbxasset://textures/ui/VirtualCursor/cursorHover.png",
    Pressed = "rbxasset://textures/ui/VirtualCursor/cursorPressed.png",
    Arrow = "rbxasset://textures/ui/VirtualCursor/cursorArrow.png"
}

local screenGui = nil
local imageLabel = nil

local var1 = nil
local var2 = nil

local var3 = nil

local var4 = nil
local connection = nil

local tbl2 = { Default = 2, Activated = 1.7 }

local function getCursorSize(arg1): UDim2 -- Luacid: Inlined by compiler; 4 call sites recovered
    local var5 = tbl2[arg1] * Properties.CursorRadius
    return UDim2.fromOffset(var5, var5)
end

local function setCursorHighlight(arg1) -- Luacid: unused: defined but never referenced
    if arg1 then
        imageLabel.Image = "rbxasset://textures/ui/VirtualCursor/cursorHover.png"
        return
    end
    imageLabel.Image = "rbxasset://textures/ui/VirtualCursor/cursorDefault.png"
end

local function setCursorPosition(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    imageLabel.Position = UDim2.fromOffset(arg1.x, arg1.y)
end

local function getOrCreateVirtualCursorContainer()
    if screenGui == nil then
        screenGui = Instance.new("ScreenGui")
        screenGui.Enabled = false
        screenGui.IgnoreGuiInset = true
        screenGui.DisplayOrder = math.huge
        screenGui.OnTopOfCoreBlur = true
        screenGui.Name = "VirtualCursorGui"

        imageLabel = Instance.new("ImageLabel")
        imageLabel.Active = false
        imageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
        imageLabel.Size = getCursorSize("Default")
        imageLabel.Image = "rbxasset://textures/ui/VirtualCursor/cursorDefault.png"
        imageLabel.Visible = false
        imageLabel.BackgroundTransparency = 1
        imageLabel.Transparency = 1

        imageLabel.Parent = screenGui
        screenGui.Parent = CoreGui

        local tweenInfo = TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0)
        var1 = TweenService:Create(imageLabel, tweenInfo, { Size = getCursorSize("Activated") })
        var2 = TweenService:Create(imageLabel, tweenInfo, { Size = getCursorSize("Default") })
    end
    return screenGui
end

local function tweenCursorOpacity(arg1)
    if connection then
        connection:Disconnect()
        connection = nil
    end

    local tweenInfo = TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0)
    var4 = TweenService:Create(imageLabel, tweenInfo, { ImageTransparency = if arg1 then 0 else 1 })
    connection = var4.Completed:Connect(function()
        imageLabel.Visible = arg1
        getOrCreateVirtualCursorContainer().Enabled = arg1
    end)

    var4:Play()
end

local function tweenCursorPosition(arg1)
    local tweenInfo = TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0)
    var3 = TweenService:Create(imageLabel, tweenInfo, { Position = UDim2.fromOffset(arg1.x, arg1.y) })
    var3:Play()
end

function module.GetCursorSize(_, arg1): UDim2
    return getCursorSize(arg1)
end

function module.PlayCursorTweenActivate(_)
    var1:Play()
end

function module.PlayCursorTweenDefault(_)
    var2:Play()
end

local function SetCursorHighlight(_, arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    if arg1 then
        imageLabel.Image = tbl1.Hover
        return
    end
    imageLabel.Image = tbl1.Default
end

module.SetCursorHighlight = SetCursorHighlight

function module.SetCursorPosition(_, arg1)
    setCursorPosition(arg1)
end

function module.TweenCursorPosition(_, arg1)
    tweenCursorPosition(arg1)
end

function module.TweenCursorOpacity(_, arg1)
    tweenCursorOpacity(arg1)
end

function module.SetArrow(_, arg1, arg2)
    if arg1 == -1 and arg2 == 0 then
        imageLabel.Rotation = 90
    elseif arg2 == 0 then
        imageLabel.Rotation = 270
    end

    if arg1 == 0 and arg2 == 1 then
        imageLabel.Rotation = 0
    elseif arg1 == 0 then
        imageLabel.Rotation = 180
    end

    imageLabel.Image = "rbxasset://textures/ui/VirtualCursor/cursorArrow.png"
end

function module.EnableUI(_, arg1)
    local bool1 = not VRService.VREnabled

    getOrCreateVirtualCursorContainer().Enabled = bool1
    imageLabel.Size = getCursorSize("Default")
    setCursorPosition(arg1)
    imageLabel.Visible = bool1

    module:TweenCursorOpacity(true)
end

function module.DisableUI(_)
    SetCursorHighlight(nil, false)
    module:TweenCursorOpacity(false)
end

return module

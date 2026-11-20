-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:21:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local UserInputService = game:GetService("UserInputService")
local ContextActionService = game:GetService("ContextActionService")
local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")
local _RobloxGui = CoreGui:WaitForChild("RobloxGui")
local Panel3D = require(CorePackages.Workspace.Packages.VrCommon).Panel3D
local VRHub = require(CorePackages.Workspace.Packages.VrCommon).VRHub
local Create = require(CorePackages.Workspace.Packages.AppCommonLib).Create

local IsVisible = false

local module = {
    ModuleName = "Recenter",
    KeepVRTopbarOpen = true,
    VRIsExclusive = true,
    VRClosesNonExclusive = false
}
VRHub:RegisterModule(module)

local var1 = Panel3D.Get("RecenterCountdown")
var1:SetType(Panel3D.Type.HorizontalFollow)
var1:ResizeStuds(5, 3, 128)
var1:SetCanFade(false)

local var2 = Create("TextLabel")({
    Parent = var1:GetGUI(),
    Position = UDim2.new(0.5, -64, 0.5, -64),
    Size = UDim2.new(0, 128, 0, 128),
    BackgroundTransparency = 0.9,
    BackgroundColor3 = Color3.new(0.2, 0.2, 0.2),
    TextColor3 = Color3.new(1, 1, 1),
    Text = "",
    TextScaled = true,
    Font = Enum.Font.SourceSansBold,
    Visible = true
})

Create("ImageLabel")({
    Parent = var1:GetGUI(),
    Position = UDim2.new(0, 0, 0, 0),
    Size = UDim2.new(1, 0, 1, 0),
    BackgroundTransparency = 1,
    Image = "rbxasset://textures/ui/VR/recenterFrame.png"
})

var1:SetVisible(false)

local bool2 = false
local function cancelCountdown() -- Luacid: Inlined by compiler; 4 call sites recovered
    bool2 = false
    var1:SetVisible(false)
end

VRHub.ModuleOpened.Event:connect(function(moduleName)
    if moduleName ~= module.ModuleName and VRHub:GetModule(moduleName).VRIsExclusive then
        cancelCountdown()
    end
end)

function module.SetVisible(_, arg1)
    IsVisible = arg1

    if not IsVisible then
        cancelCountdown()
        VRHub:FireModuleClosed(module.ModuleName)

        return
    end

    if bool2 then
        cancelCountdown()
        VRHub:FireModuleClosed(module.ModuleName)
        return
    end
    VRHub:FireModuleOpened(module.ModuleName)

    spawn(function()
        bool2 = true
        var1:SetVisible(true)

        ContextActionService:BindCoreAction("CancelRecenterShortcut", function(_, userInputState, _)
            if userInputState == Enum.UserInputState.Begin then
                cancelCountdown()
            end
        end, false, Enum.KeyCode.ButtonB)

        if bool2 then
            var2.Text = tostring(3)
            wait(1)
        end

        if bool2 then
            var2.Text = tostring(2)
            wait(1)
        end

        if bool2 then
            var2.Text = tostring(1)
            wait(1)
        end

        if bool2 then
            UserInputService:RecenterUserHeadCFrame()
        end

        var1:SetVisible(false)
        bool2 = false

        ContextActionService:UnbindCoreAction("CancelRecenterShortcut")

        VRHub:FireModuleClosed(module.ModuleName)
    end)
end

function module.IsVisible(_)
    return IsVisible
end

return module

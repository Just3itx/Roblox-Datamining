-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:31:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VrCommonParent = script:FindFirstAncestor("VrCommon").Parent

local StarterGui = game:GetService("StarterGui")
local VRService = game:GetService("VRService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")
local ContextActionService = game:GetService("ContextActionService")

local Create = require(VrCommonParent.AppCommonLib).Create

local LaserPointer = require(script.Parent.LaserPointer)

local VRControllerModel = require(script.Parent.VRControllerModel)

local SplashScreenManager = require(VrCommonParent.SplashScreenManager).SplashScreenManager

local SafetyBubble = require(script.Parent.SafetyBubble)

local module = {}
local tbl1 = {}
local tbl2 = ({})

local name = HttpService:GenerateGUID(true)

module.LaserPointer = nil

module.ControllerModelsEnabled = false
module.LeftControllerModel = nil
module.RightControllerModel = nil

module.isFPSAtTarget = SplashScreenManager.isFPSAtTarget()
module.SafetyBubble = nil

module.IsFirstPerson = false

StarterGui:RegisterSetCore("VRLaserPointerMode", function(arg1)
    if module.LaserPointer and arg1 and tostring(arg1) then
        module.LaserPointer:setMode(LaserPointer.Mode[tostring(arg1)] or LaserPointer.Mode.Disabled)
    end
end)

local function enableControllerModels(controllerModelsEnabled: boolean)
    if controllerModelsEnabled == module.ControllerModelsEnabled then
        return
    end

    module.ControllerModelsEnabled = controllerModelsEnabled

    if controllerModelsEnabled then
        if not module.LeftControllerModel then
            module.LeftControllerModel = VRControllerModel.new(Enum.UserCFrame.LeftHand)
        end
        module.LeftControllerModel:setEnabled(true)

        if not module.RightControllerModel then
            module.RightControllerModel = VRControllerModel.new(Enum.UserCFrame.RightHand)
        end
        module.RightControllerModel:setEnabled(true)
        return
    end
    if module.LeftControllerModel then
        module.LeftControllerModel:setEnabled(false)
    end
    if module.RightControllerModel then
        module.RightControllerModel:setEnabled(false)
    end
end

StarterGui:RegisterSetCore("VREnableControllerModels", function(arg1)
    if arg1 then
        VRService.ControllerModels = Enum.VRControllerModelMode.Transparent
        return
    end
    VRService.ControllerModels = Enum.VRControllerModelMode.Disabled
end)

VRService:GetPropertyChangedSignal("ControllerModels"):Connect(function()
    enableControllerModels(VRService.ControllerModels == Enum.VRControllerModelMode.Transparent)
end)

local var1 = tick()
local function onRenderSteppedLast()
    local now = tick()
    local var2 = now - var1
    var1 = now

    if module.LaserPointer then
        module.LaserPointer:update(var2)
    end

    if module.LeftControllerModel then
        module.LeftControllerModel:update(var2)
    end
    if module.RightControllerModel then
        module.RightControllerModel:update(var2)
    end

    if module.SafetyBubble then
        module.SafetyBubble:update(var2)
    end
end

local function onCameraCFrameChanged()
    if module.LaserPointer then
        module.LaserPointer:update(0)
    end
    if module.LeftControllerModel then
        module.LeftControllerModel:update(0)
    end
    if module.RightControllerModel then
        module.RightControllerModel:update(0)
    end
end

local connection = nil
local function onCurrentCameraChanged() -- Luacid: Inlined by compiler; 1 call site recovered
    if connection then
        connection:disconnect()
    end
    if workspace.CurrentCamera then
        connection = workspace.CurrentCamera:GetPropertyChangedSignal("CFrame"):Connect(onCameraCFrameChanged)
    end
end

workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(onCurrentCameraChanged)
onCurrentCameraChanged()

local function onVREnabledChanged()
    if not VRService.VREnabled then
        if module.LaserPointer then
            module.LaserPointer:setMode(LaserPointer.Mode.Disabled)
        end
        RunService:UnbindFromRenderStep(name)

        return
    end

    UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
    UserInputService.OverrideMouseIconBehavior = Enum.OverrideMouseIconBehavior.ForceHide

    if not module.LaserPointer then
        module.LaserPointer = LaserPointer.new()
    end

    if module.LaserPointer then
        if module.isFPSAtTarget then
            module.LaserPointer:setMode(LaserPointer.Mode.Navigation)
        else
            module.LaserPointer:setMode(LaserPointer.Mode.Disabled)
        end
    end

    enableControllerModels(VRService.ControllerModels == Enum.VRControllerModelMode.Transparent)

    RunService:BindToRenderStep(name, Enum.RenderPriority.Last.Value, onRenderSteppedLast)

    if module.LaserPointer then
        module.LaserPointer:setForcePointer(true)
    end
    UserInputService.OverrideMouseIconBehavior = Enum.OverrideMouseIconBehavior.ForceHide

    module.SafetyBubble = SafetyBubble.new()

    ContextActionService:BindCoreActivate(Enum.UserInputType.Gamepad1, Enum.KeyCode.ButtonR2)
end

local function onVRSessionStateChanged()
    if VRService.VRSessionState == Enum.VRSessionState.Focused then
        if module.LaserPointer and module.LaserPointer.Mode.Disabled then
            module.LaserPointer:setMode(LaserPointer.Mode.Navigation)
            enableControllerModels(VRService.ControllerModels == Enum.VRControllerModelMode.Transparent)
        end
        if not module.ControllerModelsEnabled then
            enableControllerModels(VRService.ControllerModels == Enum.VRControllerModelMode.Transparent)
        end

        return
    end

    if module.LaserPointer and module.LaserPointer.Mode.Navigation then
        module.LaserPointer:setMode(LaserPointer.Mode.Disabled)
    end

    if not module.ControllerModelsEnabled or module.ControllerModelsEnabled == false then
        return
    end

    module.ControllerModelsEnabled = false

    if module.LeftControllerModel then
        module.LeftControllerModel:setEnabled(false)
    end
    if module.RightControllerModel then
        module.RightControllerModel:setEnabled(false)
    end
end

onVREnabledChanged()

VRService.Changed:connect(function(property: string) -- name: onVRPropertyChanged
    if property == "VREnabled" then
        onVREnabledChanged()
    elseif property == "VRSessionState" then
        onVRSessionStateChanged()
    end
end)

function module.RegisterModule(_, arg1)
    tbl1[arg1.ModuleName] = arg1
end

function module.GetModule(_, arg1)
    return tbl1[arg1]
end

function module.IsModuleOpened(_, arg1): boolean
    return tbl2[arg1] ~= nil
end

function module.GetOpenedModules(_)
    local openedModules = {}

    for _, value in pairs(tbl2) do
        table.insert(openedModules, value)
    end

    return openedModules
end

module.ModuleOpened = Create("BindableEvent")({ Name = "VRModuleOpened" })

function module.FireModuleOpened(_, arg1)
    if not tbl1[arg1] then
        error("Tried to open module that is not registered: " .. arg1)
    end

    if tbl2[arg1] ~= tbl1[arg1] then
        tbl2[arg1] = tbl1[arg1]
        module.ModuleOpened:Fire(arg1)
    end
end

module.ModuleClosed = Create("BindableEvent")({ Name = "VRModuleClosed" })

function module.FireModuleClosed(_, arg1)
    if not tbl1[arg1] then
        error("Tried to close module that is not registered: " .. arg1)
    end

    if tbl2[arg1] ~= nil then
        tbl2[arg1] = nil
        module.ModuleClosed:Fire(arg1)
    end
end

function module.KeepVRTopbarOpen(_)
    for _, value in pairs(tbl2) do
        if value.KeepVRTopbarOpen then
            return true
        end
    end
    return false
end

module.ShowHighlightedLeaveGameIcon = false

module.ShowHighlightedLeaveGameIconToggled = Create("BindableEvent")({ Name = "ShowHighlightedLeaveGameIconToggled" })

function module.SetShowHighlightedLeaveGameIconToggled(_, showHighlightedLeaveGameIcon)
    if module.ShowHighlightedLeaveGameIcon ~= showHighlightedLeaveGameIcon then
        module.ShowHighlightedLeaveGameIcon = showHighlightedLeaveGameIcon
        module.ShowHighlightedLeaveGameIconToggled:Fire()
    end
end

module.ShowTopBar = true
module.ShowMoreMenu = false

module.ShowTopBarChanged = Create("BindableEvent")({ Name = "ShowTopBarChanged" })

module.ShowMoreMenuChanged = Create("BindableEvent")({ Name = "ShowMoreMenuChanged" })

function module.SetShowTopBar(_, showTopBar)
    if module.ShowTopBar ~= showTopBar then
        module.ShowTopBar = showTopBar
        module.ShowTopBarChanged:Fire()
    end
end

function module.SetShowMoreMenu(_, showMoreMenu)
    if module.ShowMoreMenu ~= showMoreMenu then
        module.ShowMoreMenu = showMoreMenu
        module.ShowMoreMenuChanged:Fire()
    end
end

function module.ToggleSafetyBubble(_)
    if module.SafetyBubble then
        module.SafetyBubble:ToggleEnabled()
    end
end

function module.GetControllerModel(_, userCFrame)
    if userCFrame == Enum.UserCFrame.LeftHand then
        return module.LeftControllerModel
    end

    if userCFrame == Enum.UserCFrame.RightHand then
        return module.RightControllerModel
    end

    return nil
end

function module.GetControllerButtonPosition(_, arg1)
    return module.LeftControllerModel and module.LeftControllerModel:getButtonPosition(arg1), module.RightControllerModel and module.RightControllerModel:getButtonPosition(arg1)
end

SplashScreenManager.addStatusChangeListener(function(isFpsAtTarget)
    module.isFPSAtTarget = isFpsAtTarget
    onVREnabledChanged()
end)

return module

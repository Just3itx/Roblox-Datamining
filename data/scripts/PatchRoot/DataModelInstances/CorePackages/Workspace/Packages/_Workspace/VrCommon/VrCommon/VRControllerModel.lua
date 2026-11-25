-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:31:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VRService = game:GetService("VRService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local VrCommon = script:FindFirstAncestor("VrCommon")

local ViveController = require(VrCommon.Controllers.ViveController)
local TouchController = require(VrCommon.Controllers.TouchController)
local RiftController = require(VrCommon.Controllers.RiftController)
local IndexController = require(VrCommon.Controllers.IndexController)
local VRUtil = require(VrCommon.VRUtil)

local LocalPlayer = Players.LocalPlayer
while not LocalPlayer do
    Players.Changed:wait()
    LocalPlayer = Players.LocalPlayer
end

local module = {}
module.__index = module

function module.new(userCFrame)
    local self = setmetatable({}, module)
    self.userCFrame = userCFrame
    self.enabled = false
    self.currentModel = nil
    self.currentVRDeviceName = VRService.VRDeviceName
    self.modelIsInWorkspace = false

    self.onVRDeviceChangedConn = nil
    self.onCurrentCameraChangedConn = nil
    self.onUserCFrameEnabledChangedConn = nil
    self.onInputBeganConn = nil
    self.onInputChangedConn = nil
    self.onInputEndedConn = nil

    self.controllerModel = nil

    return self
end

function module:createControllerModel()
    local currentControllerType = VRUtil.getCurrentControllerType()

    if currentControllerType == "Vive" then
        self.controllerModel = ViveController.new(self.userCFrame)
    elseif currentControllerType == "Rift" then
        self.controllerModel = RiftController.new(self.userCFrame)
    elseif currentControllerType == "Index" then
        self.controllerModel = IndexController.new(self.userCFrame)
    elseif currentControllerType == "Touch" then
        self.controllerModel = TouchController.new(self.userCFrame)
    else
        self.controllerModel = RiftController.new(self.userCFrame)
    end
end

function module:setCurrentModel()
    if self.currentModel then
        self:setModelInWorkspace(false)
    end

    if not self.controllerModel then
        self:createControllerModel()
    end
    self.currentModel = self.controllerModel

    if self.enabled then
        self:setModelInWorkspace(VRService:GetUserCFrameEnabled(self.userCFrame))
    end
end

function module:setModelInWorkspace(modelIsInWorkspace)
    if not self.currentModel then
        return
    end

    if modelIsInWorkspace == self.modelIsInWorkspace then
        return
    end

    self.modelIsInWorkspace = modelIsInWorkspace
    if not self.currentModel.model then
        self.currentModel:setInWorkspace(modelIsInWorkspace)
        return
    end

    if self.modelIsInWorkspace then
        self.currentModel.model.Parent = workspace
        return
    end
    self.currentModel.model.Parent = nil
end

function module:setEnabled(enabled)
    if enabled == self.enabled then
        return
    end

    self.enabled = enabled

    if self.enabled then
        self:setCurrentModel()

        self.onCurrentCameraChangedConn = workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
            self:setModelInWorkspace(VRService:GetUserCFrameEnabled(self.userCFrame))
        end)

        self.onUserCFrameEnabledChangedConn = VRService.UserCFrameEnabled:connect(function(type: Enum.UserCFrame, enabled: boolean)
            if type == self.userCFrame then
                self:setModelInWorkspace(enabled)
            end
        end)

        self.onInputBeganConn = UserInputService.InputBegan:connect(function(...)
            self:onInputBegan(...)
        end)
        self.onInputChangedConn = UserInputService.InputChanged:connect(function(...)
            self:onInputChanged(...)
        end)
        self.onInputEndedConn = UserInputService.InputEnded:connect(function(...)
            self:onInputEnded(...)
        end)

        self:setModelInWorkspace(VRService:GetUserCFrameEnabled(self.userCFrame))
        return
    end

    if self.onVRDeviceChangedConn then
        self.onVRDeviceChangedConn:disconnect()
        self.onVRDeviceChangedConn = nil
    end
    if self.onCurrentCameraChangedConn then
        self.onCurrentCameraChangedConn:disconnect()
        self.onCurrentCameraChangedConn = nil
    end
    if self.onUserCFrameEnabledChangedConn then
        self.onUserCFrameEnabledChangedConn:disconnect()
        self.onUserCFrameEnabledChangedConn = nil
    end
    if self.onInputBeganConn then
        self.onInputBeganConn:disconnect()
        self.onInputBeganConn = nil
    end
    if self.onInputChangedConn then
        self.onInputChangedConn:disconnect()
        self.onInputChangedConn = nil
    end
    if self.onInputEndedConn then
        self.onInputEndedConn:disconnect()
        self.onInputEndedConn = nil
    end

    if self.currentModel then
        self:setModelInWorkspace(false)
    end
end

function module:update(_)
    if not self.enabled then
        return
    end

    if self.currentModel then
        local userCFrameWorldSpace = VRUtil.GetUserCFrameWorldSpace(self.userCFrame)
        self.currentModel:setCFrameAndScale(userCFrameWorldSpace, workspace.CurrentCamera.HeadScale)
    end
end

function module:onInputBegan(arg1, _)
    if not (self.enabled and self.modelIsInWorkspace) then
        return
    end
    if self.currentModel then
        self.currentModel:onInputBegan(arg1)
    end
end

function module:onInputChanged(arg1, _)
    if not (self.enabled and self.modelIsInWorkspace) then
        return
    end
    if self.currentModel then
        self.currentModel:onInputChanged(arg1)
    end
end

function module:onInputEnded(arg1, _)
    if self.currentModel then
        self.currentModel:onInputEnded(arg1)
    end
end

function module:getButtonPosition(arg1)
    if not self.currentModel or not self.currentModel.getButtonPart then
        return
    end

    local buttonPart = self.currentModel:getButtonPart(arg1)
    if buttonPart then
        return buttonPart.Position
    end
end

return module

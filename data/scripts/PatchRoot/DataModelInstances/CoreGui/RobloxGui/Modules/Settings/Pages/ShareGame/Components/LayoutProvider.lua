-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:21:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local Modules = game:GetService("CoreGui").RobloxGui.Modules
local UserInputService = game:GetService("UserInputService")

local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)

local ShareGame = Modules.Settings.Pages.ShareGame
local Constants = require(ShareGame.Constants)

local SetDeviceOrientation = require(CorePackages.Workspace.Packages.DeviceOrientationRodux).Actions.SetDeviceOrientation
local SetIsSmallTouchScreen = require(ShareGame.Actions.SetIsSmallTouchScreen)
local SetDeviceLayout = require(ShareGame.Actions.SetDeviceLayout)

local var1 = Roact.Component:extend("LayoutProvider")

function var1.didMount(arg1)
    if workspace.CurrentCamera then
        arg1:setObservedCamera(workspace.CurrentCamera)
    end

    arg1.cameraChangedListener = workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
        if workspace.CurrentCamera then
            arg1:setObservedCamera(workspace.CurrentCamera)
        end
    end)
end

function var1.willUnmount(arg1)
    if arg1.cameraChangedListener then
        arg1.cameraChangedListener:Disconnect()
    end

    if arg1.viewportSizeListener then
        arg1.viewportSizeListener:Disconnect()
    end
end

function var1.setObservedCamera(arg1, arg2)
    if arg1.viewportSizeListener then
        arg1.viewportSizeListener:Disconnect()
    end

    arg1:checkAllDeviceInfo(arg2.ViewportSize)
    arg1.viewportSizeListener = arg2:GetPropertyChangedSignal("ViewportSize"):Connect(function()
        local viewportSize = arg2.ViewportSize
        if viewportSize.X <= 1 or viewportSize.Y <= 1 then
            return
        end

        arg1:checkAllDeviceInfo(viewportSize)
    end)
end

function var1.checkDeviceOrientation(arg1, arg2)
    local _deviceOrientation = arg2.X > arg2.Y and Constants.DeviceOrientation.LANDSCAPE or Constants.DeviceOrientation.PORTRAIT

    if arg1._deviceOrientation ~= _deviceOrientation then
        arg1._deviceOrientation = _deviceOrientation
        arg1.props.setDeviceOrientation(_deviceOrientation)
    end
end

function var1.checkDeviceIsSmallTouchScreen(arg1, arg2)
    local _isSmallTouchScreen = UserInputService.TouchEnabled and (arg2.X < 700 or arg2.Y < 500)

    if arg1._isSmallTouchScreen ~= _isSmallTouchScreen then
        arg1._isSmallTouchScreen = _isSmallTouchScreen
        arg1.props.setIsSmallTouchScreen(arg1._isSmallTouchScreen)
    end
end

function var1.checkDeviceLayout(arg1)
    local var2

    if arg1._isSmallTouchScreen then
        if arg1._deviceOrientation == Constants.DeviceOrientation.LANDSCAPE then
            var2 = Constants.DeviceLayout.PHONE_LANDSCAPE
        else
            var2 = Constants.DeviceLayout.PHONE_PORTRAIT
        end
    elseif UserInputService.TouchEnabled then
        if arg1._deviceOrientation == Constants.DeviceOrientation.LANDSCAPE then
            var2 = Constants.DeviceLayout.TABLET_LANDSCAPE
        else
            var2 = Constants.DeviceLayout.TABLET_PORTRAIT
        end
    else
        var2 = Constants.DeviceLayout.DESKTOP
    end

    if arg1._deviceLayout ~= var2 then
        arg1._deviceLayout = var2
        arg1.props.setDeviceLayout(arg1._deviceLayout)
    end
end

function var1.checkAllDeviceInfo(arg1, arg2)
    arg1:checkDeviceOrientation(arg2)
    arg1:checkDeviceIsSmallTouchScreen(arg2)
    arg1:checkDeviceLayout()
end

function var1.render(arg1)
    return Roact.oneChild(arg1.props[Roact.Children])
end

return RoactRodux.UNSTABLE_connect2(nil, function(arg1)
    return {
        setDeviceOrientation = function(arg2)
            return arg1(SetDeviceOrientation(arg2))
        end,
        setIsSmallTouchScreen = function(arg2)
            return arg1(SetIsSmallTouchScreen(arg2))
        end,
        setDeviceLayout = function(arg2)
            return arg1(SetDeviceLayout(arg2))
        end
    }
end)(var1)

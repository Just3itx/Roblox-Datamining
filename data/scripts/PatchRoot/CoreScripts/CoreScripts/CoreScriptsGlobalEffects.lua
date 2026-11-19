-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:31:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local CoreGui = game:GetService("CoreGui")
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
local RobloxGui = CoreGui:WaitForChild("RobloxGui")
local CoreScriptsRootProvider = require(CorePackages.Workspace.Packages.CoreScriptsRoactCommon).CoreScriptsRootProvider
local usePlayerCurrentScreenOrientation = require(RobloxGui.Modules.Common.Hooks.usePlayerCurrentScreenOrientation)

local CoreScriptsGamepadDisconnectListener = require(RobloxGui.Modules.GamepadDisconnect.CoreScriptsGamepadDisconnectListener)
local React = require(CorePackages.Packages.React)
local Roact = require(CorePackages.Packages.Roact)

local DeviceType = require(CorePackages.Workspace.Packages.RobloxAppEnums).DeviceType
local useLogInputTypeChanged = require(CorePackages.Workspace.Packages.UiShellEvents).useLogInputTypeChanged
local useLogOrientationChanged = require(CorePackages.Workspace.Packages.UiShellEvents).useLogOrientationChanged

local EventIngestService = game:GetService("EventIngestService")
local var1 = require(CorePackages.Workspace.Packages.Analytics).AnalyticsReporters.EventIngest.new(EventIngestService)
local engineFeature = game:GetEngineFeature("RbxAnalyticsServiceExposePlaySessionId")
local UserInputService = game:GetService("UserInputService")
local getInputGroup = require(CorePackages.Workspace.Packages.InputType).getInputGroup
local useExternalEvent = require(CorePackages.Workspace.Packages.RoactUtils).Hooks.useExternalEvent
local bool1 = game:DefineFastFlag("RemoveLoggingHookForCorescriptGlobalEffects2", false)

local currentInputType = nil

local function sendInputTypeLogging(inputType: string?)
    if currentInputType == inputType then
        return
    end

    currentInputType = inputType
    local gamepadConnected = UserInputService:GetGamepadConnected(Enum.UserInputType.Gamepad1)
    local playSessionId = if engineFeature then RbxAnalyticsService:GetPlaySessionId() else nil

    if inputType == nil then
        return
    end

    var1:sendEventDeferred(
        "inputTypeChanged",
        "inputTypeChanged",
        {
            inputType = inputType,
            gamepadConnected = gamepadConnected,
            playSessionId = playSessionId
        }
    )
end

Roact.mount(React.createElement(function(_) -- name: CoreScriptsGlobalEffects
    if bool1 then
        local var2 = React.useCallback(function(arg1)
            sendInputTypeLogging(getInputGroup(arg1))
        end, {})

        useExternalEvent(UserInputService.LastInputTypeChanged, var2)
    elseif engineFeature then
        useLogInputTypeChanged(var1, RbxAnalyticsService:GetPlaySessionId())
    else
        useLogInputTypeChanged(var1)
    end

    local var2 = usePlayerCurrentScreenOrientation()
    useLogOrientationChanged(var1, var2)

    local styleOverride = {
        deviceType = DeviceType.Console
    }

    return React.createElement(
        CoreScriptsRootProvider,
        { styleOverride = styleOverride },
        {
            CoreScriptsGamepadDisconnectListener = React.createElement(CoreScriptsGamepadDisconnectListener)
        }
    )
end), CoreGui, "CoreScriptsGlobalEffects")

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:51:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserInputService = game:GetService("UserInputService")
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
local scriptParentParent = script.Parent.Parent
local Constants = require(scriptParentParent.Resources.Constants)

local engineFeature = game:GetEngineFeature("RbxAnalyticsServiceExposePlaySessionId")

local InputTypeMap = Constants.InputTypeMap

return function(arg1, arg2, arg3, arg4, arg5)
    if arg5 == nil then
        arg5 = RbxAnalyticsService
    end

    local function reportSettingsForAnalytics()
        local GameSettings = UserSettings().GameSettings

        local result = ({})

        if UserInputService.TouchEnabled then
            result.camera_mode_touch = tostring(GameSettings.TouchCameraMovementMode)
        else
            result.camera_mode_desktop = tostring(GameSettings.ComputerCameraMovementMode)
        end

        if UserInputService.TouchEnabled then
            result.movement_mode_touch = tostring(GameSettings.TouchMovementMode)
        else
            result.movement_mode_desktop = tostring(GameSettings.ComputerMovementMode)
        end

        if UserInputService.MouseEnabled then
            result.shift_lock_enabled = tostring(GameSettings.ControlMode == Enum.ControlMode.MouseLockSwitch)
        end

        if UserInputService.GamepadEnabled and GameSettings.IsUsingGamepadCameraSensitivity then
            result.camera_sensitivity_gamepad = string.format("%.2f", GameSettings.GamepadCameraSensitivity)
        end
        if UserInputService.MouseEnabled then
            result.camera_sensitivity_mouse = string.format("%.2f", GameSettings.MouseSensitivityFirstPerson.X)
        end

        result.camera_y_inverted = tostring(GameSettings.CameraYInverted)
        result.show_performance_stats = tostring(GameSettings.PerformanceStatsVisible)
        result.volume = tostring(math.floor(GameSettings.MasterVolume * 10 + 0.5))
        result.gfx_quality_level = tostring(settings().Rendering.QualityLevel)
        result.fullscreen_enabled = tostring(GameSettings:InFullScreen())
        result.microprofiler_enabled = tostring(GameSettings.OnScreenProfilerEnabled)
        result.microprofiler_webserver_enabled = tostring(GameSettings.MicroProfilerWebServerEnabled)

        return result
    end

    if arg4 == true then
        arg3 = reportSettingsForAnalytics()
        arg2 = Constants.AnalyticsSettingsChangeName
        arg1 = Constants.AnalyticsInGameMenuName
    end

    arg3 = arg3 or {}

    local gameId = game.GameId
    arg3.universeid = tostring(gameId)

    local var1 = InputTypeMap[UserInputService:GetLastInputType()] or UserInputService:GetLastInputType()
    arg3.inputDevice = tostring(var1)

    if arg3.playsessionid == nil and engineFeature then
        arg3.playsessionid = RbxAnalyticsService:GetPlaySessionId()
    end

    arg5:SetRBXEventStream(Constants.AnalyticsTargetName, arg1, arg2, arg3)
end

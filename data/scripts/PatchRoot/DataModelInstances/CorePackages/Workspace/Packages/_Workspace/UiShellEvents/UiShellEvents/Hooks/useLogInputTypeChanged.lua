-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T19:51:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UiShellEvents = script:FindFirstAncestor("UiShellEvents")
local UserInputService = game:GetService("UserInputService")
local UiShellEventsParent = UiShellEvents.Parent
local React = require(UiShellEventsParent.React)
local logInputTypeChanged = require(UiShellEvents.Analytics.logInputTypeChanged)
local useInputType = require(UiShellEventsParent.RoactUtils).Hooks.useInputType
local useIsTvRemoteDevice = require(UiShellEventsParent.RoactUtils).Hooks.useIsTvRemoteDevice

local bool1 = game:DefineFastFlag("LogInputTypeChangedTvRemote1", false)

local function getConnectedGamepadTypes(arg1: {Enum.UserInputType}?)
    if arg1 == nil then
        return nil
    end

    local connectedGamepadTypes = {}
    for _, userInputType in arg1 do
        if not UserInputService:GamepadSupports(userInputType, Enum.KeyCode.Return) then
            table.insert(connectedGamepadTypes, "full_gamepad")
        else
            table.insert(connectedGamepadTypes, "tv_remote")
        end
    end
    return connectedGamepadTypes
end

local function anyFullGamepadConnected(arg1: {Enum.UserInputType}?)
    if arg1 == nil then
        return nil
    end

    for _, userInputType in arg1 do
        if not UserInputService:GamepadSupports(userInputType, Enum.KeyCode.Return) then
            return true
        end
    end
    return false
end

local function useLogInputTypeChanged(arg1, playSessionId: string?)
    local inputType = useInputType()
    local isTvRemote = if bool1 then useIsTvRemoteDevice() else nil
    local connectedGamepads = if bool1 then UserInputService:GetConnectedGamepads() else nil
    local var1 = if bool1 then anyFullGamepadConnected(connectedGamepads) else nil
    local connectedGamepadTypes = if bool1 then getConnectedGamepadTypes(connectedGamepads) else nil
    local var2 = if connectedGamepadTypes then table.concat(connectedGamepadTypes, ",") else nil

    React.useEffect(function()
        local gamepadConnected = UserInputService:GetGamepadConnected(Enum.UserInputType.Gamepad1)
        logInputTypeChanged(arg1, "inputTypeChanged", {
            inputType = inputType,
            gamepadConnected = gamepadConnected,
            anyFullGamepadConnected = var1,
            connectedGamepads = var2,
            isTvRemote = isTvRemote,
            playSessionId = playSessionId
        })
    end, { inputType, var2 })
end

return useLogInputTypeChanged

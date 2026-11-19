-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:20:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ContextActionService = game:GetService("ContextActionService")
local RunService = game:GetService("RunService")
local _EventType = require(script.Parent.Parent.EventType)

local module = { Name = "FirstPersonToggleEvent" }

local bool1 = false
local connection = nil

local function onFirstPersonToggleInput(arg1, userInputState, _): Enum.ContextActionResult
    if arg1 == "FirstPersonToggleAction" and userInputState == Enum.UserInputState.Begin then
        bool1 = true
    end

    return Enum.ContextActionResult.Pass
end

function startFirstPersonToggleListener()
    ContextActionService:BindCoreAction("FirstPersonToggleAction", onFirstPersonToggleInput, false, Enum.KeyCode.ButtonR3)
end

function stopFirstPersonToggleListener()
    ContextActionService:UnbindAction("FirstPersonToggleAction")
end

function module.StartEvent(callback)
    startFirstPersonToggleListener()

    connection = RunService.RenderStepped:Connect(function(_: number) -- name: onRenderStepped
        if not bool1 then
            return
        end
        stopFirstPersonToggleListener()

        task.wait(0.2)
        callback()

        if connection then
            connection:Disconnect()
            connection = nil
        end
    end)
end

function module.StopEvent()
    if connection then
        connection:Disconnect()
    end
    stopFirstPersonToggleListener()
end

return module

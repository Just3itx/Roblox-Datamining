-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:20:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ContextActionService = game:GetService("ContextActionService")
local RunService = game:GetService("RunService")
local _EventType = require(script.Parent.Parent.EventType)

local module = { Name = "FirstPersonToggleEvent" }

local bool1 = false
local connection = nil

local function onJumpInput(arg1, userInputState, _): Enum.ContextActionResult
    if arg1 == "JumpAction" and userInputState == Enum.UserInputState.Begin then
        bool1 = true
    end

    return Enum.ContextActionResult.Pass
end

function startJumpEventListener()
    ContextActionService:BindCoreAction("JumpAction", onJumpInput, false, Enum.KeyCode.Space)
end

function stopJumpEventListener()
    ContextActionService:UnbindAction("JumpAction")
end

function module.StartEvent(callback)
    startJumpEventListener()

    connection = RunService.RenderStepped:Connect(function(_: number) -- name: onRenderStepped
        if not bool1 then
            return
        end
        stopJumpEventListener()

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
        connection = nil
    end
    stopJumpEventListener()
end

return module

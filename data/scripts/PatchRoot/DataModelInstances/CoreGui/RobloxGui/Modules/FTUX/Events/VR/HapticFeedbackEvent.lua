-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:20:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HapticService = game:GetService("HapticService")
local _EventType = require(script.Parent.Parent.EventType)

local module = { Name = "HapticFeedbackEvent" }

function module.StartEvent()
    local gamepad1 = Enum.UserInputType.Gamepad1
    local gamepad2 = Enum.UserInputType.Gamepad2

    HapticService:SetMotor(gamepad1, Enum.VibrationMotor.Large, 10)
    HapticService:SetMotor(gamepad2, Enum.VibrationMotor.Large, 10)
    task.wait(1)
    HapticService:SetMotor(gamepad1, Enum.VibrationMotor.Large, 0)
    HapticService:SetMotor(gamepad2, Enum.VibrationMotor.Large, 0)
end

return module

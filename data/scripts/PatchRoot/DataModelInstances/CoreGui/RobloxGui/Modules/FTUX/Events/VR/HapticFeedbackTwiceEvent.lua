-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:20:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HapticService = game:GetService("HapticService")
local _EventType = require(script.Parent.Parent.EventType)

local module = { Name = "HapticFeedbackTwiceEvent" }

function module.StartEvent()
    local gamepad1 = Enum.UserInputType.Gamepad1
    local gamepad2 = Enum.UserInputType.Gamepad2

    for _ = 1, 2 do
        HapticService:SetMotor(gamepad1, Enum.VibrationMotor.Large, 5)
        HapticService:SetMotor(gamepad2, Enum.VibrationMotor.Large, 5)
        task.wait(0.5)
        HapticService:SetMotor(gamepad1, Enum.VibrationMotor.Large, 0)
        HapticService:SetMotor(gamepad2, Enum.VibrationMotor.Large, 0)
        task.wait(0.125)
    end
end

return module

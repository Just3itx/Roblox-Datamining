-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T11:21:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local LoadSlices = require(scriptParent.LoadSlices)

local UserInputService = game:GetService("UserInputService")
local ExperienceStateRecordingService = game:GetService("ExperienceStateRecordingService")
local mouse = game:GetService("Players").LocalPlayer:GetMouse()

local module = {}

function computePercentX(absolutePosition, absoluteSize, arg1)
    local absolutePositionX = absolutePosition.X
    local var1 = absolutePositionX + absoluteSize.X
    return (arg1 - absolutePositionX) / (var1 - absolutePositionX)
end

function module.jumpTo(arg1)
    local percentage = computePercentX(arg1.ScrubberLoadProgress.AbsolutePosition, arg1.ScrubberLoadProgress.AbsoluteSize, mouse.X)

    if percentage < 0 or percentage > 1 then
        local var1 = computePercentX(arg1.ScrubberButton.AbsolutePosition, arg1.ScrubberButton.AbsoluteSize, mouse.X)

        LoadSlices.loadNoncontiguousSlice(arg1, var1)
        return
    end
    ExperienceStateRecordingService:SetPlaybackPercentage(percentage)
end

function module.setupControl(arg1)
    arg1.ScrubberButton.MouseMoved:Connect(function()
        if not UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
            return
        end
        module.jumpTo(arg1)
    end)

    arg1.ScrubberButton.MouseButton1Down:Connect(function()
        module.jumpTo(arg1)
    end)
end

return module

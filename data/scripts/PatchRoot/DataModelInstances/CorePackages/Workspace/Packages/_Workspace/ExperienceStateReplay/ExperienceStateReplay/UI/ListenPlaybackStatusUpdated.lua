-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T11:30:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExperienceStateRecordingService = game:GetService("ExperienceStateRecordingService")

local scriptParent = script.Parent
local SecondsToTimeStr = require(scriptParent.SecondsToTimeStr)

local module = {}

function module.setupListener(arg1)
    ExperienceStateRecordingService.PlaybackStatusUpdated:Connect(function(percentage: number, _: number)
        arg1.ScrubberPlayProgress.Size = UDim2.new(percentage, 0, 1, 0)
        if arg1.loadedLengthSeconds and arg1.replayToLoadedStartSeconds then
            arg1.CurrentTimeLabel.Text = SecondsToTimeStr.convertSecondsToTimeStr(percentage * arg1.loadedLengthSeconds + arg1.replayToLoadedStartSeconds)
        end
    end)
end

return module

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:20:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _EventType = require(script.Parent.Parent.EventType)

local module = { Name = "SoundFeedbackEvent" }

function module.StartEvent()
    local sound = Instance.new("Sound")
    sound.Parent = game.Workspace

    sound.SoundId = "rbxassetid://10066947742"
    sound.Volume = 1

    sound:Play()
end

return module

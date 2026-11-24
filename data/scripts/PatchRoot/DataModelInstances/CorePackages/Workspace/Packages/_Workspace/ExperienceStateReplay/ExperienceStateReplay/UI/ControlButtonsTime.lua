-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T11:21:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExperienceStateRecordingService = game:GetService("ExperienceStateRecordingService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local scriptParent = script.Parent
local ButtonAssets = require(scriptParent.ButtonAssets)
local CreateButtonsTime = require(scriptParent.CreateButtonsTime)

local module = {}

function module.setupControl(arg1)
    arg1.connections = {}

    function arg1.SetPlaying()
        arg1.state.Playing = true
        arg1.PlayButton.Image = ButtonAssets.PauseButton

        ExperienceStateRecordingService:SetPlaybackMode(Enum.ExperienceStateRecordingPlaybackMode.Playing)
    end

    function arg1.SetPaused()
        arg1.state.Playing = false
        arg1.PlayButton.Image = ButtonAssets.PlayButton

        ExperienceStateRecordingService:SetPlaybackMode(Enum.ExperienceStateRecordingPlaybackMode.Stopped)
    end

    function arg1.ControlButtons(arg2)
        arg1.StopButton.ImageColor3 = CreateButtonsTime.regularColor
        arg1.StopButton:SetAttribute("useHoverColor", true)
        arg1.ReverseButton.ImageColor3 = CreateButtonsTime.regularColor
        arg1.ReverseButton:SetAttribute("useHoverColor", true)
        arg1.state.Reversing = false
        if arg2 ~= arg1.PlayButton then
            arg1.PlayButton.ImageColor3 = CreateButtonsTime.regularColor
        end

        if arg2 == arg1.PlayButton then
            if arg1.state.Playing then
                arg1.SetPaused()
                return
            end
            arg1.SetPlaying()
            return
        end
        if arg2 == arg1.StopButton then
            arg1.StopButton:SetAttribute("useHoverColor", false)
            arg1.StopButton.ImageColor3 = CreateButtonsTime.clickColor
            arg1.LoadingOverlay.Visible = true
            arg1.LoadingLabel.Text = "Returning To Replay Browser"
            arg1.state.Loading = true
            ReplicatedStorage:WaitForChild("TeleportRequest"):FireServer()
        elseif arg2 == arg1.ReverseButton then
            arg1.state.Reversing = true
            arg1.SetPaused()
            arg1.ReverseButton:SetAttribute("useHoverColor", false)
            arg1.ReverseButton.ImageColor3 = CreateButtonsTime.clickColor

            ExperienceStateRecordingService:SetPlaybackMode(Enum.ExperienceStateRecordingPlaybackMode.Rewinding)
        end
    end

    arg1.connections.PlayListener = arg1.PlayButton.MouseButton1Click:Connect(function()
        arg1.ControlButtons(arg1.PlayButton)
    end)

    arg1.connections.StopListener = arg1.StopButton.MouseButton1Click:Connect(function()
        arg1.ControlButtons(arg1.StopButton)
    end)

    arg1.connections.ReverseListener = arg1.ReverseButton.MouseButton1Click:Connect(function()
        arg1.ControlButtons(arg1.ReverseButton)
    end)

    UserInputService.InputBegan:Connect(function(input: InputObject, _: boolean)
        if input.KeyCode == Enum.KeyCode.Space then
            arg1.ControlButtons(arg1.PlayButton)
        elseif input.KeyCode == Enum.KeyCode.R then
            arg1.ControlButtons(arg1.ReverseButton)
        elseif input.KeyCode == Enum.KeyCode.X then
            arg1.ControlButtons(arg1.StopButton)
        end
    end)
end

return module

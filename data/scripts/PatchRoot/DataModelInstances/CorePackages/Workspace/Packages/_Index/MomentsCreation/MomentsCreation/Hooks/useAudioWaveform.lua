-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:21:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreation = script:FindFirstAncestor("MomentsCreation")
local MomentsCreationParent = MomentsCreation.Parent

local Players = game:GetService("Players")

local React = require(MomentsCreationParent.React)

local useEffect = React.useEffect

local Constants = require(MomentsCreation.Constants)

local LocalPlayer = Players.LocalPlayer

local SegmentSelectorWidth = Constants.AudioWaveform.SegmentSelectorWidth
local WaveformWidth = Constants.AudioWaveform.WaveformWidth
local WaveformPadding = Constants.AudioWaveform.WaveformPadding

local function assetIdAsContent(num1: number): string -- Luacid: Inlined by compiler; 1 call site recovered
    return `rbxassetid://{num1}`
end

local function normalizeWaveform(tbl1): {number}
    local num1 = 0

    local tbl2 = {}
    for _, value in tbl1 do
        local num2 = math.max(0, value)
        table.insert(tbl2, num2)
        num1 = math.max(num1, num2)
    end

    if num1 == 0 then
        return tbl2
    end

    local result = {}
    for _, value in tbl2 do
        table.insert(result, value / num1)
    end
    return result
end

local function useAudioWaveform(num1: number, num2: number)
    local var1, var2 = React.useState({})

    useEffect(function()
        var2({})

        if num2 <= 0 then
            return nil
        end

        local var3 = SegmentSelectorWidth / (WaveformWidth + WaveformPadding) / num2

        local audioWaveform = Instance.new("Folder")
        audioWaveform.Name = "AudioWaveform"

        local audioPlayer = Instance.new("AudioPlayer")
        audioPlayer.Asset = assetIdAsContent(num1)
        audioPlayer.Parent = audioWaveform
        audioWaveform.Parent = LocalPlayer:WaitForChild("PlayerGui")

        local bool1 = false

        local function generate() -- Luacid: Inlined by compiler; 1 call site recovered
            if bool1 or not audioPlayer.IsReady then
                return
            end
            task.spawn(function()
                local success, result = pcall(function()
                    return audioPlayer:GetWaveformAsync(NumberRange.new(0, audioPlayer.TimeLength), var3 * audioPlayer.TimeLength)
                end)

                if not bool1 and success then
                    var2((normalizeWaveform(result)))
                end
            end)
        end

        local connection = audioPlayer:GetPropertyChangedSignal("IsReady"):Connect(generate)

        if audioPlayer.IsReady then
            generate()
        end

        return function()
            bool1 = true
            connection:Disconnect()
            audioWaveform:Destroy()
        end
    end, { num1, num2 })

    return var1
end

return useAudioWaveform

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T10:21:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreationFlow = script:FindFirstAncestor("MomentsCreationFlow")
local MomentsCreationFlowParent = MomentsCreationFlow.Parent

local Players = game:GetService("Players")

local React = require(MomentsCreationFlowParent.React)

local useEffect = React.useEffect

local Constants = require(MomentsCreationFlow.Constants)

local LocalPlayer = Players.LocalPlayer

local SegmentSelectorWidth = Constants.AudioWaveform.SegmentSelectorWidth
local WaveformWidth = Constants.AudioWaveform.WaveformWidth
local WaveformPadding = Constants.AudioWaveform.WaveformPadding

local function assetIdAsContent(num1: number): string -- Luacid: Inlined by compiler; 1 call site recovered
    return `rbxassetid://{num1}`
end

local function normalizeWaveform(waveformAsync): {number}
    local num1 = 0

    local tbl1 = {}
    for _, value in waveformAsync do
        local num2 = math.max(0, value)
        table.insert(tbl1, num2)
        num1 = math.max(num1, num2)
    end

    if num1 == 0 then
        return tbl1
    end

    local result = {}
    for _, value in tbl1 do
        table.insert(result, value / num1)
    end

    return result
end

local function useAudioWaveform(num1: number, num2: number)
    local var1, var2 = React.useState({})
    local var3 = React.useRef(nil)

    local var4 = React.useMemo(function()
        return SegmentSelectorWidth / (WaveformWidth + WaveformPadding) / num2
    end, { num2 })

    local asset = React.useMemo(function(): string
        return (assetIdAsContent(num1))
    end, { num1 })

    useEffect(function()
        local audioWaveform = Instance.new("Folder")
        audioWaveform.Name = "AudioWaveform"

        local audioPlayer = Instance.new("AudioPlayer")
        audioPlayer.Asset = asset
        audioPlayer.Parent = audioWaveform

        var3.current = audioPlayer
        audioWaveform.Parent = LocalPlayer:WaitForChild("PlayerGui")

        return function()
            audioWaveform:Destroy()
        end
    end, { num1, num2 })

    local var6 = React.useCallback(function()
        local current = var3.current

        if current and current.IsReady then
            task.spawn(function()
                local waveformAsync = current:GetWaveformAsync(NumberRange.new(0, current.TimeLength), var4 * current.TimeLength)

                var2((normalizeWaveform(waveformAsync)))
            end)
        end
    end, {})

    useEffect(function()
        local current = var3.current
        local tbl1 = {}
        if current then
            local isReadyChanged = current:GetPropertyChangedSignal("IsReady")
            table.insert(tbl1, isReadyChanged:Connect(var6))
        end

        return function()
            for _, value in tbl1 do
                value:Disconnect()
            end
        end
    end, {})

    return var1
end

return useAudioWaveform

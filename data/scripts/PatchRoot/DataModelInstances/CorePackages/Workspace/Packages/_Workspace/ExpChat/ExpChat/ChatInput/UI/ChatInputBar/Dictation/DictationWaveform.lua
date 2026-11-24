-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T07:51:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChatParent = script:FindFirstAncestor("ExpChat").Parent

local React = require(ExpChatParent.React)
local useTokens = require(ExpChatParent.Foundation).Hooks.useTokens

local Waveform = require(script.Parent.Parent.Waveform)
local _useTranscribedSamples = require(script.Parent.useTranscribedSamples)

local binding = React.createBinding({})

local function isItemTranscribed(transcribed, itemIdx: number) -- Luacid: Inlined by compiler; 1 call site recovered
    for _, value in transcribed do
        if value.startIdx <= itemIdx and itemIdx <= value.endIdx then
            return true
        end
    end
    return false
end

local function fadeInTransparency(age: number, fadeInTicks: number): number -- Luacid: Inlined by compiler; 2 call sites recovered
    return if fadeInTicks <= age then 0 else 1 - age / fadeInTicks
end

local function compositeWithFade(num1: number, fade: number): number -- Luacid: Inlined by compiler; 1 call site recovered
    return num1 + fade * (1 - num1)
end

return React.memo(function(tbl1) -- name: DictationWaveform
    local var1 = useTokens()
    local color3 = var1.Color.Content.Emphasis.Color3
    local color3_2 = var1.Color.Content.Muted.Color3
    local color3_3 = var1.Color.System.Success.Color3

    local transcribed = tbl1.transcribedSamplesBinding or binding
    local transparencyValue = tbl1.transparencyValue
    local fadeInTicks = tbl1.fadeInTicks or 10

    local bindBarStyle = React.useCallback(function(sample)
        local tbl2 = { sample = sample, transcribed = transcribed }

        if transparencyValue ~= nil then
            tbl2.fade = transparencyValue
        end
        return React.joinBindings(tbl2):map(function(arg1)
            local sample2 = arg1.sample
            local transcribed = arg1.transcribed
            local var3, var4

            if sample2.age == nil then
                var3 = color3_2
                var4 = 0.85
            elseif isItemTranscribed(transcribed, sample2.itemIdx) then
                var3 = color3_3
                var4 = fadeInTransparency(sample2.age, fadeInTicks)
            else
                var3 = color3
                var4 = fadeInTransparency(sample2.age, fadeInTicks)
            end
            if arg1.fade ~= nil then
                var4 = compositeWithFade(var4, arg1.fade)
            end
            return { color = var3, transparency = var4 }
        end)
    end, {
        color3,
        color3_2,
        color3_3,
        transcribed,
        transparencyValue,
        fadeInTicks
    })

    return React.createElement(Waveform, {
        isActive = tbl1.isActive,
        audioDeviceInput = tbl1.audioDeviceInput,
        onSample = tbl1.onSample,
        bindBarStyle = bindBarStyle
    })
end)

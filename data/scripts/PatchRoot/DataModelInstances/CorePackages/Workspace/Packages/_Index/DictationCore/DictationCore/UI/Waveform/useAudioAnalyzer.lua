-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T10:01:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DictationCoreParent = script:FindFirstAncestor("DictationCore").Parent

local React = require(DictationCoreParent.React)

local function useAudioAnalyzer(sourceInstance)
    local var1 = React.useRef(nil)

    React.useEffect(function()
        if not sourceInstance then
            return
        end

        local waveformAnalyzer = Instance.new("AudioAnalyzer")
        waveformAnalyzer.SpectrumEnabled = false
        waveformAnalyzer.Name = "WaveformAnalyzer"
        waveformAnalyzer.Parent = sourceInstance.Parent
        var1.current = waveformAnalyzer

        local wire = Instance.new("Wire")
        wire.SourceInstance = sourceInstance
        wire.TargetInstance = waveformAnalyzer
        wire.Parent = sourceInstance.Parent

        return function()
            wire:Destroy()
            waveformAnalyzer:Destroy()
            var1.current = nil
        end
    end, { sourceInstance })

    return var1
end

return useAudioAnalyzer

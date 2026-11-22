-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:20:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
game:DefineFastInt("MomentsTTSVolumePercent", 100)
game:DefineFastInt("MomentsAudioDuckThresholdDb", -19)
game:DefineFastInt("MomentsAudioDuckAttackMs", 50)
game:DefineFastInt("MomentsAudioDuckReleaseMs", 200)
game:DefineFastInt("MomentsAudioDuckRatio", 4)
game:DefineFastInt("MomentsAudioDuckMakeupGainDb", 0)

return {
    getTtsVolume = function(): number
        return game:GetFastInt("MomentsTTSVolumePercent") / 100
    end,
    getCompressorParams = function()
        return {
            threshold = game:GetFastInt("MomentsAudioDuckThresholdDb"),
            ratio = game:GetFastInt("MomentsAudioDuckRatio"),
            attack = game:GetFastInt("MomentsAudioDuckAttackMs") / 1000,
            release = game:GetFastInt("MomentsAudioDuckReleaseMs") / 1000,
            makeupGain = game:GetFastInt("MomentsAudioDuckMakeupGainDb")
        }
    end
}

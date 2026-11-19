-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T03:21:10Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
game:DefineFastFlag("EnablePartyVoiceVolumeOnlyWhenInEligibleParty", false)

return function(): boolean
    return game:GetEngineFeature("PartyVoiceVolume") and game:GetFastFlag("EnablePartyVoiceVolumeOnlyWhenInEligibleParty")
end

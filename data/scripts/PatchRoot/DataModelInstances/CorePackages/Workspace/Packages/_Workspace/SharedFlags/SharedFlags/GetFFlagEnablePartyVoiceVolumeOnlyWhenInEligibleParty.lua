-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T16:11:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
game:DefineFastFlag("EnablePartyVoiceVolumeOnlyWhenInEligibleParty", false)

return function(): boolean
    return game:GetEngineFeature("PartyVoiceVolume") and game:GetFastFlag("EnablePartyVoiceVolumeOnlyWhenInEligibleParty")
end

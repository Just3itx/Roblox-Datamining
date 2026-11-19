-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T04:30:39Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local VoiceChatService = game:GetService("VoiceChatService")

local engineFeature = game:GetEngineFeature("VoiceVolumeControlsEnableCreatorVoiceVolumeOptOut")

local engineFeature2 = game:GetEngineFeature("VoiceVolumeControlsCreatorVoiceVolumeOptOutDefaultBehaviorIsEnabled")

local function resolveEnableVoiceVolumeControls(rolloutState: Enum.RolloutState): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return rolloutState == Enum.RolloutState.Enabled or not (rolloutState == Enum.RolloutState.Disabled) and engineFeature2
end

return {
    isCreatorVoiceVolumeControlsEnabled = function()
        if engineFeature then
            return resolveEnableVoiceVolumeControls(VoiceChatService.EnableVoiceVolumeControls)
        end
        return true
    end,
    isVoiceChatVolumeSliderVisible = function(bool1: boolean, bool2: boolean)
        if bool1 then
            if bool2 then
                if engineFeature then
                    return resolveEnableVoiceVolumeControls(VoiceChatService.EnableVoiceVolumeControls)
                end

                bool2 = true
            end
        else
            bool2 = bool1
        end

        return bool2
    end
}

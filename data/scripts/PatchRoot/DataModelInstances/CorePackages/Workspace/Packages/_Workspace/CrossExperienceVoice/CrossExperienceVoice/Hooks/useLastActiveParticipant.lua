-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:11:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local engineFeature = game:GetEngineFeature("AudioFocusManagement")
local CrossExperienceVoice = script:FindFirstAncestor("CrossExperienceVoice")
local dependencies = require(CrossExperienceVoice.dependencies)

local useSelector = dependencies.RoactUtils.Hooks.RoactRodux.useSelector

local useIsVoiceFocused = require(CrossExperienceVoice.Hooks.useIsVoiceFocused)
local GetFFlagEnableCrossExpVoice = dependencies.SharedFlags.GetFFlagEnableCrossExpVoice

return function()
    if not GetFFlagEnableCrossExpVoice() then
        return nil
    end
    local var1 = useIsVoiceFocused()

    local var2 = useSelector(function(arg1)
        if not (arg1 and arg1.Squad and arg1.Squad.CrossExperienceVoice) then
            return nil
        end

        local activeUserIds = arg1.Squad.CrossExperienceVoice.Participants.activeUserIds

        for i = #activeUserIds, 1, -1 do
            local activeUserId = activeUserIds[i]

            local participant = arg1.Squad.CrossExperienceVoice.Participants.participants[activeUserId]
            if participant and not participant.isMuted then
                return participant
            end
        end
        return nil
    end)

    return if engineFeature and not var1 then nil else var2
end

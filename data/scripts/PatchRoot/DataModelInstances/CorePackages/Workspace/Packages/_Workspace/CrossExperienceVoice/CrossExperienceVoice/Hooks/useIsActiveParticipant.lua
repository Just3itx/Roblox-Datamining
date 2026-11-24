-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:10:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local engineFeature = game:GetEngineFeature("AudioFocusManagement")
local CrossExperienceVoice = script:FindFirstAncestor("CrossExperienceVoice")
local dependencies = require(CrossExperienceVoice.dependencies)

local useSelector = dependencies.RoactUtils.Hooks.RoactRodux.useSelector
local GetFFlagEnableCrossExpVoice = dependencies.SharedFlags.GetFFlagEnableCrossExpVoice

local useIsVoiceFocused = require(CrossExperienceVoice.Hooks.useIsVoiceFocused)

return function(num1: number)
    if not GetFFlagEnableCrossExpVoice() then
        return false
    end
    local var1 = useIsVoiceFocused()
    local var2 = useSelector(function(arg1)
        if not (arg1 and arg1.Squad and arg1.Squad.CrossExperienceVoice) then
            return false
        end

        if table.find(arg1.Squad.CrossExperienceVoice.Participants.activeUserIds, num1) == nil then
            return false
        end

        local participant = arg1.Squad.CrossExperienceVoice.Participants.participants[num1]
        return participant and not participant.isMuted
    end)
    return not (engineFeature and not var1) and var2
end

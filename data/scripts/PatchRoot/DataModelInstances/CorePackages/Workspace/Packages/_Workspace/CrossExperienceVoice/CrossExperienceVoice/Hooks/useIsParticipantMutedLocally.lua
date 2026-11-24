-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:11:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CrossExperienceVoice = script:FindFirstAncestor("CrossExperienceVoice")
local useSelector = require(CrossExperienceVoice.dependencies).RoactUtils.Hooks.RoactRodux.useSelector

return function(num1: number)
    return useSelector(function(arg1)
        if not (arg1 and arg1.Squad and arg1.Squad.CrossExperienceVoice) then
            return nil
        end

        local participant = arg1.Squad.CrossExperienceVoice.Participants.participants[num1]
        return if participant then participant.isMutedLocally else nil
    end)
end

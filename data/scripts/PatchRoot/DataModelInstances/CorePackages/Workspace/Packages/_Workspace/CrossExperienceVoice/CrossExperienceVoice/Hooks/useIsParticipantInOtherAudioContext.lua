-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:10:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CrossExperienceVoice = script:FindFirstAncestor("CrossExperienceVoice")
local dependencies = require(CrossExperienceVoice.dependencies)

local useSelector = dependencies.RoactUtils.Hooks.RoactRodux.useSelector
local GetFFlagEnableCrossExpVoice = dependencies.SharedFlags.GetFFlagEnableCrossExpVoice

return function(num1: number, num2: number)
    if not GetFFlagEnableCrossExpVoice() then
        return nil
    end
    return useSelector(function(arg1)
        if arg1 and arg1.Squad and arg1.Squad.CrossExperienceVoice then
            return arg1.Squad.CrossExperienceVoice.Participants.publicVoiceFocusedUserIds[num1] == true ~= (arg1.Squad.CrossExperienceVoice.Participants.publicVoiceFocusedUserIds[num2] == true)
        end

        return nil
    end)
end

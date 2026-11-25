-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T18:00:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SquadsCoreParent = script:FindFirstAncestor("SquadsCore").Parent

local useSelector = require(SquadsCoreParent.RoactUtils).Hooks.RoactRodux.useSelector

local useIsUserPartyVoiceEligible = require(script.Parent.useIsUserPartyVoiceEligible)

function useIsLocalPlayerPartyVoiceEligible()
    local var1 = useSelector(function(arg1): number
        if not (arg1 and arg1.LocalUserId) then
            return 0
        end

        return tonumber(arg1.LocalUserId) or 0
    end)

    return useIsUserPartyVoiceEligible(var1), var1 == 0
end

return useIsLocalPlayerPartyVoiceEligible

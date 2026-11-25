-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T17:51:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SquadsCoreParent = script:FindFirstAncestor("SquadsCore").Parent

local React = require(SquadsCoreParent.React)
local useSelector = require(SquadsCoreParent.RoactUtils).Hooks.RoactRodux.useSelector

function useCurrentSquadMembers()
    local var1 = React.useCallback(function(arg1)
        if arg1.Squad and arg1.Squad.Squad and arg1.Squad.Squad.currentSquad and arg1.Squad.Squad.currentSquad.members then
            return arg1.Squad.Squad.currentSquad.members
        end

        return nil
    end, {})
    return (useSelector(var1))
end

return useCurrentSquadMembers

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T15:10:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RoduxSquadsParent = script:FindFirstAncestor("RoduxSquads").Parent
local useSelector = require(RoduxSquadsParent.RoactUtils).Hooks.RoactRodux.useSelector

local function useCurrentSquadSelector()
    return (useSelector(function(arg1)
        return arg1.Squad and arg1.Squad.Squad and arg1.Squad.Squad.currentSquad
    end))
end
return useCurrentSquadSelector

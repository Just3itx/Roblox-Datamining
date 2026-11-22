-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T22:51:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SquadsParent = script:FindFirstAncestor("Squads").Parent
local useAppPolicy = require(SquadsParent.UniversalAppPolicy).useAppPolicy

return function()
    return useAppPolicy(function(arg1)
        return arg1.getCanAccessParty()
    end)
end

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T17:50:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SquadsCoreParent = script:FindFirstAncestor("SquadsCore").Parent

local DefaultSquadContract = require(script.Parent.DefaultSquadContract)
local _SquadContractType = require(script.Parent.SquadContractType)

local Cryo = require(SquadsCoreParent.Cryo)

return function(tbl1)
    return Cryo.Dictionary.union(DefaultSquadContract, tbl1)
end

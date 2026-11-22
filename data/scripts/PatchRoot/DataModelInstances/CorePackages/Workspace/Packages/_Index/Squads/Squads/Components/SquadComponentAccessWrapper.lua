-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T22:40:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Squads = script:FindFirstAncestor("Squads")
local SquadsParent = Squads.Parent
local React = require(Squads.dependencies).React

local SquadExternalContractContext = require(SquadsParent.SquadsCore.SquadExternalContractProvider).SquadExternalContractContext
local useAppPolicy = require(SquadsParent.UniversalAppPolicy).useAppPolicy

return function(tbl1)
    local var1 = React.useContext(SquadExternalContractContext).useParentChannelHasSquadAccess(tbl1.parentChannelId)

    return if useAppPolicy(function(arg1)
        return arg1.getCanAccessParty()
    end) and var1 then tbl1.children else nil
end

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T18:01:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SquadsCore = script:FindFirstAncestor("SquadsCore")
local SquadsCoreParent = SquadsCore.Parent

local React = require(SquadsCoreParent.React)
local NetworkingSquads = require(SquadsCore.Http.NetworkingSquads)
local NetworkStatus = require(SquadsCore.Http.RoduxNetworking).Enum.NetworkStatus
local SquadState = require(SquadsCore.Enums.SquadState)
local useCurrentSquadId = require(SquadsCore.Hooks.useCurrentSquadId)
local useSelector = require(SquadsCoreParent.RoactUtils).Hooks.RoactRodux.useSelector

return function()
    local var1 = useCurrentSquadId() or ""

    local var2 = React.useCallback(function(arg1)
        return NetworkingSquads.JoinSquad.getStatus(arg1, {})
    end, {})
    local var3 = useSelector(var2)

    local var4 = React.useCallback(function(arg1)
        return NetworkingSquads.CreateOrJoinSquad.getStatus(arg1, {})
    end, {})
    local var5 = useSelector(var4)

    local idle = SquadState.Idle

    if var1 ~= "" then
        return SquadState.Active
    end

    if var3 == NetworkStatus.Fetching or var5 == NetworkStatus.Fetching then
        idle = SquadState.Initializing
    end

    return idle
end

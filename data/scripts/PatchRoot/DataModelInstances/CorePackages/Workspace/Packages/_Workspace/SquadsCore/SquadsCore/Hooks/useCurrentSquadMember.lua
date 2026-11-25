-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T17:51:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SquadsCoreParent = script:FindFirstAncestor("SquadsCore").Parent

local React = require(SquadsCoreParent.React)
local Cryo = require(SquadsCoreParent.Cryo)
local useCurrentSquadSelector = require(SquadsCoreParent.RoduxSquads).Hooks.useCurrentSquadSelector

function useCurrentSquadMember(userId: number)
    local var1 = useCurrentSquadSelector()
    local var2 = React.useMemo(function()
        return if var1 then var1.members else {}
    end, { var1 })

    return (React.useMemo(function()
        local where = Cryo.List.findWhere(var2, function(arg1): boolean
            return arg1.userId == userId
        end)
        return if where then var2[where] else nil
    end, { var2, userId }))
end

return useCurrentSquadMember

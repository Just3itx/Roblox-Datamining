-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T18:11:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SquadsCoreParent = script:FindFirstAncestor("SquadsCore").Parent

local Cryo = require(SquadsCoreParent.Cryo)
local _RoduxSquads = require(SquadsCoreParent.RoduxSquads)

local function getSquadMemberFromUserId(arg1, userId: string)
    if arg1 and arg1.members then
        local where = Cryo.List.findWhere(arg1.members, function(arg2): boolean
            return arg2.userId == userId
        end)

        if where then
            return arg1.members[where]
        end
    end

    return nil
end

return getSquadMemberFromUserId

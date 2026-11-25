-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T17:41:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SquadsCore = script:FindFirstAncestor("SquadsCore")
local SquadsCoreParent = SquadsCore.Parent

local Cryo = require(SquadsCoreParent.Cryo)

local encodeUserIds = require(SquadsCore.Common.encodeUserIds)

local function encodeSquadMembers(arg1)
    local var1 = Cryo.List.map(arg1 or {}, function(arg2)
        return arg2.userId
    end)

    return encodeUserIds(var1)
end

return encodeSquadMembers

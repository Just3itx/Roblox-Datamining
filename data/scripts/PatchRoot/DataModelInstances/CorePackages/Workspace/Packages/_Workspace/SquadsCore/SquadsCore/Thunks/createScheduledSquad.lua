-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T18:10:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SquadsCore = script:FindFirstAncestor("SquadsCore")

local createScheduledSquad = require(SquadsCore.NetworkRequests.createScheduledSquad)
local SquadPromptType = require(SquadsCore.Enums.SquadPromptType)
local _Types = require(SquadsCore.Types)

return function(tbl1, callback: (...any) -> (...any), func1: ((...any) -> (...any))?)
    return function(arg1)
        createScheduledSquad(tbl1, func1, function(num1: number)
            callback(arg1, { promptType = if num1 == 409 then SquadPromptType.ScheduledSquadConflict else SquadPromptType.Error })
        end)
    end
end

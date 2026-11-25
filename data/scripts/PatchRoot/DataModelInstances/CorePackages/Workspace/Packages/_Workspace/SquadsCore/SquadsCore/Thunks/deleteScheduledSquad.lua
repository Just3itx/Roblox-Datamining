-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T18:10:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SquadsCore = script:FindFirstAncestor("SquadsCore")

local SquadPromptType = require(SquadsCore.Enums.SquadPromptType)
local deleteScheduledSquad = require(SquadsCore.NetworkRequests.deleteScheduledSquad)

return function(scheduledGroupUpId: number, func1: (...any) -> (...any), func2: ((...any) -> (...any))?)
    return function(arg1)
        local function func3()
            func1(arg1, { promptType = SquadPromptType.Error })
        end

        return func1(arg1, {
            onConfirm = function()
                deleteScheduledSquad({ scheduledGroupUpId = scheduledGroupUpId }, func2, func3)
            end,
            promptType = SquadPromptType.ConfirmDeleteScheduledSquad
        })
    end
end

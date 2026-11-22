-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T13:51:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Reactions = script:FindFirstAncestor("Reactions")

local Constants = require(Reactions.Constants)
local _ReactionType = require(Reactions.Enums.ReactionType)

local function getTopReactions(tbl1, num1: number)
    local tbl2 = {}
    local num2 = 0

    for displayOrder, reactionType in Constants.PossibleReactions do
        local count = tbl1[reactionType] or 0
        if not (count > 0) then
            continue
        end

        table.insert(tbl2, { reactionType = reactionType, count = count, displayOrder = displayOrder })

        num2 += count
    end

    table.sort(tbl2, function(tbl3, tbl4): boolean
        if tbl3.count == tbl4.count then
            return tbl3.displayOrder < tbl4.displayOrder
        end

        return tbl3.count > tbl4.count
    end)

    local reactions = ({})
    local num3 = #tbl2

    for i = 1, math.min(num1, num3) do
        reactions[i] = tbl2[i].reactionType
    end

    return { reactions = reactions, totalCount = num2 }
end

return getTopReactions

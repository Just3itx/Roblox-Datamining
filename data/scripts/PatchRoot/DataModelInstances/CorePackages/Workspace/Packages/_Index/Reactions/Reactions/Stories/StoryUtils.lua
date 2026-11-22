-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T13:51:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Reactions = script:FindFirstAncestor("Reactions")

local Constants = require(Reactions.Constants)
local _ReactionType = require(Reactions.Enums.ReactionType)
local _applyReactionTrigger = require(Reactions.Utils.applyReactionTrigger)

return {
    describeSelection = function(tbl1): string
        local tbl2 = {}
        for _, possibleReaction in Constants.PossibleReactions do
            if tbl1[possibleReaction] then
                table.insert(tbl2, possibleReaction)
            end
        end
        if #tbl2 > 0 then
            return table.concat(tbl2, ", ")
        end

        return "none"
    end,
    describeChange = function(arg1): string
        local tbl1 = {}
        if arg1.added then
            table.insert(tbl1, `added {arg1.added}`)
        end
        if arg1.removed then
            table.insert(tbl1, `removed {arg1.removed}`)
        end
        if #tbl1 > 0 then
            return table.concat(tbl1, ", ")
        end

        return "none"
    end
}

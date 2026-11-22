-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T14:00:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Reactions = script:FindFirstAncestor("Reactions")

local Constants = require(Reactions.Constants)
local tbl1 = {
    crying = require(Reactions.Enums.ReactionType).Cry
}
for _, PossibleReaction in Constants.PossibleReactions do
    tbl1[PossibleReaction] = PossibleReaction
end

local function reactionTypeFromEmojiName(str1: string)
    return tbl1[string.gsub(string.lower(str1), "%-", "")]
end

return reactionTypeFromEmojiName

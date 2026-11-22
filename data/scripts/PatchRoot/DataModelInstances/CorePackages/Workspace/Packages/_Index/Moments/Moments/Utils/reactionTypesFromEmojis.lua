-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T05:40:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local MomentsCommon = require(MomentsParent.MomentsCommon)
local _MomentsTypes = require(MomentsParent.MomentsTypes)

local ReactionType = MomentsCommon.Enums.ReactionType
local bool1 = game:DefineFastFlag("MomentsUpdateReactionTrayOrder", false)

local tbl1 = {
    [ReactionType.ThumbsUp] = true,
    [ReactionType.Heart] = true,
    [ReactionType.LaughJoy] = true,
    [ReactionType.Wow] = true,
    [ReactionType.Cry] = true,
    [ReactionType.Fire] = true,
    [ReactionType.Skull] = true
}

local PICKER_REACTION_ORDER = {
    ReactionType.ThumbsUp,
    ReactionType.Heart,
    ReactionType.LaughJoy,
    ReactionType.Wow,
    ReactionType.Cry,
    ReactionType.Fire,
    ReactionType.Skull
}

local function normalizeEmojiName(name: string) -- Luacid: Inlined by compiler; 1 call site recovered
    local var1 = string.gsub(string.lower(name), "%-", "")
    return if var1 == "crying" then "cry" else var1
end

return {
    reactionTypesFromEmojis = function(tbl3): {[any]: any} | {any}
        local tbl4 = {}

        local tbl5 = ({})
        for _, value in tbl3 do
            local var1 = normalizeEmojiName(value.name)
            if tbl1[var1] then
                table.insert(tbl4, var1)
                tbl5[var1] = true
            end
        end

        if bool1 then
            tbl4 = {}
            for _, value in PICKER_REACTION_ORDER do
                if tbl5[value] then
                    table.insert(tbl4, value)
                end
            end
        end

        return if #tbl4 == 0 then PICKER_REACTION_ORDER else tbl4
    end,
    PICKER_REACTION_ORDER = PICKER_REACTION_ORDER
}

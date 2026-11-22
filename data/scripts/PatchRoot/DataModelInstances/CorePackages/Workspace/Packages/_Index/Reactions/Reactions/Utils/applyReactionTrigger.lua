-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T13:51:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Reactions = script:FindFirstAncestor("Reactions")

local ReactionTrigger = require(Reactions.Enums.ReactionTrigger)
local ThumbsUp = require(Reactions.Enums.ReactionType).ThumbsUp

local function getSoleReaction(selectedReactions) -- Luacid: Inlined by compiler; 1 call site recovered
    for k, selectedReaction in selectedReactions do
        if selectedReaction then
            return k
        end
    end
    return nil
end

local function applyReactionTrigger(state, arg1, arg2, tbl1)
    local bool1 = not (tbl1 == nil) and tbl1.allowMultiple == true
    local removed = if bool1 then nil else getSoleReaction(state.selectedReactions)
    local var1 = if arg1 == ReactionTrigger.PickerSelect then arg2 or ThumbsUp elseif arg1 == ReactionTrigger.ButtonTap then arg2 or removed or ThumbsUp else removed or ThumbsUp
    local bool2 = state.selectedReactions[var1] == true
    if bool2 and arg1 == ReactionTrigger.DoubleTap then
        return { state = state, added = nil, removed = nil, celebratedReaction = var1 }
    end

    local selectedReactions = not bool1 and {} or table.clone(state.selectedReactions)

    local reactionCounts = table.clone(state.reactionCounts)
    local function decrement(arg3) -- Luacid: Inlined by compiler; 2 call sites recovered
        local var4 = (reactionCounts[arg3] or 0) - 1
        if var4 > 0 then
            reactionCounts[arg3] = var4
            return
        end
        reactionCounts[arg3] = nil
    end

    if bool2 then
        selectedReactions[var1] = nil
        decrement(var1)
        return {
            state = { selectedReactions = selectedReactions, reactionCounts = reactionCounts },
            added = nil,
            removed = var1,
            celebratedReaction = nil
        }
    end

    if removed ~= nil then
        decrement(removed)
    end

    selectedReactions[var1] = true
    reactionCounts[var1] = (reactionCounts[var1] or 0) + 1

    return {
        state = { selectedReactions = selectedReactions, reactionCounts = reactionCounts },
        added = var1,
        removed = removed,
        celebratedReaction = var1
    }
end

return applyReactionTrigger

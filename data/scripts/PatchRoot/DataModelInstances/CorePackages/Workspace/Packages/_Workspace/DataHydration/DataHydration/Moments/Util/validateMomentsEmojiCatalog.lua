-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T05:00:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local MomentsTypes = require(DataHydrationParent.MomentsTypes)
local decodeEmojiSets = require(script.Parent.decodeEmojiSets)
local resolveEmoteId = require(script.Parent.resolveEmoteId)

local ReactionType = MomentsTypes.Enums.ReactionType

local tbl1 = {
    ReactionType.ThumbsUp,
    ReactionType.Heart,
    ReactionType.LaughJoy,
    ReactionType.Wow,
    ReactionType.Cry,
    ReactionType.Fire,
    ReactionType.Skull
}

local function isUuidLikeEmoteId(str1: string): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return string.find(str1, "-", 1, true) ~= nil
end

local function isValidMomentsEmojiCatalog(tbl2)
    if #tbl2 == 0 then
        return false
    end

    for i = 1, #tbl1 do
        local var1 = tbl1[i]
        local var2 = resolveEmoteId.resolveEmoteIdForReaction(tbl2, var1)

        if var2 == var1 or not isUuidLikeEmoteId(var2) then
            return false
        end
    end

    return true
end

return {
    isValidMomentsEmojiCatalog = isValidMomentsEmojiCatalog,
    isValidGetEmojiSetsResponseShape = function(arg1)
        if type(arg1) ~= "table" or type(arg1.emoji_sets) ~= "table" or #arg1.emoji_sets == 0 then
            return false
        end

        local var1 = decodeEmojiSets.decodeGetEmojiSetsResponse(arg1)
        return (isValidMomentsEmojiCatalog(decodeEmojiSets.flattenEmojis(var1)))
    end,
    isValidCachedGetEmojiSetsResponse = function(arg1)
        if arg1 == nil then
            return false
        end
        return (isValidMomentsEmojiCatalog(decodeEmojiSets.flattenEmojis(arg1)))
    end,
    isUuidLikeEmoteId = isUuidLikeEmoteId
}

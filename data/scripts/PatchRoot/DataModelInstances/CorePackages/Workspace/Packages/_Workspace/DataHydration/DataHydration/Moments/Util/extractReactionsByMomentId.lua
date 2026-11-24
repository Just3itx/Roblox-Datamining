-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:51:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local MomentsTypes = require(DataHydrationParent.MomentsTypes)
local _MomentsStoreTypes = require(DataHydration.Moments.MomentsStoreTypes)
local hardcodedMomentsEmojis = require(DataHydration.Moments.Util.hardcodedMomentsEmojis)
local resolveEmoteId = require(DataHydration.Moments.Util.resolveEmoteId)
local resolveMomentsEmojiCatalog = require(DataHydration.Moments.Util.resolveMomentsEmojiCatalog)
local FFlagMomentsEmojiSetsApi = require(DataHydration.Moments.FFlagMomentsEmojiSetsApi)

local tbl1 = ({})

for _, value in MomentsTypes.Enums.ReactionType do
    tbl1[value] = true
end

local function isValidReactionType(str1: string): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return tbl1[str1] == true or tbl1[resolveEmoteId.normalizeName(str1)] == true
end

local function asReactionType(str1: string) -- Luacid: Inlined by compiler; 4 call sites recovered
    local var1 = resolveEmoteId.normalizeName(str1)
    return if tbl1[var1] then var1 else nil
end

local function convertReactionCountsArray(reactionCounts, tbl2): {[any]: any}?
    local tbl3 = {}
    local bool1 = false
    local var1 = nil

    for _, reactionCount in reactionCounts do
        if type(reactionCount) ~= "table" then
            continue
        end

        local count = reactionCount.count
        if type(count) ~= "number" or count <= 0 then
            continue
        end

        local var2 = if type(reactionCount.name) == "string" then asReactionType(reactionCount.name) else nil

        if var2 == nil then
            local var3 = reactionCount.emote_id or reactionCount.emoteId
            if type(var3) == "string" then
                local var4 = resolveEmoteId.reactionTypeForEmoteId(tbl2, var3)
                if var4 ~= nil then
                    var2 = asReactionType(var4)
                end
            end
        end

        if var2 == nil then
            continue
        end

        tbl3[var2] = count
        bool1 = true

        local hasUserReacted = reactionCount.has_user_reacted
        if hasUserReacted == nil then
            hasUserReacted = reactionCount.hasUserReacted
        end
        if hasUserReacted == true then
            var1 = var2
        end
    end

    if var1 ~= nil then
        tbl3.userReaction = var1
        bool1 = true
    end

    return if bool1 then tbl3 else nil
end

local function convertLegacyApiReactions(reactions): {[any]: any}?
    local tbl2 = {}
    local bool1 = false

    local counts = reactions.counts
    if type(counts) == "table" then
        for k, count in counts do
            if type(k) ~= "string" or type(count) ~= "number" or not (count > 0) then
                continue
            end

            if FFlagMomentsEmojiSetsApi then
                if isValidReactionType(k) then
                    local var1 = asReactionType(k)

                    if var1 ~= nil then
                        tbl2[var1] = count
                        bool1 = true
                    end
                end
            elseif tbl1[k] then
                tbl2[k] = count
                bool1 = true
            end
        end
    end

    local userReaction = reactions.userReaction or reactions.viewerReaction
    if type(userReaction) == "string" then
        if FFlagMomentsEmojiSetsApi then
            local var1 = asReactionType(userReaction)

            if var1 ~= nil then
                tbl2.userReaction = var1
                bool1 = true
            end
        elseif tbl1[userReaction] then
            tbl2.userReaction = userReaction
            bool1 = true
        end
    end

    return if bool1 then tbl2 else nil
end

local function convertApiReactions(reactions, tbl2) -- Luacid: Inlined by compiler; 1 call site recovered
    if type(reactions) ~= "table" then
        return nil
    end

    if FFlagMomentsEmojiSetsApi then
        local var1 = reactions.reaction_counts or reactions.reactionCounts
        if type(var1) == "table" then
            local var2 = convertReactionCountsArray(var1, tbl2)
            if var2 ~= nil then
                return var2
            end
        end
    end

    return (convertLegacyApiReactions(reactions))
end

local function extractReactionsByMomentId(tbl2)
    local result = ({})
    local var1 = if FFlagMomentsEmojiSetsApi then resolveMomentsEmojiCatalog.resolveMomentsEmojiCatalog(nil).emojis else hardcodedMomentsEmojis

    if tbl2 == nil then
        return result
    end

    for _, value in tbl2 do
        local var2 = value.entityId or value.id
        if var2 == nil then
            continue
        end

        local var3 = convertApiReactions(value.reactions, var1)
        if var3 ~= nil then
            result[var2] = var3
        end
    end

    return result
end

return extractReactionsByMomentId

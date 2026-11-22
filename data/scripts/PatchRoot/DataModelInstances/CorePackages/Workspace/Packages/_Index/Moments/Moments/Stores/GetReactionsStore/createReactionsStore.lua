-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T05:31:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local Signals = require(MomentsParent.Signals)
local Cryo = require(MomentsParent.Cryo)
local debounce = require(MomentsParent.Dash).debounce

local _MomentsStoreTypes = require(MomentsParent.DataHydration.MomentsStoreTypes)
local MomentsTypes = require(MomentsParent.MomentsTypes)
local ReactionAction = require(Moments.Enums.ReactionAction)
local MomentsGetMomentsReactionsStore = require(MomentsParent.DataHydration.MomentsGetMomentsReactionsStore)
local MomentsResolveEmoteId = require(MomentsParent.DataHydration.MomentsResolveEmoteId)
local FFlagMomentsReactToFeedItemV2 = require(Moments.Flags.FFlagMomentsReactToFeedItemV2)

local createSignal = Signals.createSignal
local createComputed = Signals.createComputed
local ReactionType = MomentsTypes.Enums.ReactionType

local tbl1 = {}

local function createReactionsStore(tbl2)
    local tbl3 = tbl2 or {}
    local var1 = if tbl3.momentsReactionsStore ~= nil then tbl3.momentsReactionsStore else MomentsGetMomentsReactionsStore(false)
    local var2 = tbl3.debounce or debounce

    local getReactionsByMomentId, var4 = createSignal({})
    local tbl4 = ({})
    local tbl5 = ({})
    local tbl6 = ({})
    local tbl7 = ({})

    local tbl8 = ({})
    local tbl9 = ({})

    local num1 = 0

    local function getReactions(str1: string, arg1) -- Luacid: Inlined by compiler; 4 call sites recovered
        return getReactionsByMomentId(arg1 or false)[str1] or tbl1
    end

    local function updateReaction(arg1)
        local action = arg1.action
        local reaction = arg1.reaction
        local momentId = arg1.momentId

        local var5 = getReactionsByMomentId(false)
        local var6 = var5[momentId] or {}
        local userReaction = var6.userReaction

        if action == ReactionAction.Unreact and userReaction then
            var6 = Cryo.Dictionary.join(var6, { [userReaction] = math.max((var6[userReaction] or 0) - 1, 0), userReaction = Cryo.None })
        end

        if action == ReactionAction.Switch and userReaction and reaction ~= nil then
            var6 = Cryo.Dictionary.join(var6, {
                [userReaction] = math.max((var6[userReaction] or 0) - 1, 0),
                [reaction] = math.max((var6[reaction] or 0) + 1, 1),
                userReaction = reaction
            })
        end

        if action == ReactionAction.React and not userReaction and reaction ~= nil then
            var6 = Cryo.Dictionary.join(var6, { [reaction] = math.max((var6[reaction] or 0) + 1, 1), userReaction = reaction })
        end

        var4((Cryo.Dictionary.union(var5, { [momentId] = var6 })))
    end

    local function postReactToFeedItemV2(tbl10: {entityId: string, entityType: string, feedItemId: string, feedSessionId: string?, reactionType: any})
        local var5 = var1.getEmojis == nil and {} or var1.getEmojis(false)
        local reactToFeedItemV2 = var1.reactToFeedItemV2
        assert(reactToFeedItemV2 ~= nil, "expected reactToFeedItemV2 when FFlagMomentsReactToFeedItemV2 is on")
        return reactToFeedItemV2({
            feedItemId = tbl10.feedItemId,
            reactionType = tbl10.reactionType,
            emoteId = MomentsResolveEmoteId.resolveEmoteIdForReaction(var5, tbl10.reactionType),
            feedSessionId = tbl10.feedSessionId
        })
    end

    local function postReactionRequest(tbl10: {entityId: string, entityType: string, feedItemId: string, feedSessionId: string?, reactionType: any}) -- Luacid: Inlined by compiler; 1 call site recovered
        if FFlagMomentsReactToFeedItemV2 then
            return postReactToFeedItemV2(tbl10)
        end
        return var1.reactToFeedItem(tbl10)
    end

    local function flushSync(entityId: string, feedItemId: string, entityType: string, feedSessionId: string?)
        local var5 = tbl8[entityId]
        local reaction = if var5 == nil then nil else var5.reaction
        local userReaction = (getReactionsByMomentId(false)[entityId] or tbl1).userReaction
        if userReaction == reaction then
            return
        end

        if userReaction ~= nil then
            reaction = userReaction
        end

        tbl8[entityId] = { reaction = userReaction }

        local var6 = postReactionRequest({
            feedItemId = feedItemId,
            entityType = entityType,
            entityId = entityId,
            reactionType = reaction,
            feedSessionId = feedSessionId
        })
        if type(var6) == "table" and var6.catch ~= nil then
            var6:catch(function() end)
        end
    end

    local function seedSyncBaseline(entityId: string) -- Luacid: Inlined by compiler; 2 call sites recovered
        if tbl8[entityId] == nil then
            tbl8[entityId] = {
                reaction = (getReactionsByMomentId(false)[entityId] or tbl1).userReaction
            }
        end
    end

    local function scheduleSync(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
        local entityId = arg1.entityId
        local var5 = tbl9[entityId]
        if var5 == nil then
            local num2 = num1
            var5 = var2(function(feedItemId: string, entityType: string, feedSessionId: string?)
                if num2 ~= num1 then
                    return
                end
                flushSync(entityId, feedItemId, entityType, feedSessionId)
            end, 0.5)
            tbl9[entityId] = var5
        end
        var5(arg1.feedItemId, arg1.entityType, arg1.feedSessionId)
    end

    return {
        getReactionsByMomentId = getReactionsByMomentId,
        getReactions = getReactions,
        getReactionsForMoment = function(str1: string)
            if tbl4[str1] == nil then
                tbl4[str1] = createComputed(function(arg1)
                    return (getReactions(str1, arg1))
                end)
            end
            return tbl4[str1]
        end,
        getUserReactionForMoment = function(str1: string)
            if tbl5[str1] == nil then
                tbl5[str1] = createComputed(function(arg1)
                    return getReactions(str1, arg1).userReaction
                end)
            end

            return tbl5[str1]
        end,
        getTotalReactionCountForMoment = function(str1: string)
            if tbl6[str1] == nil then
                tbl6[str1] = createComputed(function(arg1)
                    local num2 = 0
                    local reactions = getReactions(str1, arg1)
                    for _, value in ReactionType do
                        num2 += reactions[value] or 0
                    end
                    return num2
                end)
            end
            return tbl6[str1]
        end,
        getIndividualReactionCountsForMoment = function(str1: string)
            if tbl7[str1] == nil then
                tbl7[str1] = createComputed(function(arg1)
                    local reactions = getReactions(str1, arg1)
                    local result = {}
                    for _, reaction in ReactionType do
                        local count = reactions[reaction]
                        if count ~= nil and count > 0 then
                            table.insert(result, { reaction = reaction, count = count })
                        end
                    end

                    table.sort(result, function(arg2, arg3): boolean
                        if arg2.count == arg3.count then
                            return arg2.reaction < arg3.reaction
                        end

                        return arg2.count > arg3.count
                    end)

                    return result
                end)
            end
            return tbl7[str1]
        end,
        setBatchReactionCounts = function(arg1)
            local var5 = getReactionsByMomentId(false)
            local var6 = table.clone(var5)
            for value, value2 in arg1 do
                local var7 = var5[value]

                if var7 ~= nil and var7.userReaction ~= nil and value2.userReaction == nil then
                    local var8 = table.clone(value2)
                    local userReaction = var7.userReaction
                    var8.userReaction = userReaction
                    var8[userReaction] = math.max(value2[userReaction] or 0, var7[userReaction] or 0)
                    var6[value] = var8
                else
                    var6[value] = value2
                end
            end
            var4(var6)
        end,
        setReactions = function(str1: string, arg1)
            var4((Cryo.Dictionary.union(getReactionsByMomentId(false), { [str1] = arg1 or {} })))
        end,
        clear = function()
            num1 += 1
            table.clear(tbl8)
            table.clear(tbl9)
            var4({})
            table.clear(tbl4)
            table.clear(tbl5)
            table.clear(tbl6)
            table.clear(tbl7)
        end,
        updateReaction = updateReaction,
        reactToFeedItem = function(arg1)
            local entityId = arg1.entityId
            local userReaction = (getReactionsByMomentId(false)[entityId] or tbl1).userReaction
            seedSyncBaseline(arg1.entityId)
            updateReaction({
                action = if userReaction ~= nil and userReaction ~= arg1.reactionType then ReactionAction.Switch else ReactionAction.React,
                momentId = arg1.entityId,
                reaction = arg1.reactionType
            })
            scheduleSync(arg1)
            return nil
        end,
        removeFeedItemReaction = function(arg1)
            seedSyncBaseline(arg1.entityId)
            updateReaction({ action = ReactionAction.Unreact, momentId = arg1.entityId, reaction = arg1.reactionType })
            scheduleSync(arg1)
            return nil
        end
    }
end
return createReactionsStore

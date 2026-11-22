-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T05:30:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local Signals = require(MomentsParent.Signals)
local _MomentsTypes = require(MomentsParent.MomentsTypes)

local function selectedEmoteId(arg1) -- Luacid: Inlined by compiler; 6 call sites recovered
    return if arg1 == nil or arg1.userReaction == nil then nil else arg1.userReaction.emoteId
end

local function selectionsAgree(arg1, desiredEmoteId: string?): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return selectedEmoteId(arg1) == desiredEmoteId
end

local function restrictionFromState(tbl1, feedItemId: string, str1: string) -- Luacid: Inlined by compiler; 1 call site recovered
    local var1 = tbl1.commentRestrictionsByCommentId[str1]
    local var2 = tbl1.globalRestriction or tbl1.feedRestrictionsByFeedItemId[feedItemId]

    if not var2 then
        if var1 ~= nil and var1.feedItemId == feedItemId then
            return var1.errorCode
        end

        var2 = nil
    end

    return var2
end

local function transitionDeltas(str1: string?, desiredEmoteId: string?) -- Luacid: Inlined by compiler; 4 call sites recovered
    local result = ({})
    if str1 ~= nil and str1 ~= desiredEmoteId then
        result[str1] = -1
    end
    if desiredEmoteId ~= nil and desiredEmoteId ~= str1 then
        result[desiredEmoteId] = (result[desiredEmoteId] or 0) + 1
    end
    return result
end

local function combineDeltas(tbl1, tbl2)
    local var1 = table.clone(tbl1)
    for value, value2 in tbl2 do
        local var2 = (var1[value] or 0) + value2
        if var2 == 0 then
            var1[value] = nil
        else
            var1[value] = var2
        end
    end
    return var1
end

local function projectReactions(arg1, tbl1)
    local counts = table.create(#arg1.counts)
    local tbl2 = {}
    for _, count in arg1.counts do
        local countDelta = tbl1.countDeltas[count.emoteId] or 0
        table.insert(counts, { emoteId = count.emoteId, count = math.max(0, count.count + countDelta) })

        tbl2[count.emoteId] = true
    end
    for emoteId, count in tbl1.countDeltas do
        if not tbl2[emoteId] and count > 0 then
            table.insert(counts, { emoteId = emoteId, count = count })
        end
    end

    return {
        counts = counts,
        userReaction = tbl1.desiredEmoteId ~= nil and {
            emoteId = tbl1.desiredEmoteId
        } or nil
    }
end

local function createCommentReactionsStore()
    local var1, var2 = Signals.createSignal({
        intentsByCommentId = {},
        globalRestriction = nil,
        feedRestrictionsByFeedItemId = {},
        commentRestrictionsByCommentId = {},
        cooldownUntilMs = 0
    })

    local getGeneration, var4 = Signals.createSignal(0)
    local bool1 = false

    local function updateState(func1: (...any) -> (...any)) -- Luacid: unused: defined but never referenced
        if not bool1 then
            var2(func1(var1(false)))
        end
    end

    local function updateIntentStatus(str1: string, generation: number, status: string): boolean -- Luacid: Inlined by compiler; 3 call sites recovered
        local var5 = var1(false).intentsByCommentId[str1]

        if bool1 or var5 == nil or var5.generation ~= generation then
            return false
        end
        local function func1(arg1)
            local intentsByCommentId = table.clone(arg1.intentsByCommentId)
            local var7 = table.clone(var5)
            var7.status = status
            if status == "LocallyConfirmed" then
                var7.rollbackState = nil
            end
            intentsByCommentId[str1] = var7
            return {
                intentsByCommentId = intentsByCommentId,
                globalRestriction = arg1.globalRestriction,
                feedRestrictionsByFeedItemId = arg1.feedRestrictionsByFeedItemId,
                commentRestrictionsByCommentId = arg1.commentRestrictionsByCommentId,
                cooldownUntilMs = arg1.cooldownUntilMs
            }
        end

        if not bool1 then
            var2((func1(var1(false))))
        end

        return true
    end

    local function clear()
        if bool1 then
            return
        end
        var4(getGeneration(false) + 1)
        var2({
            intentsByCommentId = {},
            globalRestriction = nil,
            feedRestrictionsByFeedItemId = {},
            commentRestrictionsByCommentId = {},
            cooldownUntilMs = 0
        })
    end

    return {
        getGeneration = getGeneration,
        getCooldownUntilMs = function(arg1)
            return var1(arg1 or false).cooldownUntilMs
        end,
        getIntent = function(str1: string, arg1)
            return var1(arg1 or false).intentsByCommentId[str1]
        end,
        getRestriction = function(feedItemId: string, str1: string, arg1)
            local var5 = var1(arg1 or false)
            local var6 = var5.commentRestrictionsByCommentId[str1]
            local var7 = var5.globalRestriction or var5.feedRestrictionsByFeedItemId[feedItemId]

            if not var7 then
                if var6 ~= nil and var6.feedItemId == feedItemId then
                    return var6.errorCode
                end

                var7 = nil
            end

            return var7
        end,
        getProjection = function(feedItemId: string, str1: string, reactions, arg2)
            local var5 = var1(arg2 or false)
            local var6 = var5.intentsByCommentId[str1]
            local tbl1 = { reactions = 0, status = 0, restriction = 0, generation = 0 }
            if reactions ~= nil and var6 ~= nil then
                reactions = projectReactions(reactions, var6)
            end

            tbl1.reactions = reactions

            tbl1.status = if var6 == nil then nil else var6.status
            tbl1.restriction = restrictionFromState(var5, feedItemId, str1)
            tbl1.generation = if var6 == nil then nil else var6.generation
            return tbl1
        end,
        beginIntent = function(feedItemId: string, str1: string, arg1, desiredEmoteId: string?)
            if bool1 then
                return getGeneration(false)
            end
            local generation = getGeneration(false) + 1
            var4(generation)
            local function func1(arg2)
                local intentsByCommentId = table.clone(arg2.intentsByCommentId)
                local var7 = intentsByCommentId[str1]
                local var8 = selectedEmoteId(arg1)

                local var9 = nil
                local countDeltas

                if var7 == nil then
                    countDeltas = {}
                else
                    var8 = var7.desiredEmoteId
                    countDeltas = var7.countDeltas
                    if var7.rollbackState ~= nil then
                        var9 = {
                            desiredEmoteId = var7.rollbackState.desiredEmoteId,
                            countDeltas = table.clone(var7.rollbackState.countDeltas)
                        }
                    elseif var7.status == "LocallyConfirmed" then
                        var9 = {
                            desiredEmoteId = var7.desiredEmoteId,
                            countDeltas = table.clone(var7.countDeltas)
                        }
                    end
                end
                intentsByCommentId[str1] = {
                    feedItemId = feedItemId,
                    desiredEmoteId = desiredEmoteId,
                    countDeltas = combineDeltas(countDeltas, (transitionDeltas(var8, desiredEmoteId))),
                    generation = generation,
                    rollbackState = var9,
                    status = "Pending"
                }

                return {
                    intentsByCommentId = intentsByCommentId,
                    globalRestriction = arg2.globalRestriction,
                    feedRestrictionsByFeedItemId = arg2.feedRestrictionsByFeedItemId,
                    commentRestrictionsByCommentId = arg2.commentRestrictionsByCommentId,
                    cooldownUntilMs = arg2.cooldownUntilMs
                }
            end

            if not bool1 then
                var2((func1(var1(false))))
            end

            return generation
        end,
        markPending = function(str1: string, generation: number): boolean
            return updateIntentStatus(str1, generation, "Pending")
        end,
        markUncertain = function(str1: string, generation: number): boolean
            return updateIntentStatus(str1, generation, "Uncertain")
        end,
        markLocallyConfirmed = function(str1: string, generation: number): boolean
            return updateIntentStatus(str1, generation, "LocallyConfirmed")
        end,
        confirmAndRebase = function(str1: string, generation: number, arg1): boolean
            local var5 = var1(false).intentsByCommentId[str1]

            if bool1 or var5 == nil or var5.generation ~= generation then
                return false
            end
            local function func1(arg2)
                local intentsByCommentId = table.clone(arg2.intentsByCommentId)
                local var7 = table.clone(var5)
                var7.countDeltas = transitionDeltas(selectedEmoteId(arg1), var5.desiredEmoteId)
                var7.rollbackState = nil
                var7.status = "LocallyConfirmed"
                intentsByCommentId[str1] = var7
                return {
                    intentsByCommentId = intentsByCommentId,
                    globalRestriction = arg2.globalRestriction,
                    feedRestrictionsByFeedItemId = arg2.feedRestrictionsByFeedItemId,
                    commentRestrictionsByCommentId = arg2.commentRestrictionsByCommentId,
                    cooldownUntilMs = arg2.cooldownUntilMs
                }
            end

            if not bool1 then
                var2((func1(var1(false))))
            end

            return true
        end,
        rollback = function(str1: string, generation: number, errorCode: string?): boolean -- name: removeIntent
            local var5 = var1(false).intentsByCommentId[str1]

            if bool1 or var5 == nil or var5.generation ~= generation then
                return false
            end
            local function func1(arg1)
                local intentsByCommentId = table.clone(arg1.intentsByCommentId)
                if var5.rollbackState ~= nil then
                    intentsByCommentId[str1] = {
                        feedItemId = var5.feedItemId,
                        desiredEmoteId = var5.rollbackState.desiredEmoteId,
                        countDeltas = table.clone(var5.rollbackState.countDeltas),
                        generation = var5.generation,
                        rollbackState = nil,
                        status = "LocallyConfirmed"
                    }
                else
                    intentsByCommentId[str1] = nil
                end
                local commentRestrictionsByCommentId = table.clone(arg1.commentRestrictionsByCommentId)
                if errorCode ~= nil then
                    commentRestrictionsByCommentId[str1] = {
                        feedItemId = var5.feedItemId,
                        errorCode = errorCode,
                        generation = var5.generation
                    }
                else
                    commentRestrictionsByCommentId[str1] = nil
                end
                return {
                    intentsByCommentId = intentsByCommentId,
                    globalRestriction = arg1.globalRestriction,
                    feedRestrictionsByFeedItemId = arg1.feedRestrictionsByFeedItemId,
                    commentRestrictionsByCommentId = commentRestrictionsByCommentId,
                    cooldownUntilMs = arg1.cooldownUntilMs
                }
            end

            if not bool1 then
                var2((func1(var1(false))))
            end

            return true
        end,
        expireIntent = function(str1: string, generation: number): boolean
            local var5 = var1(false).intentsByCommentId[str1]

            if bool1 or var5 == nil or var5.generation ~= generation then
                return false
            end
            local function func1(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
                local intentsByCommentId = table.clone(arg1.intentsByCommentId)
                intentsByCommentId[str1] = nil
                return {
                    intentsByCommentId = intentsByCommentId,
                    globalRestriction = arg1.globalRestriction,
                    feedRestrictionsByFeedItemId = arg1.feedRestrictionsByFeedItemId,
                    commentRestrictionsByCommentId = arg1.commentRestrictionsByCommentId,
                    cooldownUntilMs = arg1.cooldownUntilMs
                }
            end

            if not bool1 then
                var2((func1((var1(false)))))
            end

            return true
        end,
        reconcile = function(feedItemId: string, str1: string, arg1, generation: number): boolean
            if arg1 == nil then
                return false
            end
            local bool2 = false
            local function func1(arg2)
                local commentRestrictionsByCommentId = table.clone(arg2.commentRestrictionsByCommentId)
                local var6 = commentRestrictionsByCommentId[str1]
                if var6 ~= nil and var6.feedItemId == feedItemId and generation >= var6.generation then
                    commentRestrictionsByCommentId[str1] = nil
                end
                local var7 = arg2.intentsByCommentId[str1]
                local intentsByCommentId = table.clone(arg2.intentsByCommentId)
                if var7 ~= nil then
                    if selectionsAgree(arg1, var7.desiredEmoteId) then
                        intentsByCommentId[str1] = nil
                        bool2 = true
                    elseif generation >= var7.generation then
                        local var9 = table.clone(var7)
                        var9.countDeltas = transitionDeltas(selectedEmoteId(arg1), var7.desiredEmoteId)
                        if var7.rollbackState ~= nil then
                            var9.rollbackState = {
                                desiredEmoteId = var7.rollbackState.desiredEmoteId,
                                countDeltas = transitionDeltas(selectedEmoteId(arg1), var7.rollbackState.desiredEmoteId)
                            }
                        end

                        intentsByCommentId[str1] = var9
                    end
                end
                return {
                    intentsByCommentId = intentsByCommentId,
                    globalRestriction = arg2.globalRestriction,
                    feedRestrictionsByFeedItemId = arg2.feedRestrictionsByFeedItemId,
                    commentRestrictionsByCommentId = commentRestrictionsByCommentId,
                    cooldownUntilMs = arg2.cooldownUntilMs
                }
            end

            if not bool1 then
                var2((func1(var1(false))))
            end

            return bool2
        end,
        setGlobalRestriction = function(globalRestriction: string?)
            local function func1(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
                return {
                    intentsByCommentId = arg1.intentsByCommentId,
                    globalRestriction = globalRestriction,
                    feedRestrictionsByFeedItemId = arg1.feedRestrictionsByFeedItemId,
                    commentRestrictionsByCommentId = arg1.commentRestrictionsByCommentId,
                    cooldownUntilMs = arg1.cooldownUntilMs
                }
            end

            if not bool1 then
                var2((func1((var1(false)))))
            end
        end,
        setFeedRestriction = function(str1: string, str2: string?)
            local function func1(arg1)
                local feedRestrictionsByFeedItemId = table.clone(arg1.feedRestrictionsByFeedItemId)
                if str2 ~= nil then
                    feedRestrictionsByFeedItemId[str1] = str2
                else
                    feedRestrictionsByFeedItemId[str1] = nil
                end
                return {
                    intentsByCommentId = arg1.intentsByCommentId,
                    globalRestriction = arg1.globalRestriction,
                    feedRestrictionsByFeedItemId = feedRestrictionsByFeedItemId,
                    commentRestrictionsByCommentId = arg1.commentRestrictionsByCommentId,
                    cooldownUntilMs = arg1.cooldownUntilMs
                }
            end

            if not bool1 then
                var2((func1(var1(false))))
            end
        end,
        setCommentRestriction = function(feedItemId: string, str1: string, errorCode: string?, generation: number)
            local function func1(arg1)
                local commentRestrictionsByCommentId = table.clone(arg1.commentRestrictionsByCommentId)
                if errorCode ~= nil then
                    commentRestrictionsByCommentId[str1] = {
                        feedItemId = feedItemId,
                        errorCode = errorCode,
                        generation = generation
                    }
                else
                    commentRestrictionsByCommentId[str1] = nil
                end
                return {
                    intentsByCommentId = arg1.intentsByCommentId,
                    globalRestriction = arg1.globalRestriction,
                    feedRestrictionsByFeedItemId = arg1.feedRestrictionsByFeedItemId,
                    commentRestrictionsByCommentId = commentRestrictionsByCommentId,
                    cooldownUntilMs = arg1.cooldownUntilMs
                }
            end

            if not bool1 then
                var2((func1(var1(false))))
            end
        end,
        setCooldownUntilMs = function(num1: number)
            local function func1(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
                return {
                    intentsByCommentId = arg1.intentsByCommentId,
                    globalRestriction = arg1.globalRestriction,
                    feedRestrictionsByFeedItemId = arg1.feedRestrictionsByFeedItemId,
                    commentRestrictionsByCommentId = arg1.commentRestrictionsByCommentId,
                    cooldownUntilMs = math.max(0, num1)
                }
            end

            if not bool1 then
                var2((func1((var1(false)))))
            end
        end,
        clearComment = function(str1: string)
            local function func1(arg1)
                local intentsByCommentId = table.clone(arg1.intentsByCommentId)
                intentsByCommentId[str1] = nil
                local commentRestrictionsByCommentId = table.clone(arg1.commentRestrictionsByCommentId)
                commentRestrictionsByCommentId[str1] = nil
                return {
                    intentsByCommentId = intentsByCommentId,
                    globalRestriction = arg1.globalRestriction,
                    feedRestrictionsByFeedItemId = arg1.feedRestrictionsByFeedItemId,
                    commentRestrictionsByCommentId = commentRestrictionsByCommentId,
                    cooldownUntilMs = arg1.cooldownUntilMs
                }
            end

            if not bool1 then
                var2((func1(var1(false))))
            end
        end,
        clearFeed = function(feedItemId: string)
            local function func1(arg1)
                local intentsByCommentId = table.clone(arg1.intentsByCommentId)
                for value, value2 in intentsByCommentId do
                    if value2.feedItemId == feedItemId then
                        intentsByCommentId[value] = nil
                    end
                end
                local feedRestrictionsByFeedItemId = table.clone(arg1.feedRestrictionsByFeedItemId)
                feedRestrictionsByFeedItemId[feedItemId] = nil
                local commentRestrictionsByCommentId = table.clone(arg1.commentRestrictionsByCommentId)
                for value, value2 in commentRestrictionsByCommentId do
                    if value2.feedItemId == feedItemId then
                        commentRestrictionsByCommentId[value] = nil
                    end
                end
                return {
                    intentsByCommentId = intentsByCommentId,
                    globalRestriction = arg1.globalRestriction,
                    feedRestrictionsByFeedItemId = feedRestrictionsByFeedItemId,
                    commentRestrictionsByCommentId = commentRestrictionsByCommentId,
                    cooldownUntilMs = arg1.cooldownUntilMs
                }
            end

            if not bool1 then
                var2((func1(var1(false))))
            end
        end,
        clear = clear,
        dispose = function()
            if bool1 then
                return
            end
            clear()
            bool1 = true
        end
    }
end
return createCommentReactionsStore

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:11:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedContentParent = script:FindFirstAncestor("SduiSharedContent").Parent

local DataHydration = require(SduiSharedContentParent.DataHydration)
local _ContentReactionsStoreTypes = require(script.Parent.ContentReactionsStoreTypes)

local function areReactionsEqual(arg1, arg2): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return arg1.emoteId == arg2.emoteId
        and arg1.reactionType == arg2.reactionType
        and arg1.reactionCount == arg2.reactionCount
        and arg1.hasUserAppliedReaction == arg2.hasUserAppliedReaction
end

local function areReactionListsEqual(serverReactions, serverReactions2)
    if #serverReactions ~= #serverReactions2 then
        return false
    end
    for k, serverReaction in serverReactions do
        if not areReactionsEqual(serverReaction, serverReactions2[k]) then
            return false
        end
    end
    return true
end

local function isSettledOnServer(serverReactions, reaction) -- Luacid: Inlined by compiler; 1 call site recovered
    for _, serverReaction in serverReactions do
        if serverReaction.emoteId == reaction.emoteId then
            return serverReaction.hasUserAppliedReaction == reaction.hasUserAppliedReaction
        end
    end
    return not reaction.hasUserAppliedReaction
end

local function reconcile(storedReactions, serverReactions)
    if storedReactions == nil then
        return {
            serverReactions = serverReactions,
            emotes = {}
        }
    end
    if areReactionListsEqual(storedReactions.serverReactions, serverReactions) then
        return storedReactions
    end

    local emotes = ({})
    for value, value2 in storedReactions.emotes do
        if not value2.isPending then
            continue
        end

        local tbl2 = {
            reaction = value2.reaction,
            restore = nil,
            isPending = true,
            addedAt = value2.addedAt
        }
        emotes[value] = tbl2
    end

    return { serverReactions = serverReactions, emotes = emotes }
end

local function resolve(arg1)
    local result = {}
    local tbl1 = {}
    for _, serverReaction in arg1.serverReactions do
        tbl1[serverReaction.emoteId] = true
        local var1 = arg1.emotes[serverReaction.emoteId]
        if var1 then
            serverReaction = var1.reaction
        end

        table.insert(result, serverReaction)
    end

    local tbl2 = {}
    for value, value2 in arg1.emotes do
        if not tbl1[value] and value2.reaction.hasUserAppliedReaction then
            table.insert(tbl2, value2)
        end
    end
    table.sort(tbl2, function(arg2, arg3): boolean
        return arg2.addedAt < arg3.addedAt
    end)
    for _, value in tbl2 do
        table.insert(result, value.reaction)
    end
    return result
end

local function getNextAddedAt(emotes): number -- Luacid: Inlined by compiler; 1 call site recovered
    local num1 = 1
    for _, value in emotes do
        num1 = math.max(num1, value.addedAt + 1)
    end
    return num1
end

local function applyReaction(arg1, restore, reaction)
    local emoteId = reaction.emoteId
    local var1 = arg1.emotes[emoteId]
    local emotes = table.clone(arg1.emotes)
    emotes[emoteId] = {
        reaction = reaction,
        restore = restore,
        isPending = true,
        addedAt = if var1 then var1.addedAt else getNextAddedAt(arg1.emotes)
    }
    return {
        serverReactions = arg1.serverReactions,
        emotes = emotes
    }
end

local function settleReaction(storedReactions, emoteId: string, bool1: boolean)
    local var1 = storedReactions.emotes[emoteId]
    if var1 == nil or not var1.isPending then
        return storedReactions
    end

    local var2 = if bool1 then var1.reaction else var1.restore

    if bool1 and var1.restore == nil and isSettledOnServer(storedReactions.serverReactions, var1.reaction) then
        var2 = nil
    end

    local emotes = table.clone(storedReactions.emotes)
    if var2 then
        emotes[emoteId] = {
            reaction = var2,
            restore = nil,
            isPending = false,
            addedAt = var1.addedAt
        }
    else
        emotes[emoteId] = nil
    end
    return {
        serverReactions = storedReactions.serverReactions,
        emotes = emotes
    }
end

local function createContentReactionsStore()
    local dataCache = DataHydration.createDataCache()

    local function getContentReactions(str1: string) -- Luacid: Inlined by compiler; 8 call sites recovered
        return (dataCache.getItem(str1))
    end

    local function getStoredReactions(str1: string) -- Luacid: Inlined by compiler; 7 call sites recovered
        return getContentReactions(str1).data(false)
    end

    local function settle(str1: string, emoteId: string, bool1: boolean) -- Luacid: Inlined by compiler; 2 call sites recovered
        local storedReactions = getStoredReactions(str1)

        if storedReactions then
            dataCache.replaceItem(str1, (settleReaction(storedReactions, emoteId, bool1)))
        end
    end

    return {
        getContentReactions = getContentReactions,
        getReactions = function(str1: string, serverReactions)
            local storedReactions = getStoredReactions(str1)

            if storedReactions == nil then
                return serverReactions
            end
            return (resolve((reconcile(storedReactions, serverReactions))))
        end,
        isReactionPending = function(str1: string, str2: string)
            local storedReactions = getStoredReactions(str1)
            local var1 = if storedReactions then storedReactions.emotes[str2] else nil
            return not (var1 == nil) and var1.isPending
        end,
        reconcileReactions = function(str1: string, serverReactions)
            local storedReactions = getStoredReactions(str1)

            if not storedReactions then
                return
            end

            local var1 = reconcile(storedReactions, serverReactions)
            if var1 ~= storedReactions then
                dataCache.replaceItem(str1, var1)
            end
        end,
        updateReaction = function(str1: string, serverReactions, restore, reaction, arg1)
            local emoteId = reaction.emoteId
            dataCache.replaceItem(str1, (applyReaction(reconcile(getStoredReactions(str1), serverReactions), restore, reaction)))

            arg1:andThen(function()
                settle(str1, emoteId, true)
            end, function()
                settle(str1, emoteId, false)
            end)
        end,
        clear = dataCache.clear,
        dispose = dataCache.dispose
    }
end

return createContentReactionsStore

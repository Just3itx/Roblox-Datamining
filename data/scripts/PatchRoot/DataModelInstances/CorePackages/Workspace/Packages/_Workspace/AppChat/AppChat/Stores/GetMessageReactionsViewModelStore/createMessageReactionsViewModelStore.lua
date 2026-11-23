-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:20:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local _AppChatNetworking = require(AppChatParent.AppChatNetworking)
local Dash = require(AppChatParent.Dash)
local LocalUserIdStore = require(AppChatParent.LocalUserIdStore).LocalUserIdStore
local _Reactions = require(AppChatParent.Reactions)
local Signals = require(AppChatParent.Signals)

local GetEmojiSetsStore = require(AppChat.Stores.GetEmojiSetsStore)
local applyPendingReaction = require(script.Parent.applyPendingReaction)
local _createMessageReactionsStore = require(script.Parent.Parent.GetMessageReactionsStore.createMessageReactionsStore)

local tbl1 = {}
local tbl2 = {}

local function areReactorsEqual(arg1, arg2)
    local var1 = if arg1.reactions_page then arg1.reactions_page.reactors else tbl2
    local var2 = if arg2.reactions_page then arg2.reactions_page.reactors else tbl2

    return #var1 == #var2 and Dash.all(var1, function(arg3, num1: number): boolean
        local var3 = var2[num1]
        return arg3.user_id == var3.user_id and arg3.reacted_at == var3.reacted_at
    end)
end

local function areReactionListsEqual(tbl3, tbl4)
    return #tbl3 == #tbl4 and Dash.all(tbl3, function(arg1, num1: number)
        local var1 = tbl4[num1]

        return arg1.emote_id == var1.emote_id
            and arg1.count == var1.count
            and arg1.has_user_reacted == var1.has_user_reacted
            and areReactorsEqual(arg1, var1)
    end)
end

local function createMessageReactionsViewModelStore(arg1)
    local tbl3 = ({})
    local tbl4 = ({})

    local function getDisplayReactions(str1: string) -- Luacid: Inlined by compiler; 1 call site recovered
        local var1 = tbl3[str1]
        if var1 ~= nil then
            return var1
        end

        local computed = Signals.createComputed(function(arg2)
            local messageReactions = arg1.getMessageReactions(str1, arg2)
            if messageReactions == nil then
                return tbl1
            end
            local var2 = tonumber(LocalUserIdStore.getCurrentUserId(arg2))
            return applyPendingReaction(messageReactions, var2)
        end, areReactionListsEqual)

        tbl3[str1] = computed
        return computed
    end

    return {
        getDisplayReactions = getDisplayReactions,
        getReactionCounts = function(str1: string)
            local var1 = tbl4[str1]
            if var1 ~= nil then
                return var1
            end

            local displayReactions = getDisplayReactions(str1)

            local computed = Signals.createComputed(function(arg2): {[any]: any}?
                local emojiSetsStore = GetEmojiSetsStore(arg2)
                local tbl5 = ({})
                local bool1 = false
                for _, value in displayReactions(arg2) do
                    local reactionType = emojiSetsStore.getReactionType(value.emote_id, arg2)
                    if reactionType ~= nil and value.count > 0 then
                        tbl5[reactionType] = (tbl5[reactionType] or 0) + value.count
                        bool1 = true
                    end
                end

                return if bool1 then tbl5 else nil
            end, Dash.shallowEqual)

            tbl4[str1] = computed
            return computed
        end,
        evictMessages = function(tbl5)
            for _, value in tbl5 do
                tbl3[value] = nil
                tbl4[value] = nil
            end
        end
    }
end

return createMessageReactionsViewModelStore

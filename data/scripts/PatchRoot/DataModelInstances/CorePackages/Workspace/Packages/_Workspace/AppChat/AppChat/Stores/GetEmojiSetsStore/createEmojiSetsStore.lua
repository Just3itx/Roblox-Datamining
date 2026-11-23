-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:11:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local DataHydration = require(AppChatParent.DataHydration)
local HttpClient = require(AppChatParent.HttpClient)
local Promise = require(AppChatParent.Promise)
local Reactions = require(AppChatParent.Reactions)
local _Signals = require(AppChatParent.Signals)

local var1 = require(AppChat.Logger):new(script.Name)
local Constants = require(script.Parent.Constants)
local _decodeEmojiSets = require(script.Parent.decodeEmojiSets)
local emojiSetsFallback = require(script.Parent.emojiSetsFallback)
local fetchEmojiSets = require(script.Parent.Requests.fetchEmojiSets)

local function indexEmojis(tbl1)
    local tbl2 = {
        reactionTypeByEmoteId = {},
        emoteIdByReactionType = {}
    }
    for _, value in tbl1 do
        local var2 = Reactions.Utils.reactionTypeFromEmojiName(value.name)
        if var2 ~= nil then
            tbl2.reactionTypeByEmoteId[value.id] = var2
            tbl2.emoteIdByReactionType[var2] = value.id
        end
    end
    return tbl2
end

local tbl1 = indexEmojis(emojiSetsFallback)

local function createEmojiSetsStore(tbl2)
    local tbl3 = tbl2 or {}
    local cache = DataHydration.createDataCache()
    local dataResolver = DataHydration.createDataResolver({
        cache = cache,
        supportsMultiGet = false,
        replaceItems = true,
        logError = function(arg1)
            local str1 = if type(arg1) == "table" then `{arg1.responseCode} {arg1.errorMessage}` else tostring(arg1)
            var1:warning(`Error resolving emoji sets: {str1}`)
        end,
        fetchFn = function(_: string)
            return HttpClient.asPromise(fetchEmojiSets(tbl3.network)):andThen(function(tbl4)
                local tbl5 = indexEmojis(tbl4)

                for _, value in Constants.PICKER_REACTION_ORDER do
                    if tbl5.emoteIdByReactionType[value] == nil then
                        return Promise.reject(`get-emoji-sets has no emote for {value} in the reaction picker list`)
                    end
                end

                return tbl5
            end)
        end
    })

    local function getEmojiSets(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
        return dataResolver.getCachedItem("emoji-sets").data(arg1) or tbl1
    end

    return {
        getAndFetchEmojiSets = function()
            dataResolver.getAndFetchItem("emoji-sets")
        end,
        getReactionType = function(str1: string, arg1)
            return getEmojiSets(arg1).reactionTypeByEmoteId[str1]
        end,
        getEmoteId = function(arg1, arg2)
            return getEmojiSets(arg2).emoteIdByReactionType[arg1]
        end,
        clear = dataResolver.clear,
        dispose = dataResolver.dispose
    }
end

return createEmojiSetsStore

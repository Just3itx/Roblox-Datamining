-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:20:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local _AppChatNetworking = require(AppChatParent.AppChatNetworking)
local DataHydration = require(AppChatParent.DataHydration)
local _Signals = require(AppChatParent.Signals)

local tbl1 = {}

local function createMessageReactionsStore()
    local dataCache = DataHydration.createDataCache()

    local function getMessageReactions(str1: string, arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
        return dataCache.getItem(str1).data(arg1)
    end

    return {
        getMessageReactions = getMessageReactions,
        ingestMessageReactions = function(tbl2)
            local tbl3 = ({})
            for _, value in tbl2 do
                local messageReactions = getMessageReactions(value.id, false)
                local id = value.id
                tbl3[id] = {
                    reactions = value.reactions or tbl1,
                    pending = if messageReactions then messageReactions.pending else nil
                }
            end
            dataCache.replaceItems(tbl3)
        end,
        evictMessageReactions = function(tbl2)
            for _, value in tbl2 do
                if getMessageReactions(value, false) ~= nil then
                    dataCache.replaceItem(value, nil)
                end
            end
        end,
        clear = dataCache.clear,
        dispose = dataCache.dispose
    }
end

return createMessageReactionsStore

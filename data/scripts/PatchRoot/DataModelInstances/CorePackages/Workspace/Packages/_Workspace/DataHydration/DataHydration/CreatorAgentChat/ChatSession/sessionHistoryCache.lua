-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:21:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _types = require(script.Parent.Parent.types)
local historyPageUtils = require(script.Parent.historyPageUtils)

local constants = require(script.Parent.constants)

return {
    createSessionHistoryCache = function(num1: number?)
        local var1 = num1 or constants.getMaxCachedSessionHistories()
        local tbl1 = ({})
        local tbl2 = {}

        local function removeFromOrder(str1: string)
            for value, value2 in tbl2 do
                if value2 == str1 then
                    table.remove(tbl2, value)
                    return
                end
            end
        end

        local function touch(str1: string) -- Luacid: Inlined by compiler; 2 call sites recovered
            removeFromOrder(str1)
            table.insert(tbl2, str1)
        end

        local function evictOldest() -- Luacid: Inlined by compiler; 1 call site recovered
            local var2 = tbl2[1]
            if var2 == nil then
                return
            end
            table.remove(tbl2, 1)
            tbl1[var2] = nil
        end

        return {
            save = function(str1: string, tbl3)
                tbl1[str1] = {
                    loadedBySequenceId = historyPageUtils.cloneHistoryBySequenceId(tbl3.loadedBySequenceId),
                    overlayBySequenceId = historyPageUtils.cloneHistoryBySequenceId(tbl3.overlayBySequenceId),
                    hasLoadedHistory = tbl3.hasLoadedHistory,
                    nextHistoryPageToken = tbl3.nextHistoryPageToken,
                    latestObservedHistorySequenceId = tbl3.latestObservedHistorySequenceId,
                    pendingUserMessage = tbl3.pendingUserMessage
                }
                touch(str1)

                while #tbl2 > var1 do
                    evictOldest()
                end
            end,
            restore = function(str1: string)
                local var2 = tbl1[str1]
                if var2 == nil then
                    return nil
                end

                touch(str1)
                return {
                    loadedBySequenceId = historyPageUtils.cloneHistoryBySequenceId(var2.loadedBySequenceId),
                    overlayBySequenceId = historyPageUtils.cloneHistoryBySequenceId(var2.overlayBySequenceId),
                    hasLoadedHistory = var2.hasLoadedHistory,
                    nextHistoryPageToken = var2.nextHistoryPageToken,
                    latestObservedHistorySequenceId = var2.latestObservedHistorySequenceId,
                    pendingUserMessage = var2.pendingUserMessage
                }
            end
        }
    end
}

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:21:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _types = require(script.Parent.Parent.types)

return {
    awaitRequestState = function(arg1, num1: number, func1: ((...any) -> (...any))?)
        while arg1(false).status == "pending" do
            if num1 <= os.clock() or func1 ~= nil and func1() then
                return arg1(false)
            end
            task.wait()
        end
        return arg1(false)
    end,
    awaitRequestStateCancelled = function(arg1, func1: (...any) -> (...any))
        while arg1(false).status == "pending" and not func1() do
            task.wait()
        end
        return arg1(false)
    end,
    getMaxHistorySequenceId = function(tbl1)
        local var1 = nil
        for _, value in tbl1 do
            local sequenceId = value.sequenceId
            if typeof(sequenceId) == "number" and (var1 == nil or var1 < sequenceId) then
                var1 = sequenceId
            end
        end

        return var1
    end,
    getSessionLoadHistory = function(arg1)
        local history = if arg1 == nil then nil else arg1.history
        return if typeof(history) == "table" then history else {}
    end,
    getNextHistoryPageToken = function(arg1): string?
        local nextHistoryPageToken = if arg1 == nil then nil else arg1.nextHistoryPageToken
        return if typeof(nextHistoryPageToken) == "string" and nextHistoryPageToken ~= "" then nextHistoryPageToken else nil
    end,
    collectSequenceIds = function(tbl1)
        local result = ({})
        for _, value in tbl1 do
            local sequenceId = value.sequenceId
            if typeof(sequenceId) == "number" then
                result[sequenceId] = true
            end
        end
        return result
    end,
    historyOverlapsSequenceIds = function(tbl1, tbl2)
        for _, value in tbl1 do
            local sequenceId = value.sequenceId
            if typeof(sequenceId) == "number" and tbl2[sequenceId] then
                return true
            end
        end
        return false
    end,
    appendUniqueHistoryBySequenceId = function(tbl1, tbl2, tbl3): number
        local num1 = 0
        for _, value in tbl2 do
            local sequenceId = value.sequenceId
            if typeof(sequenceId) == "number" and tbl3[sequenceId] then
                continue
            end

            if typeof(sequenceId) == "number" then
                tbl3[sequenceId] = true
            end
            table.insert(tbl1, value)
            num1 += 1
        end

        return num1
    end,
    cloneHistoryBySequenceId = function(tbl1)
        return table.clone(tbl1)
    end,
    resolveNonNegativeNumber = function(num1: number?, num2: number): number
        return if typeof(num1) == "number" and num1 >= 0 then num1 else num2
    end,
    resolvePositiveNumber = function(num1: number?, num2: number): number
        return if typeof(num1) == "number" and num1 > 0 then num1 else num2
    end
}

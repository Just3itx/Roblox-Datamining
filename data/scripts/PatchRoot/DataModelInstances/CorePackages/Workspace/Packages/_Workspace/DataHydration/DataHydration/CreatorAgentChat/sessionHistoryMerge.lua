-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:31:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _types = require(script.Parent.types)

local function getSequenceId(arg1): number? -- Luacid: Inlined by compiler; 3 call sites recovered
    local sequenceId = arg1.sequenceId
    return if typeof(sequenceId) == "number" and sequenceId >= 0 then sequenceId else nil
end

return {
    mergeHistoryIntoMap = function(tbl1, tbl2, tbl3)
        for _, value in tbl2 do
            local sequenceId = getSequenceId(value)

            if sequenceId ~= nil and tbl3[sequenceId] == nil then
                tbl1[sequenceId] = value
            end
        end
    end,
    orderMergedHistoryItems = function(tbl1, tbl2)
        local var1 = table.clone(tbl1)
        for value, value2 in tbl2 do
            var1[value] = value2
        end

        local result = {}
        for _, value in var1 do
            table.insert(result, value)
        end

        table.sort(result, function(arg1, arg2): boolean
            return (getSequenceId(arg1) or -1) < (getSequenceId(arg2) or -1)
        end)

        return result
    end,
    ingestOverlayUpdate = function(tbl1, _, arg1, sequenceId: number): boolean
        if typeof(sequenceId) ~= "number" or sequenceId < 0 then
            return false
        end

        local var1 = table.clone(arg1)
        var1.sequenceId = sequenceId
        tbl1[sequenceId] = var1
        return true
    end
}

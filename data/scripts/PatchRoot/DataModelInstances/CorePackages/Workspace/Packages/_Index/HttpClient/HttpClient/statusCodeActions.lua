-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T00:50:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local _types = require(script.Parent.types)

local tbl1 = ({})

return {
    add = function(num1: number, func1: (...any) -> (...any))
        local tbl2 = tbl1[num1]
        if tbl2 == nil then
            tbl2 = {}
            tbl1[num1] = tbl2
        end
        table.insert(tbl2, func1)
    end,
    remove = function(num1: number, func1: (...any) -> (...any))
        local var1 = tbl1[num1]
        if var1 == nil then
            return
        end
        for value, value2 in var1 do
            if value2 == func1 then
                table.remove(var1, value)
                break
            end
        end

        if #var1 == 0 then
            tbl1[num1] = nil
        end
    end,
    clear = function()
        tbl1 = {}
    end,
    snapshot = function()
        if next(tbl1) == nil then
            return nil
        end
        local result = ({})
        for value, value2 in tbl1 do
            local tbl2 = {}
            for i = #value2, 1, -1 do
                table.insert(tbl2, value2[i])
            end
            result[value] = tbl2
        end
        return result
    end
}

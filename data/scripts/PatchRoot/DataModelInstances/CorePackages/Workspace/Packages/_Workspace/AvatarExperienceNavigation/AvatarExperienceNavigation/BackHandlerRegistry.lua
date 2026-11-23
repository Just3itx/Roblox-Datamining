-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T17:01:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local tbl1 = {}

return {
    register = function(func1: (...any) -> (...any))
        table.insert(tbl1, func1)

        return function()
            local var1 = table.find(tbl1, func1)
            if var1 then
                table.remove(tbl1, var1)
            end
        end
    end,
    consume = function(): boolean
        local var1 = tbl1[#tbl1]
        if not var1 then
            return false
        end

        var1()
        return true
    end
}

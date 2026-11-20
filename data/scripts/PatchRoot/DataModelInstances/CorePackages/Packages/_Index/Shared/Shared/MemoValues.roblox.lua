-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:20:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local tbl1 = {}

return {
    pack = function(...)
        local select = select

        if select("#", ...) == 1 then
            return (...)
        end
        return (setmetatable(table.pack(...), tbl1))
    end,
    unpack = function(arg1)
        if type(arg1) ~= "table" or not rawequal(getmetatable(arg1), tbl1) then
            return arg1
        end

        return table.unpack(arg1, 1, arg1.n)
    end
}

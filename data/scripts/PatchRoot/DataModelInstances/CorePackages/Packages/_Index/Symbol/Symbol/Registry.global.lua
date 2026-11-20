-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T16:11:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local Symbol = require(script.Parent.Symbol)

local tbl1 = ({})

return {
    getOrInit = function(str1: string)
        if tbl1[str1] == nil then
            tbl1[str1] = Symbol.new(str1)
        end

        return tbl1[str1]
    end,
    __clear = function()
        tbl1 = {}
    end
}

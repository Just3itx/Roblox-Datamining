-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T07:00:42Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local _Types = require(scriptParent.Types)

local function memoize(arg1, func1: ((...any) -> (...any))?)
    local tbl1 = ({})

    return function(...)
        local tbl2 = { ... }
        local var1 = if func1 then func1(...) else table.concat(tbl2, "|")

        if tbl1[var1] == nil then
            tbl1[var1] = arg1(...)
        end

        return tbl1[var1]
    end
end

return memoize

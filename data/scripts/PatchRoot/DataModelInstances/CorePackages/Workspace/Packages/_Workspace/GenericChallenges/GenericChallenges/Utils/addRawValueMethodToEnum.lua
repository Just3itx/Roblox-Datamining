-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T16:40:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(arg1, arg2)
    local tbl1 = {}
    for k, value in pairs(arg2) do
        tbl1[arg1[k]] = value
    end

    local var1 = getmetatable(arg1)
    local __index = var1.__index
    function var1.__index(_, arg3)
        return if arg3 == "toRawValue" then function(arg4)
            return tbl1[arg4]
        end else __index[arg3]
    end
end

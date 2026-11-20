-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:50:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function createUniqueKey()
    local tbl1 = ({})

    return function(arg1)
        if tbl1[arg1] == nil then
            tbl1[arg1] = 1
            return arg1
        end

        local var1

        repeat
            local tbl2 = tbl1
            tbl2[arg1] += 1
            var1 = `{arg1}_{tbl1[arg1]}`
        until tbl1[var1] == nil

        return var1
    end
end

return createUniqueKey

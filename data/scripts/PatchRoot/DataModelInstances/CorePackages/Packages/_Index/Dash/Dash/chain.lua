-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T06:41:16Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local function chain(...)
    local tbl1 = { ... }
    local num1 = #tbl1
    local num2 = 1
    return function()
        while num2 <= num1 do
            local tbl2 = { tbl1[num2]() }
            if tbl2[1] ~= nil then
                return table.unpack(tbl2)
            end
            num2 += 1
        end

        return nil
    end
end

return chain

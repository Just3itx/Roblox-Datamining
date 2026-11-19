-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T05:10:33Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local function prettyPrint(arg1, arg2): string
    arg2 = arg2 or 0
    local tbl1 = {}

    if typeof(arg1) == "table" then
        table.insert(tbl1, "{\n")

        for k, value in pairs(arg1) do
            local var1 = arg2 + 1
            table.insert(tbl1, ("    "):rep(var1))
            table.insert(tbl1, tostring(k))
            table.insert(tbl1, " = ")

            local var2 = prettyPrint
            local var3 = arg2 + 1
            table.insert(tbl1, var2(value, var3))
            table.insert(tbl1, "\n")
        end

        table.insert(tbl1, ("    "):rep(arg2))
        table.insert(tbl1, "}")
    elseif typeof(arg1) == "string" then
        table.insert(tbl1, string.format("%q", arg1))
        table.insert(tbl1, " (string)")
    else
        table.insert(tbl1, tostring(arg1))
        table.insert(tbl1, " (")
        table.insert(tbl1, typeof(arg1))
        table.insert(tbl1, ")")
    end

    return table.concat(tbl1, "")
end

return prettyPrint

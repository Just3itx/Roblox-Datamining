-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:31:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function unindentTags(str1: string, num1: number?): string
    num1 = num1 or 2

    if not string.find(str1, "<.->") then
        return str1
    end

    local var1 = string.gsub(str1, "\r\n", "\n")
    local tbl1 = string.split(var1, "\n")
    local var2 = table.create(#tbl1)
    local tbl2 = {}

    for _, value in tbl1 do
        local _, var3 = string.find(value, "^[ \t]*")
        local var4 = var3 or 0
        local str2 = string.sub(value, var4 + 1)

        if string.find(str2, "^<") then
            if string.find(str2, "^</") then
                table.remove(tbl2)
                table.insert(var2, str2)
            elseif string.find(str2, "/>$") then
                table.insert(var2, str2)
            else
                table.insert(tbl2, var4)
                table.insert(var2, str2)
            end
        else
            local num2 = math.max(0, var4 - (if #tbl2 > 0 then tbl2[#tbl2] + num1 else 0))
            table.insert(var2, string.rep(" ", num2) .. str2)
        end
    end

    return table.concat(var2, "\n")
end

return unindentTags

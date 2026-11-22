-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T03:41:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local tbl1 = {
    [10] = true,
    [11] = true,
    [12] = true,
    [13] = true,
    [133] = true,
    [8232] = true,
    [8233] = true
}

local tbl2 = {
    [9] = true,
    [32] = true,
    [160] = true,
    [5760] = true,
    [8192] = true,
    [8193] = true,
    [8194] = true,
    [8195] = true,
    [8196] = true,
    [8197] = true,
    [8198] = true,
    [8199] = true,
    [8200] = true,
    [8201] = true,
    [8202] = true,
    [8239] = true,
    [8287] = true,
    [12288] = true
}

local tbl3 = { [6158] = true, [8203] = true, [8288] = true, [65279] = true }

local function normalizeAsciiWhitespace(str1: string)
    local var1 = string.gsub(str1, "%s+", function(str2: string): string
        return if string.find(str2, "[\n\11\f\r]") then "\n" else " "
    end)
    return (string.gsub(string.gsub(var1, "^[ \n]", ""), "[ \n]$", ""))
end

local function normalizeCommentText(str1: string)
    if utf8.len(str1) == nil then
        return (normalizeAsciiWhitespace(str1))
    end

    local tbl4 = {}
    local var1 = nil
    local var2 = nil
    for value, value2 in utf8.codes(str1) do
        local bool1 = tbl1[value2] == true
        local bool2 = tbl2[value2] == true
        if bool1 or bool2 or tbl3[value2] == true then
            if var1 ~= nil then
                table.insert(tbl4, string.sub(str1, var1, value - 1))
                var1 = nil
            end

            if bool1 then
                var2 = "\n"
            elseif bool2 and var2 ~= "\n" then
                var2 = " "
            elseif var2 == nil then
                var2 = ""
            end
        elseif var1 == nil then
            if var2 ~= nil and #tbl4 > 0 then
                table.insert(tbl4, var2)
            end

            var1 = value
            var2 = nil
        end
    end

    if var1 ~= nil then
        table.insert(tbl4, string.sub(str1, var1))
    end
    return table.concat(tbl4)
end

return normalizeCommentText

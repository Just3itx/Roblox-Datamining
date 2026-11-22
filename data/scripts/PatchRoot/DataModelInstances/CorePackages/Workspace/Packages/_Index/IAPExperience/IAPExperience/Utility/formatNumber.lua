-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:30:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local tbl1 = {
    ["en-us"] = ",",
    ["en-gb"] = ",",
    ["es-mx"] = ",",
    ["es-es"] = ".",
    ["fr-fr"] = " ",
    ["de-de"] = " ",
    ["pt-br"] = ".",
    ["zh-cn"] = ",",
    ["zh-cjv"] = ",",
    ["zh-tw"] = ",",
    ["ko-kr"] = ",",
    ["ja-jp"] = ",",
    ["it-it"] = " ",
    ["ru-ru"] = ".",
    ["id-id"] = ".",
    ["vi-vn"] = ".",
    ["th-th"] = ",",
    ["tr-tr"] = "."
}

local function addGroupDelimiters(str1: string, str2: string)
    local str3 = string.format("%%1%s%%2", str2)

    repeat
        local var1
        str1, var1 = string.gsub(str1, "^(-?%d+)(%d%d%d)", str3)
    until var1 == 0

    return str1
end

return function(str1: string, num1: number)
    local var1 = tbl1[str1] or ","

    return (addGroupDelimiters(num1, var1))
end

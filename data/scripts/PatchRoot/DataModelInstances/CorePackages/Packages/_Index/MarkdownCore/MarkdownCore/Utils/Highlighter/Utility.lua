-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:41:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}

function module.sanitizeRichText(str1: string)
    return string.gsub(
        string.gsub(string.gsub(string.gsub(string.gsub(str1, "&", "&amp;"), "<", "&lt;"), ">", "&gt;"), "\"", "&quot;"),
        "'",
        "&apos;"
    )
end

function module.convertTabsToSpaces(str1: string)
    return string.gsub(str1, "\t", "    ")
end

function module.removeControlChars(str1: string)
    return string.gsub(str1, "[\0\1\2\3\4\5\6\7\8\11\f\r\14\15\16\17\18\19\20\21\22\23\24\25\26\27\28\29\30\31]+", "")
end

return module

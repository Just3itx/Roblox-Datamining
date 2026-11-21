-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T11:11:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function extractAndStyleRichTextLinks(str1: string?)
    if str1 == nil then
        return {}, ""
    end

    local tbl1 = {}

    return tbl1, (string.gsub(str1, "<a%s+href=\"([^\"]+)\">([^<]*)</a>", function(str2: string, str3: string): string
        table.insert(tbl1, str2)
        return `<u><b>{str3}</b></u>`
    end))
end
return extractAndStyleRichTextLinks

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T02:11:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InlineRichTextParent = script:FindFirstAncestor("InlineRichText").Parent
local FFlagInlineRichTextSkipPlaintextEscape = require(InlineRichTextParent.SharedFlags).FFlagInlineRichTextSkipPlaintextEscape

local str1 = utf8.char(8220)
local str2 = utf8.char(8221)
local str3 = utf8.char(8217)

local function decodeQuoteEntities(str4: string)
    return str4:gsub("&amp;quot;", "\""):gsub("&amp;apos;", "'"):gsub("&quot;", "\""):gsub("&apos;", "'"):gsub("&#34;", "\""):gsub(
        "&#39;",
        "'"
    )
end

local function toTypographicQuotesOutsideTags(str4: string): string
    local tbl1 = {}
    local bool1 = false
    local bool2 = true

    for i = 1, #str4 do
        local str5 = str4:sub(i, i)
        if str5 == "<" then
            table.insert(tbl1, str5)
            bool1 = true
        elseif str5 == ">" then
            table.insert(tbl1, str5)
            bool1 = false
        elseif bool1 then
            table.insert(tbl1, str5)
        elseif str5 == "\"" then
            table.insert(tbl1, if bool2 then str1 else str2)
            bool2 = not bool2
        elseif str5 == "'" then
            table.insert(tbl1, str3)
        else
            table.insert(tbl1, str5)
        end
    end

    return table.concat(tbl1)
end

local function prepareRichTextCopy(str4: string)
    local var1 = decodeQuoteEntities(str4)
    if FFlagInlineRichTextSkipPlaintextEscape then
        return var1
    end
    return toTypographicQuotesOutsideTags(var1)
end

return prepareRichTextCopy

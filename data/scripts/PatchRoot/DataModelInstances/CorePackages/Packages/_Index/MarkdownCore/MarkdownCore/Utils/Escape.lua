-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:40:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return {
    escapeRichFormatting = function(str1: string)
        return (str1:gsub("[&<>\"']", { ["&"] = "&amp;", ["<"] = "&lt;", [">"] = "&gt;", ["\""] = "&quot;", ["'"] = "&apos;" }):gsub(
            "&amp;%l+;",
            {
                ["&amp;lt;"] = "&lt;",
                ["&amp;gt;"] = "&gt;",
                ["&amp;quot;"] = "&quot;",
                ["&amp;apos;"] = "&apos;",
                ["&amp;amp;"] = "&amp;"
            }
        ))
    end,
    unescapeRichFormatting = function(str1: string)
        return str1:gsub("&%l+;", { ["&lt;"] = "<", ["&gt;"] = ">", ["&quot;"] = "\"", ["&apos;"] = "'", ["&amp;"] = "&" })
    end
}

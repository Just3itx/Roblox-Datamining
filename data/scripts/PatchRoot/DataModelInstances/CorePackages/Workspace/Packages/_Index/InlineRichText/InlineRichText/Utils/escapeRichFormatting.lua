-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T02:11:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function escapeRichFormatting(str1: string)
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
end

return escapeRichFormatting

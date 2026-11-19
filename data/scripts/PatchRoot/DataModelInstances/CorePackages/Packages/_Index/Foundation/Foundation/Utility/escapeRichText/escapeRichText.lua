-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T10:10:53Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local function escapeRichText(str1: string)
    return str1:gsub("[&<>\"']", { ["&"] = "&amp;", ["<"] = "&lt;", [">"] = "&gt;", ["\""] = "&quot;", ["'"] = "&apos;" })
end

return escapeRichText

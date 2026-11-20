-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:31:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function processSoftBreaks(str1: string)
    return (str1:gsub("%s*[\r\n]%s*", " "))
end
return processSoftBreaks

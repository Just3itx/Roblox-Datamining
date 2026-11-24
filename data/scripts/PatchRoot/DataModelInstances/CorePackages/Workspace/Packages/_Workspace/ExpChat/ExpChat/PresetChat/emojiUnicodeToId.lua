-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:11:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function emojiUnicodeToId(str1: string): string
    local tbl1 = {}
    for _, value in utf8.codes(str1) do
        table.insert(tbl1, string.format("%x", value))
    end
    return table.concat(tbl1, "-")
end

return emojiUnicodeToId

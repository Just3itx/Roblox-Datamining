-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T04:50:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _Types = require(script.Parent.Parent.Types)

local function buildStringsToLocalize(tbl1)
    local stringsToLocalize = {}
    for _, value in tbl1 do
        stringsToLocalize[value.nameTranslationKey] = value.nameTranslationKey
    end
    return stringsToLocalize
end

return buildStringsToLocalize

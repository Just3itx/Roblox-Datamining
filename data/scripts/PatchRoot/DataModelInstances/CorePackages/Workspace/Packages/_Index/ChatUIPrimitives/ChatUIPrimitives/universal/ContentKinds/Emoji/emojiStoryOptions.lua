-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:30:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local tbl1 = {
    ["grinning-face"] = "😀",
    ["waving-hand"] = "👋",
    ["thumbs-up"] = "👍",
    ["party-popper"] = "🎉"
}

return {
    names = {
        "grinning-face",
        "waving-hand",
        "thumbs-up",
        "party-popper"
    },
    unicodeOf = function(str1: string)
        return tbl1[str1]
    end
}

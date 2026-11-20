-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:30:59Z
-- Luau bytecode version: 14 | Luau type version: 3
return {
    CONTAINERS = { ROOT = true, TAG = true },
    LISTS = { BULLET_LIST_ITEM = true, BULLET_LIST_ITEM_2 = true, ORDERED_LIST_ITEM = true },
    INLINE_TEXT = {
        STYLED_TEXT = true,
        INLINE_CODE = true,
        LINK = true,
        IMAGE = true,
        ACTION = true,
        TABLE_DIVIDER = true,
        TABLE_HEADER = true,
        TABLE_HEADER_2 = true,
        TEXT = true,
        BREAK = true
    },
    PLAIN_TEXT = { TEXT = true, TABLE_DIVIDER = true, TABLE_HEADER = true, TABLE_HEADER_2 = true },
    STYLED_TEXT = { BOLD = "b", BOLD_2 = "b", ITALIC = "i", ITALIC_2 = "i", STRIKE = "s" },
    DIVIDERS = { LINE_BREAK = true, DIVIDER = true },
    ASCII = {
        WHITESPACE_PATTERN = "%s",
        PUNCTUATION_PATTERN = "[!/:;,_`|{}~<>=#&@'%%\"\\%$%(%)%*%+%-%.%?%[%]%^]"
    },
    UNICODE = require(script.Parent.UnicodeConstants)
}

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:41:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local EmojiContentModel = require(script.Parent.Parent.ContentKinds.Emoji.EmojiContentModel)

local module = {}

function module.fromEmoji(str1: string, str2: string?, str3: string?)
    return EmojiContentModel.fromEmoji(str1, str2, str3)
end

return module

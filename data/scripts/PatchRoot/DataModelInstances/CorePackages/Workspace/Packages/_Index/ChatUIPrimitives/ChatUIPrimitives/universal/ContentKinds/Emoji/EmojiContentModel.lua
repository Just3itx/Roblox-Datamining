-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:30:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _Types = require(script.Parent.Parent.Parent.Types)
local _EmojiTypes = require(script.Parent.EmojiTypes)

local module = {}

function module.detailFromEmoji(emojiId: string, unicode: string?, name: string?)
    return {
        fallbackText = if unicode == nil or unicode == "" then nil else unicode,
        emojiId = emojiId,
        unicode = unicode,
        name = name
    }
end

function module.fromEmoji(emojiId: string, unicode: string?, str1: string?)
    return {
        emoji = module.detailFromEmoji(emojiId, unicode, str1)
    }
end

function module.draftFromEmoji(emojiId: string, unicode: string)
    return {
        emoji = { emojiId = emojiId, unicode = unicode }
    }
end

function module.getDisplayText(arg1)
    if arg1.unicode == nil or arg1.unicode == "" then
        if arg1.fallbackText == nil or arg1.fallbackText == "" then
            return arg1.name or ""
        end

        return arg1.fallbackText
    end

    return arg1.unicode
end

function module.getDetail(arg1)
    return arg1.emoji
end

function module.getDraft(arg1)
    return arg1.emoji
end

function module.fromDraft(arg1)
    local draft = module.getDraft(arg1)
    if draft == nil then
        return nil
    end
    return module.fromEmoji(draft.emojiId, draft.unicode, nil)
end

return module

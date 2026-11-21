-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:41:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local _Types = require(script.Parent.Types)
local PlainTextContentModel = require(script.Parent.ContentKinds.PlainText.PlainTextContentModel)
local PresetContentModel = require(script.Parent.ContentKinds.Preset.PresetContentModel)
local EmojiContentModel = require(script.Parent.ContentKinds.Emoji.EmojiContentModel)

local module = {}

local function idFrom(tbl1) -- Luacid: Inlined by compiler; 3 call sites recovered
    return tbl1 and tbl1.id or HttpService:GenerateGUID(false)
end

function module.fromPlainText(str1: string, tbl1)
    local sentAtUnixMilliseconds = tbl1 and tbl1.sentAtUnixMilliseconds or DateTime.now().UnixTimestampMillis
    return {
        id = tbl1 and tbl1.id or idFrom(false),
        sentAtUnixMilliseconds = sentAtUnixMilliseconds,
        author = if tbl1 then tbl1.author else nil,
        contents = { PlainTextContentModel.fromText(str1) }
    }
end

function module.fromPreset(str1: string, str2: string, arg1)
    local sentAtUnixMilliseconds = arg1 and arg1.sentAtUnixMilliseconds or DateTime.now().UnixTimestampMillis
    local presetVersion = if arg1 then arg1.presetVersion else nil
    return {
        id = arg1 and arg1.id or idFrom(false),
        sentAtUnixMilliseconds = sentAtUnixMilliseconds,
        author = if arg1 then arg1.author else nil,
        contents = { PresetContentModel.fromPreset(str1, str2, presetVersion) }
    }
end

function module.fromEmoji(str1: string, str2: string?, arg1)
    local sentAtUnixMilliseconds = arg1 and arg1.sentAtUnixMilliseconds or DateTime.now().UnixTimestampMillis
    local tbl1 = {
        id = arg1 and arg1.id or idFrom(false),
        sentAtUnixMilliseconds = sentAtUnixMilliseconds,
        author = if arg1 then arg1.author else nil,
        contents = { EmojiContentModel.fromEmoji(str1, str2, if arg1 then arg1.name else nil) }
    }
    return tbl1
end

local function previewText(arg1)
    local content = arg1.contents[1]
    if content == nil then
        return ""
    end
    local detail = PlainTextContentModel.getDetail(content)
    if detail ~= nil then
        return detail.fallbackText
    end
    local detail2 = PresetContentModel.getDetail(content)
    if detail2 ~= nil then
        return detail2.fallbackText
    end
    local detail3 = EmojiContentModel.getDetail(content)
    if detail3 ~= nil then
        return EmojiContentModel.getDisplayText(detail3)
    end
    return ""
end

function module.replyReference(arg1, label: string?)
    return {
        id = arg1.id,
        preview = {
            author = arg1.author,
            fallbackText = previewText(arg1)
        },
        label = label
    }
end

return module

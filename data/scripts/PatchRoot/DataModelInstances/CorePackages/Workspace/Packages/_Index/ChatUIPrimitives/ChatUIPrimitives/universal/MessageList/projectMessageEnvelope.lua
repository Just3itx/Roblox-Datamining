-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:41:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _Types = require(script.Parent.Parent.Types)
local PlainTextContentModel = require(script.Parent.Parent.ContentKinds.PlainText.PlainTextContentModel)
local PresetContentModel = require(script.Parent.Parent.ContentKinds.Preset.PresetContentModel)
local EmojiContentModel = require(script.Parent.Parent.ContentKinds.Emoji.EmojiContentModel)

local function contentFromDraft(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    local draft = PlainTextContentModel.fromDraft(arg1)
    if draft ~= nil then
        return draft
    end
    local draft2 = PresetContentModel.fromDraft(arg1)
    if draft2 ~= nil then
        return draft2
    end
    local draft3 = EmojiContentModel.fromDraft(arg1)
    return if draft3 == nil then nil else draft3
end

local function projectMessageEnvelope(arg1)
    local payload = arg1.payload
    if payload.kind == "message" then
        local message = payload.message
        return {
            id = arg1.stableId,
            sourceMessageId = message.id,
            sentAtUnixMilliseconds = message.sentAtUnixMilliseconds,
            author = message.author,
            contents = message.contents,
            repliesTo = message.repliesTo,
            deliveryState = nil
        }
    end

    local payload2 = arg1.payload
    local contents = {}
    for _, content in payload2.draft.contents do
        local var1 = contentFromDraft(content)

        if var1 ~= nil then
            table.insert(contents, var1)
        end
    end

    return {
        id = arg1.stableId,
        sourceMessageId = nil,
        sentAtUnixMilliseconds = arg1.delivery.attemptedAtUnixMilliseconds,
        author = payload2.author,
        contents = contents,
        repliesTo = nil,
        deliveryState = arg1.delivery.state
    }
end

return projectMessageEnvelope

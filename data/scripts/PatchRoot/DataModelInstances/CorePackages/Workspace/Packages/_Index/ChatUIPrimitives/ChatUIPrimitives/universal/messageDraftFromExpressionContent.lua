-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:31:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _Types = require(script:FindFirstAncestor("ChatUIPrimitives").UniversalMessage.Types)
local MessageDraftModel = require(script.Parent.MessageDraftModel)
local _Types2 = require(script.Parent.Types)

local function fallbackPlainText(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    if arg1.altText == nil then
        if arg1.kind == "plain-text" and arg1.text ~= "" then
            return arg1.text
        end

        return nil
    elseif arg1.altText == "" then
        return nil
    end

    return arg1.altText
end

local function messageDraftFromExpressionContent(arg1)
    if arg1.kind == "preset" then
        local presetId = arg1.presetId
        local text = arg1.text
        if presetId == "" or text == nil or text == "" then
            return nil
        end
        return MessageDraftModel.fromPreset(presetId, text)
    end

    if arg1.kind == "emoji" then
        local unicode = arg1.unicode
        if arg1.emojiId ~= "" and unicode ~= nil and unicode ~= "" then
            return MessageDraftModel.fromEmoji(arg1.emojiId, unicode)
        end
    end

    local var1 = fallbackPlainText(arg1)

    if var1 == nil then
        return nil
    end
    return MessageDraftModel.fromPlainText(var1)
end

return messageDraftFromExpressionContent

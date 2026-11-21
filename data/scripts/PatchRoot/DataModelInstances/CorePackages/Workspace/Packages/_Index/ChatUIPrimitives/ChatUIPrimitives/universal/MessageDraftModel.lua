-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:31:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _Types = require(script.Parent.Types)
local PlainTextContentModel = require(script.Parent.ContentKinds.PlainText.PlainTextContentModel)
local PlainTextTypes = require(script.Parent.ContentKinds.PlainText.PlainTextTypes)
local PresetContentModel = require(script.Parent.ContentKinds.Preset.PresetContentModel)
local PresetTypes = require(script.Parent.ContentKinds.Preset.PresetTypes)
local EmojiTypes = require(script.Parent.ContentKinds.Emoji.EmojiTypes)
local EmojiContentModel = require(script.Parent.ContentKinds.Emoji.EmojiContentModel)

local module = {}

function module.fromPlainText(str1: string)
    return {
        contents = { PlainTextContentModel.draftFromText(str1) }
    }
end

function module.fromPreset(str1: string, str2: string)
    return {
        contents = { PresetContentModel.draftFromPreset(str1, str2) }
    }
end

local function singleContentItem(arg1) -- Luacid: Inlined by compiler; 3 call sites recovered
    if typeof(arg1) ~= "table" then
        return nil
    end
    local contents = arg1.contents
    if typeof(contents) ~= "table" or #contents ~= 1 then
        return nil
    end
    local content = contents[1]
    return if typeof(content) == "table" then content else nil
end

local function onlyField(arg1, str1: string) -- Luacid: Inlined by compiler; 3 call sites recovered
    local var1 = arg1[str1]
    if var1 == nil then
        return nil
    end
    for value in arg1 do
        if value ~= str1 then
            return nil
        end
    end
    return var1
end

local function isValidPlainTextPayload(arg1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return PlainTextTypes.isValidDraft(arg1) == true
end

local function isValidPresetPayload(arg1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return PresetTypes.isValidDraft(arg1) == true
end

local function isValidEmojiPayload(arg1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return EmojiTypes.isValidDraft(arg1) == true
end

function module.toPlainText(arg1)
    local var1 = singleContentItem(arg1)

    if var1 == nil then
        return nil
    end

    local var2 = onlyField(var1, "plainText")
    return if isValidPlainTextPayload(var2) then var2.text else nil
end

function module.toPreset(arg1)
    local var1 = singleContentItem(arg1)

    if var1 == nil then
        return nil
    end

    local var2 = onlyField(var1, "preset")
    return if isValidPresetPayload(var2) then var2 else nil
end

function module.fromEmoji(str1: string, str2: string)
    return {
        contents = { EmojiContentModel.draftFromEmoji(str1, str2) }
    }
end

function module.toEmoji(arg1)
    local var1 = singleContentItem(arg1)

    if var1 == nil then
        return nil
    end

    local var2 = onlyField(var1, "emoji")
    return if isValidEmojiPayload(var2) then var2 else nil
end

return module

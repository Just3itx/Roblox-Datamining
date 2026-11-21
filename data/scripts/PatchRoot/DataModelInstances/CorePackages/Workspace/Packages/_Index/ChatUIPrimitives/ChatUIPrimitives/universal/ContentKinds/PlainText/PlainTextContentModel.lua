-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:30:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _Types = require(script.Parent.Parent.Parent.Types)
local _PlainTextTypes = require(script.Parent.PlainTextTypes)

local module = {}

function module.detailFromText(text: string)
    return {
        fallbackText = text,
        displayText = { text = text },
        wasRewritten = false
    }
end

function module.fromText(text: string)
    return {
        plainText = module.detailFromText(text)
    }
end

function module.draftFromText(text: string)
    return {
        plainText = { text = text }
    }
end

function module.getDetail(arg1)
    return arg1.plainText
end

function module.getDraft(arg1)
    return arg1.plainText
end

function module.fromDraft(arg1)
    local draft = module.getDraft(arg1)
    if draft == nil then
        return nil
    end
    return module.fromText(draft.text)
end

return module

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:30:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _Types = require(script.Parent.Parent.Parent.Types)
local _PresetTypes = require(script.Parent.PresetTypes)

local module = {}

function module.detailFromPreset(presetId: string, displayText: string, presetVersion: string?)
    return {
        fallbackText = displayText,
        presetId = presetId,
        presetVersion = presetVersion,
        displayText = displayText
    }
end

function module.fromPreset(presetId: string, displayText: string, presetVersion: string?)
    return {
        preset = module.detailFromPreset(presetId, displayText, presetVersion)
    }
end

function module.draftFromPreset(presetId: string, displayText: string)
    return {
        preset = { presetId = presetId, displayText = displayText }
    }
end

function module.getDetail(arg1)
    return arg1.preset
end

function module.getDraft(arg1)
    return arg1.preset
end

function module.fromDraft(arg1)
    local draft = module.getDraft(arg1)
    if draft == nil then
        return nil
    end
    return module.fromPreset(draft.presetId, draft.displayText, nil)
end

return module

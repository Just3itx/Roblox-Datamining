-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:41:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PresetContentModel = require(script.Parent.Parent.ContentKinds.Preset.PresetContentModel)

local module = {}

function module.fromPreset(str1: string, str2: string, str3: string?)
    return PresetContentModel.fromPreset(str1, str2, str3)
end

return module

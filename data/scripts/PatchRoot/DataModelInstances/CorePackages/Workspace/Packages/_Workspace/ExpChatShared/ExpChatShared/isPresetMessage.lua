-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T10:30:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function isPresetMessage(tbl1): boolean
    if tbl1 == nil then
        return false
    end
    local presetId = tbl1.presetId
    return not (presetId == nil) and presetId ~= ""
end

return isPresetMessage

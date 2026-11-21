-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:50:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function getAssetPickerStatus(bool1: boolean, bool2: boolean): string
    return if bool1 then "loading" elseif bool2 then "error" else "ready"
end

return getAssetPickerStatus

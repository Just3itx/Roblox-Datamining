-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:50:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function getMessageTextSize(tbl1, bool1: boolean?)
    return if tbl1 == nil then nil elseif bool1 then tbl1.SpatialPanelTextSize else tbl1.TextSize
end

return getMessageTextSize

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T21:31:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function getRectCenter(rect: Rect)
    return (rect.Min + rect.Max) / 2
end

return getRectCenter

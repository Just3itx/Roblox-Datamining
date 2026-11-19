-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T06:11:12Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local function toRect(arg1)
    local str1 = typeof(arg1)
    if str1 == "Rect" then
        return arg1
    elseif str1 == "Instance" then
        return Rect.new(arg1.AbsolutePosition, arg1.AbsolutePosition + arg1.AbsoluteSize)
    end
end

return toRect

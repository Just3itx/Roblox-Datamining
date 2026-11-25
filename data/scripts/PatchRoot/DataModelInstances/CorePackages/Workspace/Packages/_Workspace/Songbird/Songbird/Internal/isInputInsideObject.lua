-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T17:01:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function isInputInsideObject(vec1: vector, arg1): boolean
    if not arg1 then
        return false
    end

    local absolutePosition = arg1.AbsolutePosition
    local absoluteSize = arg1.AbsoluteSize
    local rect = Rect.new(absolutePosition, absolutePosition + absoluteSize)

    return vec1.X >= rect.Min.X and vec1.Y >= rect.Min.Y and vec1.X <= rect.Max.X and vec1.Y <= rect.Max.Y
end

return isInputInsideObject

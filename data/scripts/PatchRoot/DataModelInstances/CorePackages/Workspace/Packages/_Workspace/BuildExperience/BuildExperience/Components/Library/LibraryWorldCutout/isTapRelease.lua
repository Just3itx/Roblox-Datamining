-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:51:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function isTapRelease(vec1: vector?, arg1): boolean
    if vec1 == nil or arg1 == nil then
        return true
    end
    local var1 = arg1.Position - vec1
    return Vector2.new(var1.X, var1.Y).Magnitude <= 10
end

return isTapRelease

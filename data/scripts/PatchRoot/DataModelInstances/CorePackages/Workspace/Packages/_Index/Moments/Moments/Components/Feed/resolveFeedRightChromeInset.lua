-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:30:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function resolveFeedRightChromeInset(tbl1, num1: number?, num2: number): number
    if num1 ~= nil then
        return math.max(tbl1.right, num1)
    end

    return math.max(tbl1.right, num2)
end

return resolveFeedRightChromeInset

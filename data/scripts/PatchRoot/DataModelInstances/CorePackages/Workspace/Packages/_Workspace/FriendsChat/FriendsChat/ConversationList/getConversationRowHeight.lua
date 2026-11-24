-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T13:00:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function getConversationRowHeight(num1: number, num2: number, bool1: boolean): number
    return num1 + (if bool1 then num2 * 2 else 0)
end

return getConversationRowHeight

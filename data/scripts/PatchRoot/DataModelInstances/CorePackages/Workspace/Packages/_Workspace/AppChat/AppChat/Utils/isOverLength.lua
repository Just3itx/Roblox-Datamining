-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:41:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")

local countChars = require(AppChat.Utils.countChars)
local countUtf16Units = require(AppChat.Utils.countUtf16Units)

local function isOverLength(str1: string, num1: number, num2: number): boolean
    return not (#str1 <= math.min(num1, num2)) and (num2 < countUtf16Units(str1) or num1 < countChars(str1))
end

return isOverLength

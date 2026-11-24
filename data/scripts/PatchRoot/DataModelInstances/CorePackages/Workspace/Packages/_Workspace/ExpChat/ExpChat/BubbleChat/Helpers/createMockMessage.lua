-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T07:40:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local ExpChatParent = script:FindFirstAncestor("ExpChat").Parent
local Dictionary = require(ExpChatParent.llama).Dictionary

local num1 = 0

local function createMockMessage(arg1)
    num1 += 1

    return Dictionary.join({ name = "Foo", id = tostring(num1), userId = "1", text = "Hello, World!", timestamp = num1 }, arg1)
end

return createMockMessage

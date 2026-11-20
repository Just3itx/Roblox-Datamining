-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:21:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local str1 = "id-" .. tostring(math.random(100000, 1000000))
local num1 = 0

local module = {}

function module._TESTING_ONLY_normalize_keys()
    str1 = "id-"
    num1 = 0
end

function module.generateKey()
    local str2 = str1 .. tostring(num1)
    num1 += 1
    return str2
end

return module

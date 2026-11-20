-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:40:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local copy = require(script.Parent.copy)

local function removeKey(arg1, ...)
    local str1 = type(arg1)
    assert(str1 == "table", "expected a table for first argument, got " .. str1)

    local var1 = copy(arg1)

    local select2 = select

    for i = 1, select2("#", ...) do
        local select = select
        var1[select(i, ...)] = nil
    end

    return var1
end

return removeKey

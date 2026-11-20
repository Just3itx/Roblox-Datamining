-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:41:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {
    Priority = { Default = 1, Overlay = 2, Elevated = 3, Immediate = 4 }
}

function module.new(id, priority, arg2)
    return {
        id = id,
        priority = priority,
        createdAt = tick(),
        data = arg2
    }
end
return module

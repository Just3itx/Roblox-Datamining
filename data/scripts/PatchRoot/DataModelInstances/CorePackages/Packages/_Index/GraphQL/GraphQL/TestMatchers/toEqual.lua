-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:01:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local deepEqual = require(script.Parent.Parent.luaUtils.deepEqual)

local function toEqual(arg1, arg2)
    local pass, var2 = deepEqual(arg1, arg2)

    return {
        pass = pass,
        message = if pass then ("expected: not %s\nreceived:     %s"):format(tostring(arg2), tostring(arg1)) else var2:gsub("{1}", "received"):gsub("{2}", "expected")
    }
end

return toEqual

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T00:10:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _types = require(script.Parent.types)

local __DEV__ = _G.__DEV__

local function inspectRouteEntry(arg1)
    local var1, var2 = next(arg1)
    if __DEV__ then
        assert(var1 and var2, "route entry should contain exactly one route config")
    end
    return var1, var2
end

return inspectRouteEntry

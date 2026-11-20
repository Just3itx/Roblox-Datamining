-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:50:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}
module.__index = module

function module.new(arg1)
    local var1 = arg1 or {}

    setmetatable(var1, { __index = module })

    return var1
end

function module.GetItem(arg1, arg2)
    return arg1[arg2]
end

function module.SetItem(arg1, arg2, arg3)
    arg1[arg2] = tostring(arg3)
end

function module.flush(_) end

return module

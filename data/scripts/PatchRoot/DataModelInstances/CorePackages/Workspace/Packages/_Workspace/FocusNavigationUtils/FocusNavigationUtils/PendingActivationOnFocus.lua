-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T11:41:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local get = nil

local module = {}

function module.get()
    return get
end

function module.set(tbl1)
    get = tbl1
end

function module.cancel()
    local var2 = get
    if var2 == nil then
        return
    end
    get = nil
    pcall(task.cancel, var2.thread)
end

function module.flush()
    local var2 = get
    if var2 == nil then
        return nil
    end
    module.cancel()
    return var2.activate()
end

return module

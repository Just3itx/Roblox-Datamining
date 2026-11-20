-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T02:10:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function isCallable(arg1)
    if typeof(arg1) == "function" then
        return true
    end
    if typeof(arg1) == "table" then
        local var1 = getmetatable(arg1)
        if var1 and rawget(var1, "__call") then
            return true
        end
        if arg1._isMockFunction then
            return true
        end
    end
    return false
end

return isCallable

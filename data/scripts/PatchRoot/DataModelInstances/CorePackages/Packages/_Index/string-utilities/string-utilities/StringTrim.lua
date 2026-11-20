-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T16:11:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function StringTrim(arg1, arg2, arg3)
    arg2 = arg2 or "%s"

    if #arg2 == 0 then
        return arg1
    end
    arg3 = arg3 or { left = true, right = true }

    if arg3.left then
        local var1 = string.find(arg1, "[^" .. arg2 .. "]")
        if not var1 then
            return ""
        end
        arg1 = string.sub(arg1, var1)
    end
    if arg3.right then
        local var1 = string.find(arg1, "[" .. arg2 .. "]+$")
        if not var1 then
            return arg1
        end
        arg1 = string.sub(arg1, 1, var1 - 1)
    end
    return arg1
end

return StringTrim

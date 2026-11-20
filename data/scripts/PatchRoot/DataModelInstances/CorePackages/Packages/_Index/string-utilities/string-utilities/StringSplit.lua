-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T16:11:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function StringSplit(arg1, arg2, arg3)
    if #arg1 == 0 then
        return if string.find(arg1, arg2) then {} else { "" }
    end

    arg3 = arg3 or -1

    if arg3 == 1 then
        return { arg1 }
    end
    arg2 = arg2 or "%s+"

    local var1, var2 = string.find(arg1, arg2)
    if not var1 then
        return { arg1 }
    end

    if var2 < 1 then
        local var3, var4 = string.find(string.sub(arg1, 2), arg2)
        var1 = var3 + 1
        var2 = var4 + 1
    end
    local str1 = string.sub(arg1, 1, var1 - 1)
    local str2 = string.sub(arg1, var2 + 1)

    if #str2 == 0 and var1 <= var2 then
        return { str1, str2 }
    end
    local var3 = StringSplit(str2, arg2, arg3 - 1)
    table.insert(var3, 1, str1)
    return var3
end

return StringSplit

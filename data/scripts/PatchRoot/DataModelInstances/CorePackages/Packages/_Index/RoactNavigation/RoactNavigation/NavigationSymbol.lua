-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:11:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(str1: string)
    assert(type(str1) == "string", "Symbols must be created using a string name!")

    local var1 = newproxy(true)

    getmetatable(var1).__tostring = function()
        return str1
    end

    return var1
end

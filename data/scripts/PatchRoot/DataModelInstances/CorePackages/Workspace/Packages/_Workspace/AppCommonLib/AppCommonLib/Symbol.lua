-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T11:41:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}

function module.named(str1: string)
    assert(type(str1) == "string", "Symbols must be created using a string name!")

    local var1 = newproxy(true)

    local str2 = ("Symbol(%s)"):format(str1)

    getmetatable(var1).__tostring = function()
        return str2
    end

    return var1
end

function module.unnamed()
    local var1 = newproxy(true)

    getmetatable(var1).__tostring = function(): string
        return "Unnamed Symbol"
    end

    return var1
end

return module

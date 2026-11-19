-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T11:01:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return {
    new = function(str1: string?)
        local var1 = newproxy(true)

        local str2 = if str1 then ("Symbol(%s)"):format(str1) else "Symbol()"

        getmetatable(var1).__tostring = function()
            return str2
        end

        return var1
    end
}

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:51:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function newSymbol(str1: string) -- Luacid: Inlined by compiler; 5 call sites recovered
    local var1 = newproxy(true)
    local str2 = ("Mocks.%s"):format(str1)
    getmetatable(var1).__tostring = function()
        return str2
    end
    return var1
end

return {
    Calls = newSymbol("Calls"),
    Children = newSymbol("Children"),
    Lock = newSymbol("Lock"),
    None = newSymbol("None"),
    ReturnValue = newSymbol("ReturnValue")
}

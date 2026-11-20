-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T10:00:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function newSymbol(str1: string) -- Luacid: Inlined by compiler; 13 call sites recovered
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
    None = newSymbol("None"),
    ReturnValue = newSymbol("ReturnValue"),
    Name = newSymbol("Name"),
    Address = newSymbol("Address"),
    Operations = newSymbol("Operations"),
    Spec = newSymbol("Spec"),
    SideEffect = newSymbol("SideEffect"),
    isSpy = newSymbol("isSpy"),
    isTuple = newSymbol("isTuple"),
    isMagicMock = newSymbol("isMagicMock"),
    isPredicate = newSymbol("isPredicate")
}

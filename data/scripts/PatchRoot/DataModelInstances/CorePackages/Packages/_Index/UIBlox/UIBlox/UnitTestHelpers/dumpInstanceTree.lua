-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:40:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function dumpInstanceTree(arg1, str1: string?)
    str1 = str1 or ""
    assert(str1 ~= nil, "indent must be a string")

    if arg1 == nil then
        print(str1 .. "[nil Instance]")
        return
    end

    assert(arg1 ~= nil, "instance must be non-nil")
    print(str1 .. arg1.Name)
    str1 ..= "  "
    for _, child in ipairs(arg1:GetChildren()) do
        dumpInstanceTree(child, str1)
    end
end

return dumpInstanceTree

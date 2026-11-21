-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:50:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(arg1)
    if arg1 == nil or arg1.errors == nil or not (arg1.errors[1] and arg1.errors[1].fieldData) then
        return ""
    end

    return arg1.errors[1].fieldData
end

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T05:40:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(arg1, str1: string, origin: string, btn: string)
    arg1.sendEventDeferred(str1, "buttonClick", { origin = origin, btn = btn })
end

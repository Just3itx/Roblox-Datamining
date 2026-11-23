-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:50:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(arg1)
    return if arg1 then arg1.getScreenProps("isVisible", false) or not arg1.getScreenProps("wideMode", false) else false
end

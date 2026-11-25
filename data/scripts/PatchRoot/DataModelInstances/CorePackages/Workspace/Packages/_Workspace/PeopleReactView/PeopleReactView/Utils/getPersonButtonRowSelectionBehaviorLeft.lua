-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T01:40:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(bool1: boolean, bool2: boolean): Enum.SelectionBehavior
    return if bool1 or bool2 then Enum.SelectionBehavior.Escape else Enum.SelectionBehavior.Stop
end

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T15:21:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(tbl1): boolean
    if not tbl1 then
        return false
    end

    return tbl1.userPresenceType == "InGame" and tbl1.universeId ~= nil and tbl1.universeId ~= ""
end

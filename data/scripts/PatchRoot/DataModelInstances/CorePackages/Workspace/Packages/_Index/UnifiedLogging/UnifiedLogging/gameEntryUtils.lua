-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T01:20:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return {
    extractFieldsFromGameEntry = function(arg1)
        return if arg1 then {
            universeId = arg1.universeId,
            placeId = arg1.placeId
        } else {}
    end
}

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T10:31:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(arg1, placeId: string)
    assert(type(placeId) == "string", "Expected placeId to be a string")

    arg1:setRBXEventStream("PlacesList", "openModalFromGameTile", { placeId = placeId })
end

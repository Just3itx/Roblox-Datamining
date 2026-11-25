-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T02:11:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(arg1, str1: string, field: string, aType: string, origin, btn, section)
    assert(type(str1) == "string", "Expected eventContext to be a string")
    assert(type(field) == "string", "Expected field to be a string")
    assert(type(aType) == "string", "Expected actionType to be a string")

    if origin ~= nil then
        assert(type(origin) == "string", "Expected origin to be a string")
    end

    if btn ~= nil then
        assert(type(btn) == "string", "Expected btn to be a string")
    end

    arg1:setRBXEventStream(
        str1,
        "formInteraction",
        { field = field, aType = aType, origin = origin, btn = btn, section = section }
    )
end

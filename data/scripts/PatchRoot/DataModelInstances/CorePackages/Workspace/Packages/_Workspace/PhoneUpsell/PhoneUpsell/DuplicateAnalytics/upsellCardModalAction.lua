-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T02:11:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(arg1, str1: string, field, aType: string, origin, section, errorCode)
    assert(type(str1) == "string", "Expected eventContext to be a string")
    assert(type(aType) == "string", "Expected actionType to be a string")

    arg1:setRBXEventStream(
        str1,
        "modalAction",
        { aType = aType, origin = origin, section = section, errorCode = errorCode, field = field }
    )
end

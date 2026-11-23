-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T06:10:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(arg1, str1: string, btn: string, cstm: string?)
    assert(type(str1) == "string", "Expected eventContext to be a string")
    assert(type(btn) == "string", "Expected buttonName to be a string")

    local tbl1 = { btn = btn }

    if cstm ~= nil then
        assert(type(cstm) == "string", "Expected extraData to be a string")
        tbl1.cstm = cstm
    end

    arg1:setRBXEventStream(str1, "buttonClick", tbl1)
end

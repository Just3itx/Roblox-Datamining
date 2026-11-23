-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T06:10:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(arg1, num1: number, url)
    assert(type(num1) == "number", "Expected beatInterval to be a number")

    arg1:setRBXEventStream(string.format("%s%d", "heartbeat", num1), "pageHeartbeat", { url = url })
end

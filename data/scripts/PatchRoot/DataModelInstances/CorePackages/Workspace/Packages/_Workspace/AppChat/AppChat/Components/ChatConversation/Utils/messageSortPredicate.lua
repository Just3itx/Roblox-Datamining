-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:50:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function func1(arg1): boolean -- Luacid: Inlined by compiler; 3 call sites recovered
    return not (arg1.order == nil) and not (arg1.moderated or arg1.failed)
end

return function(arg1, arg2)
    if arg1.order and arg2.order then
        return arg1.order < arg2.order
    end

    if func1(arg1) or func1(arg2) then
        return (func1(arg2))
    end

    local unixTimestamp = arg1.sent and arg1.sent:GetUnixTimestamp()
    local unixTimestamp2 = arg2.sent and arg2.sent:GetUnixTimestamp()

    if unixTimestamp and unixTimestamp2 and unixTimestamp ~= unixTimestamp2 then
        return unixTimestamp < unixTimestamp2
    end

    if arg1.id and arg2.id and arg1.id ~= arg2.id then
        return arg1.id > arg2.id
    end

    return arg2.moderated == true or arg2.failed == true
end

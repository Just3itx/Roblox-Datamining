-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T07:40:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(arg1, arg2, arg3, arg4)
    if not arg1 then
        return ""
    end

    if arg2 == "Muted" or arg2 == "LOCAL_MUTED" then
        return arg1("Muted", arg4)
    end

    if arg2 == "Connecting" then
        return arg1("Connecting", arg4)
    elseif arg2 == "Inactive" then
        return arg1("Unmuted0", arg4)
    end

    if arg2 ~= "Talking" then
        return arg1("Error", arg4)
    end

    return arg1("Unmuted" .. tostring(math.floor(0.5 + 5 * arg3) * 20), arg4)
end

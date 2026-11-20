-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:31:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(arg1)
    local var1 = (setmetatable({}, {
        __index = function<T>(arg2, arg3): T?
            return rawget(arg2, arg3:lower())
        end,
        __newindex = function<T>(arg2, arg3, arg4: T)
            rawset(arg2, arg3:lower(), arg4)
        end
    }))

    for k, value in pairs(arg1) do
        var1[k] = value
    end

    return var1
end

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-18T23:06:02Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local function captureSize(...)
    return { ... }, select("#", ...)
end

local function memoize(func1: (...any) -> (...any))
    assert(type(func1) == "function", "memoize requires a function to memoize")

    local var1 = nil
    local var2 = nil
    local var3 = nil
    local var4 = nil

    return function(...)
        local select2 = select
        local var5 = select2("#", ...)
        while var5 > 0 do
            local select = select

            if select(var5, ...) ~= nil then
                break
            end

            var5 -= 1
        end

        if var5 ~= var2 then
            var3, var4 = captureSize(func1(...))
            var1 = { ... }
            var2 = var5
            return unpack(var3, 1, var4)
        end

        for i = 1, var2 do
            local select = select

            if select(i, ...) == var1[i] then
                continue
            end

            var3, var4 = captureSize(func1(...))
            var1 = { ... }
            break
        end

        return unpack(var3, 1, var4)
    end
end

return memoize

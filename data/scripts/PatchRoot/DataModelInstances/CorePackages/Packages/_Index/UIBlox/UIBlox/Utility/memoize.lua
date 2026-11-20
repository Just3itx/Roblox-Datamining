-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:41:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function captureSize(...)
    return { ... }, select("#", ...)
end

local function memoize(arg1)
    assert(type(arg1) == "function", "memoize requires a function to memoize")

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
            var1 = { ... }
            var2 = var5
            var3, var4 = captureSize(arg1(...))
            return unpack(var3, 1, var4)
        end

        for i = 1, var2 do
            local select = select

            if select(i, ...) == var1[i] then
                continue
            end

            var1 = { ... }
            var3, var4 = captureSize(arg1(...))
            break
        end

        return unpack(var3, 1, var4)
    end
end

return memoize

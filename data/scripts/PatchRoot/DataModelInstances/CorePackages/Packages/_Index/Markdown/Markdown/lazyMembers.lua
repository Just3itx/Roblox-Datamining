-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:21:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function lazyMembers(tbl1, tbl2)
    local function load(str1: string) -- Luacid: Inlined by compiler; 2 call sites recovered
        local var1 = tbl2[str1]()
        rawset(tbl1, str1, var1)
        return var1
    end

    setmetatable(tbl1, {
        __index = function(_, arg1)
            if tbl2[arg1] ~= nil then
                return load(arg1)
            end

            return nil
        end,
        __iter = function<T, U>(tbl3: {[T]: U})
            for value in tbl2 do
                if rawget(tbl3, value) == nil then
                    load(value)
                end
            end

            return next, tbl3
        end
    })
end

return lazyMembers

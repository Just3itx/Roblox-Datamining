-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:31:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(str1: string, arg1)
    assert(type(str1) == "string", "A name must be provided to create an Action")
    assert(type(arg1) == "function", "A function must be provided to create an Action")

    return (setmetatable({ name = str1 }, {
        __call = function(_, ...)
            local var1 = arg1(...)

            assert(type(var1) == "table", "An action must return a table")
            var1.type = str1

            return var1
        end
    }))
end

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:41:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}

function module.array(array2)
    return { type = "array", array = array2 }
end

function module.mutableSource(methods)
    return { type = "mutableSource", methods = methods }
end

module.utilities = {}

function module.utilities.createGetSimpleCursor(func1: (...any) -> (...any), func2: (...any) -> (...any))
    return function(num1: number)
        local var1 = func2()

        local function getWithCursor(num2: number): {after: () -> any, before: () -> any, value: any}?
            return if num2 < 1 or var1 < num2 then nil else {
                before = function()
                    return getWithCursor(num2 - 1)
                end,
                value = func1(num2),
                after = function()
                    return getWithCursor(num2 + 1)
                end
            }
        end

        return (getWithCursor(num1))
    end
end

return module

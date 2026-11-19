-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T11:11:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function makeActionCreator(str1: string, arg1)
    assert(type(str1) == "string", "Bad argument #1: Expected a string name for the action creator")

    assert(type(arg1) == "function", "Bad argument #2: Expected a function that creates action objects")

    return (setmetatable({ name = str1 }, {
        __call = function(_, ...)
            local var1 = arg1(...)

            assert(type(var1) == "table", "Invalid action: An action creator must return a table")

            var1.type = str1

            return var1
        end
    }))
end

return makeActionCreator

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T06:40:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function makeActionCreator(arg1, ...)
    local tbl1 = { ... }

    assert(type(arg1) == "string", "Bad argument #1 to makeActionCreator, expected string")

    local select2 = select

    for i = 1, select2("#", ...) do
        assert(typeof(select(i, ...)) == "string", "Bad argument to makeActionCreator, all arguments must be of type string")
    end

    return (setmetatable({ name = arg1 }, {
        __call = function(_, ...)
            local tbl2 = { type = arg1 }

            local select3 = select
            assert(select3("#", ...) == #tbl1, "Incorrect number of arguments provided to action creator " .. arg1)

            for i, value in ipairs(tbl1) do
                local select = select
                tbl2[value] = select(i, ...)
            end

            return tbl2
        end
    }))
end

return makeActionCreator

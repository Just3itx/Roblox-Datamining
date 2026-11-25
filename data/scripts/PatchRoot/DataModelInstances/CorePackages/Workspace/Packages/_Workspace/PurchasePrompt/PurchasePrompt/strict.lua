-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:40:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function invalidKey(arg1, arg2)
    local str1 = ("%q (%s) is not a valid member of %s"):format(tostring(arg2), typeof(arg2), tostring(arg1))

    error(str1, 2)
end

local function strict(arg1, arg2)
    return (setmetatable(arg1, {
        __index = invalidKey,
        __newindex = invalidKey,
        __tostring = function()
            return arg2
        end
    }))
end

return strict

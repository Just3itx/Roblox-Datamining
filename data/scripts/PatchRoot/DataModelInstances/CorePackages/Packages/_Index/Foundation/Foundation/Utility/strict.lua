-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:11:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function strict(arg1, str1: string?)
    local str2 = str1 or tostring(arg1)

    return (setmetatable(arg1, {
        __index = function(_, arg2)
            local str3 = ("%q (%s) is not a valid member of %s"):format(tostring(arg2), typeof(arg2), str2)

            error(str3, 2)
        end,
        __newindex = function(_, arg2)
            local str3 = ("%q (%s) is not a valid member of %s"):format(tostring(arg2), typeof(arg2), str2)

            error(str3, 2)
        end
    }))
end

return strict

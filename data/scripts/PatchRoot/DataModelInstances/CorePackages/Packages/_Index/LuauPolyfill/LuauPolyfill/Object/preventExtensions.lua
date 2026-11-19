-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T04:51:21Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local _types = require(scriptParentParent.types)

local function preventExtensions(arg1)
    local str1 = tostring(arg1)

    return (setmetatable(arg1, {
        __newindex = function(_, arg2, _)
            local str2 = ("%q (%s) is not a valid member of %s"):format(tostring(arg2), typeof(arg2), str1)

            error(str2, 2)
        end,
        __metatable = false
    }))
end

return preventExtensions

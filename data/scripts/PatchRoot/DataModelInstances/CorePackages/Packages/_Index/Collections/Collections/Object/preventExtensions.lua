-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T02:41:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local _ES7Types = require(scriptParentParentParent.ES7Types)

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

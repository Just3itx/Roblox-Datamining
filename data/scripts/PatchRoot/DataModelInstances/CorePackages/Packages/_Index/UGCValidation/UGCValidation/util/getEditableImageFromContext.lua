-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:21:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local _Types = require(scriptParentParent.util.Types)
local getEditableInstanceFromContext = require(scriptParentParent.util.getEditableInstanceFromContext)

return function(arg1, str1: string, arg2)
    local var1, var2 = getEditableInstanceFromContext(arg1, str1, arg2.editableImages, arg2)
    if not var1 then
        return false
    end

    return true, var2
end

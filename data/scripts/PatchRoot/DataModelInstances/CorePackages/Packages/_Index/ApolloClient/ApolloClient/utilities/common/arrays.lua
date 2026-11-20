-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T02:20:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent
local Array = require(scriptParentParentParentParent.LuauPolyfill).Array

function module.isNonEmptyArray(arg1)
    return (function()
        if Array.isArray(arg1) then
            return #arg1 > 0
        end
        return Array.isArray(arg1)
    end)()
end

return module

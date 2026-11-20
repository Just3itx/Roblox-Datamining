-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T02:21:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent

local Boolean = require(scriptParentParentParentParent.LuauPolyfill).Boolean

local NULL = { __value = "null" }

return {
    NULL = NULL,
    toJSBoolean = function(arg1)
        return Boolean.toJSBoolean(arg1) and arg1 ~= NULL
    end
}

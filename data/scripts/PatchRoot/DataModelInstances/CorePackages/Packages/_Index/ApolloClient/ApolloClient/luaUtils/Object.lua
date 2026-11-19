-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T05:30:58Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local LuauPolyfill = require(scriptParentParentParent.LuauPolyfill)

return (LuauPolyfill.Object.assign({}, LuauPolyfill.Object, {
    getPrototypeOf = function(arg1)
        local var1 = getmetatable(arg1)
        return var1 ~= false and var1 or nil
    end,
    create = function(arg1, arg2)
        return (setmetatable(arg2 == nil and {} or arg2, arg1))
    end
}))

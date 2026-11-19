-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T05:41:14Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local module = {}
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent
local Object = require(scriptParentParentParentParent.LuauPolyfill).Object
function module.compact(...)
    return Object.assign({}, ...)
end

return module

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:31:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local _Types = require(scriptParentParent.util.Types)
local tryYield = require(scriptParentParent.util.tryYield)

return function(callback: (...any) -> (...any), arg1)
    tryYield(arg1)
    return pcall(callback)
end

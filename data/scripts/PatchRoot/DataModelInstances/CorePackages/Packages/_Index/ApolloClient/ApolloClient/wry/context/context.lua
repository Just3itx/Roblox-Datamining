-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T02:30:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent

local LuauPolyfill = require(scriptParentParentParentParent.LuauPolyfill)

local module = {}

local Slot = require(script.Parent.slot).Slot
module.Slot = Slot

local bind = Slot.bind
local noContext = Slot.noContext
module.bind = bind
module.noContext = noContext

local setTimeout = LuauPolyfill.setTimeout
function module.setTimeout(func1: (...any) -> (...any), num1: number)
    return setTimeout(bind(func1), num1)
end

return module

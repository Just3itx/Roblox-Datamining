-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T05:30:52Z
-- Luau bytecode version: 9 | Luau type version: 3
local scriptParentParent = script.Parent.Parent
local Object = require(scriptParentParent.LuauPolyfill).Object

local makeIntervalImpl = require(script.makeIntervalImpl)

return Object.assign({ Object = require(script.Object) }, makeIntervalImpl(delay))

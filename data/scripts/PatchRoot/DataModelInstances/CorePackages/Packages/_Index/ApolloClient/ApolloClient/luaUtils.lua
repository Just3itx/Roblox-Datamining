-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T02:10:43Z
-- Luau bytecode version: 14 | Luau type version: 3
local scriptParentParent = script.Parent.Parent
local Object = require(scriptParentParent.LuauPolyfill).Object

local makeIntervalImpl = require(script.makeIntervalImpl)

return Object.assign({ Object = require(script.Object) }, makeIntervalImpl(delay))

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:21:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local scriptParentParent = script.Parent.Parent
local _LuauPolyfill = require(scriptParentParent.LuauPolyfill)

local _flowtypesRoblox = require(script.Parent["flowtypes.roblox"])

return { DiscreteEvent = 0, UserBlockingEvent = 1, ContinuousEvent = 2 }

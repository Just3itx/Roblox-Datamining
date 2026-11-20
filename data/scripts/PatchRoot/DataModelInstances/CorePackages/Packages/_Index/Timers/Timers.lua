-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T16:20:50Z
-- Luau bytecode version: 14 | Luau type version: 3
local scriptParent = script.Parent

local Object = require(scriptParent.Collections).Object

local makeTimerImpl = require(script.makeTimerImpl)
local makeIntervalImpl = require(script.makeIntervalImpl)

return Object.assign({}, makeTimerImpl(task.delay), makeIntervalImpl(task.delay))

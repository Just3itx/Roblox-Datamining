-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T11:01:39Z
-- Luau bytecode version: 14 | Luau type version: 3
local makeTimerImpl = require(script.makeTimerImpl)
local makeIntervalImpl = require(script.makeIntervalImpl)
return require(script.Parent.Object.assign)({}, makeTimerImpl(task.delay), makeIntervalImpl(task.delay))

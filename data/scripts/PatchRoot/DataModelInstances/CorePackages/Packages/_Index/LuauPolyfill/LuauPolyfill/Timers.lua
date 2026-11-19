-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T05:01:03Z
-- Luau bytecode version: 9 | Luau type version: 3
local makeTimerImpl = require(script.makeTimerImpl)
local makeIntervalImpl = require(script.makeIntervalImpl)
return require(script.Parent.Object.assign)({}, makeTimerImpl(task.delay), makeIntervalImpl(task.delay))

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:31:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local ReactFiberLane = require(script.Parent.ReactFiberLane)
local NoLanes = ReactFiberLane.NoLanes
local mergeLanes = ReactFiberLane.mergeLanes

local module = {}

function module.workInProgressRootSkippedLanes(arg1)
    if arg1 ~= nil then
        NoLanes = arg1
    end

    return NoLanes
end

function module.markSkippedUpdateLanes(arg1)
    NoLanes = mergeLanes(arg1, NoLanes)
end

return module

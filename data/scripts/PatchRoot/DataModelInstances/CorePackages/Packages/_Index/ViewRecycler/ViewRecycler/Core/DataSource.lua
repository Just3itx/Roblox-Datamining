-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:11:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ViewRecycler = script:FindFirstAncestor("ViewRecycler")

local _Types = require(ViewRecycler.Core.Types)

local ReconcileSnapshot = require(script.ReconcileSnapshot)
local ArrayDataSource = require(script.ArrayDataSource)
local ConcatDataSource = require(script.ConcatDataSource)
local DequeDataSource = require(script.DequeDataSource)
local MapDataSource = require(script.MapDataSource)
local ReverseDataSource = require(script.ReverseDataSource)
local RingBufferDataSource = require(script.RingBufferDataSource)
local SequenceDataSource = require(script.SequenceDataSource)

local module = {}

function module.snapshot(tbl1, func1: ((...any) -> (...any))?)
    return ArrayDataSource(tbl1, func1)
end

function module.sequence(tbl1, func1: ((...any) -> (...any))?)
    return SequenceDataSource(tbl1, func1)
end

function module.deque(tbl1, func1: ((...any) -> (...any))?)
    return DequeDataSource(tbl1, func1)
end

function module.ringBuffer(num1: number, tbl1, func1: ((...any) -> (...any))?)
    return RingBufferDataSource(num1, tbl1, func1)
end

function module.map(tbl1, func1: (...any) -> (...any))
    return MapDataSource(tbl1, func1)
end

function module.concat(...)
    return ConcatDataSource(...)
end

function module.reverse(tbl1)
    return ReverseDataSource(tbl1)
end

function module.reconcileSnapshot(arg1, tbl1, tbl2, func1: (...any) -> (...any))
    ReconcileSnapshot(arg1, tbl1, tbl2, func1)
end

return module

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:41:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RoduxCall = script:FindFirstAncestor("RoduxCall")
local RoduxCallParent = RoduxCall.Parent

local Status = require(RoduxCall.Enums).Status

local t = require(RoduxCallParent.t)

local module = {}

function module.new<T>(arg1: T): T
    assert(module.isValid(arg1))

    module.__index = module

    setmetatable(arg1, module)

    return arg1
end

function module.mock(arg1)
    arg1 = arg1 or {}

    return (module.new({
        status = arg1.status or Status.Active,
        callerId = arg1.callerId or 123,
        calleeId = arg1.calleeId or 456,
        placeId = arg1.placeId or 789,
        reservedServerAccessCode = arg1.reservedServerAccessCode or nil,
        callId = arg1.callId or nil,
        callerCombinedName = arg1.callerCombinedName or nil,
        calleeCombinedName = arg1.calleeCombinedName or nil,
        instanceId = arg1.instanceId or nil,
        createdUtc = arg1.createdUtc or 0,
        activeUtc = arg1.activeUtc or 0
    }))
end

function module.format(arg1)
    return (module.new({
        status = arg1.status,
        callerId = arg1.callerId,
        calleeId = arg1.calleeId,
        placeId = arg1.placeId,
        reservedServerAccessCode = arg1.reservedServerAccessCode,
        callId = arg1.callId,
        callerCombinedName = arg1.callerCombinedName,
        calleeCombinedName = arg1.calleeCombinedName,
        instanceId = arg1.instanceId,
        createdUtc = arg1.createdUtc,
        activeUtc = arg1.activeUtc
    }))
end
module.isValid = t.strictInterface({
    status = t.string,
    callerId = t.optional(t.number),
    calleeId = t.optional(t.number),
    placeId = t.optional(t.number),
    reservedServerAccessCode = t.optional(t.string),
    callId = t.optional(t.string),
    callerCombinedName = t.optional(t.string),
    calleeCombinedName = t.optional(t.string),
    instanceId = t.optional(t.string),
    createdUtc = t.optional(t.number),
    activeUtc = t.optional(t.number)
})

return module

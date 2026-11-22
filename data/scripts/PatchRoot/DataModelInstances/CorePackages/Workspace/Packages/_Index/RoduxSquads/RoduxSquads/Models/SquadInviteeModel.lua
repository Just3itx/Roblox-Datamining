-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T15:11:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RoduxSquadsParent = script:FindFirstAncestor("RoduxSquads").Parent

local t = require(RoduxSquadsParent.t)

local module = {}

function module.new<T>(arg1: T): T
    assert(module.isValid(arg1))

    module.__index = module

    setmetatable(arg1, module)

    return arg1
end

function module.mock(arg1)
    arg1 = arg1 or {}

    return (module.new({ invitedAtTimestampMs = arg1.invitedAtTimestampMs or 333333, userId = arg1.userId or 11111111 }))
end

function module.format(arg1)
    return (module.new({ invitedAtTimestampMs = arg1.invitedAtTimestampMs, userId = arg1.userId }))
end

module.isValid = t.interface({ invitedAtTimestampMs = t.number, userId = t.number })

return module

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T18:01:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SquadsCoreParent = script:FindFirstAncestor("SquadsCore").Parent

local t = require(SquadsCoreParent.t)

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
        createdAtTime = arg1.createdAtTime or "2025-07-02T18:00:00Z",
        initiatorId = arg1.initiatorId or 54321,
        parentChannelId = arg1.parentChannelId or "23456",
        scheduledGroupUpId = arg1.scheduledGroupUpId or 12345,
        startTime = arg1.startTime or "2500-07-02T18:00:00Z",
        subscribers = arg1.subscribers or {{ userId = 12345 }},
        title = arg1.title or "Cool Test Scheduled Party",
        updatedAtTime = arg1.updatedAtTime or "2025-07-02T18:00:00Z"
    }))
end

function module.format(arg1)
    return (module.new({
        createdAtTime = arg1.scheduledGroupUp.createdAtTime,
        initiatorId = arg1.scheduledGroupUp.initiatorId,
        parentChannelId = arg1.scheduledGroupUp.parentChannelId,
        scheduledGroupUpId = arg1.scheduledGroupUp.scheduledGroupUpId,
        startTime = arg1.scheduledGroupUp.startTime,
        subscribers = arg1.scheduledGroupUp.subscribers,
        title = arg1.scheduledGroupUp.title,
        updatedAtTime = arg1.scheduledGroupUp.updatedAtTime
    }))
end
module.isValid = t.strictInterface({
    createdAtTime = t.string,
    initiatorId = t.number,
    parentChannelId = t.string,
    scheduledGroupUpId = t.number,
    startTime = t.string,
    subscribers = t.array(t.strictInterface({ userId = t.number })),
    title = t.string,
    updatedAtTime = t.string
})

return module

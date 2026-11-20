-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:41:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RoduxCall = script:FindFirstAncestor("RoduxCall")
local RoduxCallParent = RoduxCall.Parent
local t = require(RoduxCallParent.t)
local Cryo = require(RoduxCallParent.Cryo)
local Enums = require(RoduxCall.Enums)

local module = {}

function module.new<T>(arg1: T): T
    assert(module.isValid(arg1))

    module.__index = module

    setmetatable(arg1, module)

    return arg1
end

function module.mock(arg1)
    arg1 = arg1 or {}

    return (module.new({ userId = arg1.userId or 12345, userPresenceType = arg1.userPresenceType or "Offline", lastLocation = "" }))
end

function module.format(arg1)
    return Cryo.Dictionary.join(arg1, { userPresenceType = Enums.PresenceType[arg1.userPresenceType] })
end

module.isValid = t.strictInterface({
    userId = t.number,
    userPresenceType = function(arg1): boolean
        return Enums.PresenceType[arg1] ~= nil
    end,
    lastLocation = t.string
})

return module

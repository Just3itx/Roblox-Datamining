-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:20:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RoduxPresence = script:FindFirstAncestor("RoduxPresence")
local RoduxPresenceParent = RoduxPresence.Parent
local Cryo = require(RoduxPresenceParent.Cryo)
local t = require(RoduxPresenceParent.t)

local Enums = require(RoduxPresence.Enums)

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
        gameId = arg1.gameId or "Game-OoooOO-Id",
        invisibleModeExpiry = arg1.invisibleModeExpiry or "2061-01-01T00:00:00Z",
        lastLocation = arg1.lastLocation or "LastLocation",
        lastOnline = arg1.lastOnline or "LastOnline-OOOoOO",
        placeId = arg1.placeId or 123,
        rootPlaceId = arg1.rootPlaceId or 234,
        universeId = arg1.universeId or 345,
        userId = arg1.userId or 456,
        userPresenceType = arg1.userPresenceType or 0
    }))
end

function module.format(arg1)
    return Cryo.Dictionary.join(arg1, { userPresenceType = Enums.PresenceType.fromRawValue(arg1.userPresenceType) })
end

module.isValid = t.interface({
    gameId = t.optional(t.string),
    invisibleModeExpiry = t.optional(t.string),
    lastLocation = t.string,
    lastOnline = t.string,
    placeId = t.optional(t.union(t.numberPositive, t.string)),
    rootPlaceId = t.optional(t.union(t.numberPositive, t.string)),
    universeId = t.optional(t.union(t.numberPositive, t.string)),
    userId = t.union(t.numberPositive, t.string),
    userPresenceType = function(arg1): boolean
        return Enums.PresenceType.fromRawValue(arg1) ~= nil
    end
})

return module

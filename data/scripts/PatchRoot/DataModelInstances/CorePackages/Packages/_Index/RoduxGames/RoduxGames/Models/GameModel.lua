-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:01:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RoduxGamesParent = script:FindFirstAncestor("RoduxGames").Parent
local t = require(RoduxGamesParent.t)
local CreatorModel = require(script.Parent.CreatorModel)

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
        experienceId = arg1.experienceId or "experienceId",
        name = arg1.name or "name",
        description = arg1.description or "description",
        price = arg1.price or 666,
        rootPlaceId = arg1.rootPlaceId or "rootPlaceId",
        creator = CreatorModel.mock(arg1.creator),
        maxPlayers = arg1.maxPlayers or 6,
        playing = arg1.playing or 1000
    }))
end

function module.format(arg1)
    return (module.new({
        experienceId = tostring(arg1.id),
        name = arg1.name,
        description = arg1.description or "",
        price = arg1.price or 0,
        rootPlaceId = tostring(arg1.rootPlaceId),
        creator = CreatorModel.format(arg1.creator),
        maxPlayers = arg1.maxPlayers,
        playing = arg1.playing
    }))
end
module.isValid = t.strictInterface({
    experienceId = t.string,
    name = t.string,
    description = t.string,
    price = t.number,
    rootPlaceId = t.string,
    creator = CreatorModel.isValid,
    maxPlayers = t.number,
    playing = t.number
})

return module

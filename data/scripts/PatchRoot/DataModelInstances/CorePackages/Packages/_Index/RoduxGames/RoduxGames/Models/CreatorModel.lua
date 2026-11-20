-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:01:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RoduxGames = script:FindFirstAncestor("RoduxGames")
local RoduxGamesParent = RoduxGames.Parent

local t = require(RoduxGamesParent.t)
local CreatorType = require(RoduxGames.Enums).CreatorType

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
        creatorId = arg1.creatorId or "creatorId",
        creatorName = arg1.creatorName or "creatorName",
        creatorType = arg1.creatorType or CreatorType.User
    }))
end

function module.format(arg1)
    return (module.new(
        {
            creatorId = tostring(arg1.id),
            creatorName = arg1.name,
            creatorType = CreatorType.fromRawValue(arg1.type)
        }
    ))
end

module.isValid = t.strictInterface({ creatorId = t.string, creatorName = t.string, creatorType = t.userdata })

return module

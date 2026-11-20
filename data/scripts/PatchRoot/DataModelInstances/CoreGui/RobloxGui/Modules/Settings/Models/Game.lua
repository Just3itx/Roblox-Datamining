-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:10:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}

function module.new()
    return {}
end

function module.fromGameCache(arg1)
    local module2 = module.new()
    module2.universeId = arg1.UniverseId
    module2.placeId = arg1.PlaceId
    module2.name = arg1.Name
    module2.playerCount = arg1.PlayerCount
    module2.imageToken = arg1.ImageToken
    module2.totalUpVotes = arg1.VoteData.UpVotes
    module2.totalDownVotes = arg1.VoteData.DownVotes
    return module2
end

function module.fromJsonData(arg1)
    local module2 = module.new()
    module2.universeId = arg1.universeId
    module2.placeId = arg1.placeId
    module2.name = arg1.name
    module2.playerCount = arg1.playerCount
    module2.imageToken = arg1.imageToken
    module2.totalUpVotes = arg1.totalUpVotes
    module2.totalDownVotes = arg1.totalDownVotes
    return module2
end

return module

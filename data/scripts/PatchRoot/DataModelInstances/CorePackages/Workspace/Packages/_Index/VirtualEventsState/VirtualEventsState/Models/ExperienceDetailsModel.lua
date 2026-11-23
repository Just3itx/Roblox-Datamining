-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T04:30:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}

function module.mock(id: number?)
    return {
        id = id or -1,
        rootPlaceId = -2,
        name = "Experience name",
        description = "Experience description",
        sourceName = "Source name",
        sourceDescription = "Source description",
        creator = {
            id = -3,
            name = "CreatorName",
            type = "User",
            isRNVAccount = false,
            hasVerifiedBadge = false
        },
        price = 0,
        allowedGearGenres = {},
        allowedGearCategories = {},
        isGenreEnforced = false,
        copyingAllowed = false,
        playing = 0,
        visits = 0,
        maxPlayers = 10,
        created = DateTime.now():ToIsoDate(),
        updated = DateTime.now():ToIsoDate(),
        studioAccessToApisAllowed = false,
        universeAvatarType = "MorphR6",
        genre = "",
        isAllGenre = false,
        isFavoritedByUser = false,
        favoritedCount = 0
    }
end

return module

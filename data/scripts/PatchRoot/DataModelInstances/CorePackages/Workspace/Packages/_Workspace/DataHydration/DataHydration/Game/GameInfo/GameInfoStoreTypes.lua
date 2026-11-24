-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:20:51Z
-- Luau bytecode version: 14 | Luau type version: 3
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local _DataHydrationTypes = require(DataHydration.DataHydrationTypes)
local t = require(DataHydrationParent.t)

return {
    gameInfoResponseValidator = t.interface({
        data = t.array(
            t.interface({
                id = t.number,
                rootPlaceId = t.number,
                name = t.optional(t.string),
                description = t.optional(t.string),
                creator = t.optional(
                    t.interface({ id = t.optional(t.number), name = t.optional(t.string), hasVerifiedBadge = t.optional(t.boolean) })
                ),
                visits = t.optional(t.number),
                playerCount = t.optional(t.number),
                totalUpVotes = t.optional(t.string),
                totalDownVotes = t.optional(t.string)
            })
        )
    })
}

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:50:45Z
-- Luau bytecode version: 14 | Luau type version: 3
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local _DataHydrationTypes = require(DataHydration.DataHydrationTypes)
local _Signals = require(DataHydrationParent.Signals)

return {
    EventStatus = {
        Upcoming = "Upcoming",
        UpcomingImminent = "UpcomingImminent",
        Ongoing = "Ongoing",
        ElapsedImminent = "ElapsedImminent",
        Elapsed = "Elapsed"
    },
    EventRsvpTypes = { Going = "going", NotGoing = "notGoing", Maybe = "maybe" }
}

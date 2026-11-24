-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:50:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local Http = require(DataHydrationParent.Http)
local UrlBuilder = require(DataHydrationParent.UrlBuilder).UrlBuilder

local Url = Http.Url

return {
    buildRsvpUpdateUrl = function(id: string)
        return UrlBuilder.new({ base = Url.APIS_URL, path = "virtual-events/v1/virtual-events/{id}/rsvps" })({ id = id })
    end,
    RSVP_UPDATE_URL = UrlBuilder.new({ base = Url.APIS_URL, path = "virtual-events/v1/virtual-events/rsvps" })
}

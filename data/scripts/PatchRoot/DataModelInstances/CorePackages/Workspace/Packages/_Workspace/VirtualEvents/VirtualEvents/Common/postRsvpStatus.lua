-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:01:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VirtualEvents = script:FindFirstAncestor("VirtualEvents")

local HttpService = game:GetService("HttpService")

local VirtualEventsParent = VirtualEvents.Parent
local UrlBuilder = require(VirtualEventsParent.UrlBuilder).UrlBuilder

return function(arg1, id, rsvpStatus)
    local string2 = UrlBuilder.fromString("apis:virtual-events/v1/virtual-events/{id}/rsvps")

    local postBody = HttpService:JSONEncode({ rsvpStatus = rsvpStatus })

    return arg1(string2({ id = id }), "POST", { postBody = postBody }):andThen(function(arg3)
        return arg3.responseBody
    end)
end

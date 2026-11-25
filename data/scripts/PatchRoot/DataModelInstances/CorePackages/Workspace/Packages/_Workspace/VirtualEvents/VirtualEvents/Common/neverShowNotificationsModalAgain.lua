-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:00:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VirtualEvents = script:FindFirstAncestor("VirtualEvents")

local HttpService = game:GetService("HttpService")

local VirtualEventsParent = VirtualEvents.Parent
local UrlBuilder = require(VirtualEventsParent.UrlBuilder).UrlBuilder

return function(arg1)
    return arg1(
        UrlBuilder.fromString("apis:virtual-events/v1/notifications/modal-history")(),
        "POST",
        {
            postBody = HttpService:JSONEncode({})
        }
    )
end

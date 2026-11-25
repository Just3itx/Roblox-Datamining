-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T21:51:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VirtualEvents = script:FindFirstAncestor("VirtualEvents")

local HttpService = game:GetService("HttpService")

local VirtualEventsParent = VirtualEvents.Parent
local UrlBuilder = require(VirtualEventsParent.UrlBuilder).UrlBuilder

return function(arg1)
    local string2 = UrlBuilder.fromString("apis:virtual-events/v1/notifications/preferences")

    local postBody = HttpService:JSONEncode({ isEnabled = true })

    return arg1(string2(), "POST", { postBody = postBody })
end

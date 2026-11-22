-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T08:20:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local NetworkingVirtualEvents = script:FindFirstAncestor("NetworkingVirtualEvents")

local Http = require(NetworkingVirtualEvents.Parent.Http)
local _types = require(NetworkingVirtualEvents.types)

return function(arg1)
    return (arg1.POST(script.Name, function(arg2, str1: string, rsvpStatus)
        return (arg2(Http.Url.APIS_URL):path("virtual-events"):path("v1"):path("virtual-events"):id(str1):path("rsvps"):body(
            { rsvpStatus = rsvpStatus }
        ))
    end))
end

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T08:11:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local NetworkingVirtualEvents = script:FindFirstAncestor("NetworkingVirtualEvents")

local createCreateVirtualEvent = require(NetworkingVirtualEvents.requests.createCreateVirtualEvent)
local createUpdateVirtualEvent = require(NetworkingVirtualEvents.requests.createUpdateVirtualEvent)
local createDeleteVirtualEvent = require(NetworkingVirtualEvents.requests.createDeleteVirtualEvent)
local createGetVirtualEvent = require(NetworkingVirtualEvents.requests.createGetVirtualEvent)
local createGetMyVirtualEvents = require(NetworkingVirtualEvents.requests.createGetMyVirtualEvents)
local createGetActiveVirtualEvents = require(NetworkingVirtualEvents.requests.createGetActiveVirtualEvents)
local createGetVirtualEventRsvps = require(NetworkingVirtualEvents.requests.createGetVirtualEventRsvps)
local createUpdateMyRsvpStatus = require(NetworkingVirtualEvents.requests.createUpdateMyRsvpStatus)
local createGetVirtualEventRsvpCounts = require(NetworkingVirtualEvents.requests.createGetVirtualEventRsvpCounts)
local _types = require(NetworkingVirtualEvents.types)

return function(arg1)
    local roduxNetworking = arg1.roduxNetworking

    return {
        CreateVirtualEvent = createCreateVirtualEvent(roduxNetworking),
        UpdateVirtualEvent = createUpdateVirtualEvent(roduxNetworking),
        DeleteVirtualEvent = createDeleteVirtualEvent(roduxNetworking),
        GetVirtualEvent = createGetVirtualEvent(roduxNetworking),
        GetMyVirtualEvents = createGetMyVirtualEvents(roduxNetworking),
        GetActiveVirtualEvents = createGetActiveVirtualEvents(roduxNetworking),
        GetVirtualEventRsvps = createGetVirtualEventRsvps(roduxNetworking),
        UpdateMyRsvpStatus = createUpdateMyRsvpStatus(roduxNetworking),
        GetVirtualEventRsvpCounts = createGetVirtualEventRsvpCounts(roduxNetworking),
        VirtualEventModel = require(NetworkingVirtualEvents.models.VirtualEventModel),
        createMockVirtualEventResponse = require(NetworkingVirtualEvents.createMockVirtualEventResponse)
    }
end

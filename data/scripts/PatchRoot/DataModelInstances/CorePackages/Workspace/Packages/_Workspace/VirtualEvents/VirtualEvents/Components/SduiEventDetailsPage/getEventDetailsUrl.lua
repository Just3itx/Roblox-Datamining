-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:10:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VirtualEventsParent = script:FindFirstAncestor("VirtualEvents").Parent

local UrlBuilder = require(VirtualEventsParent.UrlBuilder).UrlBuilder
local Url = require(VirtualEventsParent.Http).Url
local SduiCapabilities = require(VirtualEventsParent.SduiSharedUtilities).SduiCapabilities
local FFlagSduiCapabilityBindings = require(VirtualEventsParent.SharedFlags).FFlagSduiCapabilityBindings

local urlBuilder = UrlBuilder.new({ base = Url.APIS_URL, path = "virtual-events/v1beta1/event-details-page" })

local function getEventDetailsUrl(eventId: string)
    local tbl1 = { eventId = eventId }

    if FFlagSduiCapabilityBindings then
        local _serviceContractsProto = require(VirtualEventsParent.ServiceContractsProto)

        SduiCapabilities.addToQueryParams(tbl1, { "CAPABILITY_SUPPORTS_EVENT_RSVP_FACE_PILE" })
    end

    return UrlBuilder.addQueryString(urlBuilder(), tbl1)
end

return getEventDetailsUrl

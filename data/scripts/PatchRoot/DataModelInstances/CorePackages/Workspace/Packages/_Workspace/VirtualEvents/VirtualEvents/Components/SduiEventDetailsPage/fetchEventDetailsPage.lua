-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:10:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VirtualEventsParent = script:FindFirstAncestor("VirtualEvents").Parent

local AppPage = require(VirtualEventsParent.RobloxAppEnums).AppPage
local SduiSharedUtilities = require(VirtualEventsParent.SduiSharedUtilities)
local SduiResponseType = SduiSharedUtilities.SduiResponseType
local getSduiApiStore = SduiSharedUtilities.getSduiApiStore
local getEventDetailsUrl = require(script.Parent.getEventDetailsUrl)
local getEventDetailsPageKey = require(script.Parent.getEventDetailsPageKey)

local function fetchEventDetailsPage(str1: string, loadTimer)
    local url = getEventDetailsUrl(str1)

    local experienceEventDetailsPage = require(VirtualEventsParent.ServiceContractsProto).apppageplatform.experienceevents.experience_event_details_page

    getSduiApiStore().fetchIfNeeded({
        responseType = SduiResponseType.Protobuf,
        url = url,
        surfaceKey = AppPage.EventDetails,
        configKey = getEventDetailsPageKey(str1),
        loadTimer = loadTimer,
        apiProto = experienceEventDetailsPage.ExperienceEventDetailsPageResponse
    })
end

return fetchEventDetailsPage

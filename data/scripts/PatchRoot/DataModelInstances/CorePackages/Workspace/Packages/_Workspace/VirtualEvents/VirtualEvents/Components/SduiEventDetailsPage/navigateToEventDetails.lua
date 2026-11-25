-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:10:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VirtualEventsParent = script:FindFirstAncestor("VirtualEvents").Parent

local AppPage = require(VirtualEventsParent.RobloxAppEnums).AppPage
local SduiLoadTimer = require(VirtualEventsParent.SduiSharedUtilities).SduiLoadTimer
local fetchEventDetailsPage = require(script.Parent.fetchEventDetailsPage)

local function navigateToEventDetails(tbl1, eventId: string, universeId: string?)
    local pageTimer = SduiLoadTimer.createLoadTimer(AppPage.EventDetails)
    pageTimer.start("navigate")

    fetchEventDetailsPage(eventId, pageTimer)

    tbl1.navigate(
        AppPage.EventDetails,
        {
            extraProps = { eventId = eventId, pageTimer = pageTimer, universeId = universeId }
        }
    )
end

return navigateToEventDetails

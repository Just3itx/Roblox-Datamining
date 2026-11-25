-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T21:51:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local script2 = script
local VirtualEventsState = require(script2.Parent.VirtualEventsState)

local EventNotificationsModal = require(script.Components.EventNotificationsModal)

return {
    AnalyticsEvent = VirtualEventsState.enums.AnalyticsEvent,
    requests = require(script.requests),
    EventDetailsPageLoader = require(script.Components.EventDetailsPageLoader),
    SduiEventDetailsPage = require(script.Components.SduiEventDetailsPage.SduiEventDetailsPage),
    ShareEventModal = require(script.Components.ShareEventModal),
    EventNotificationsModal = EventNotificationsModal,
    EventsListCarousel = require(script.Components.EventsListCarousel.EventsListCarousel),
    EventsInExperienceApp = require(script.EventsInExperienceApp),
    fireEventDetailsPageVisit = require(script.Analytics.fireEventDetailsPageVisit),
    fireShareVirtualEventIconClicked = require(script.Analytics.fireShareVirtualEventIconClicked),
    fireVirtualEventJoined = require(script.Analytics.fireVirtualEventJoined),
    fireVirtualEventLinkCopied = require(script.Analytics.fireVirtualEventLinkCopied),
    fireVirtualEventRSVP = require(script.Analytics.fireVirtualEventRSVP),
    fireEventNotificationEnabled = require(script.Analytics.fireEventNotificationEnabled),
    enablePushNotifications = require(script.Common.enablePushNotifications),
    neverShowNotificationsModalAgain = require(script.Common.neverShowNotificationsModalAgain),
    fireVirtualEventImpression = require(script.Analytics.fireVirtualEventImpression),
    navigateToEventDetails = require(script.Components.SduiEventDetailsPage.navigateToEventDetails),
    ["jest.config"] = script["jest.config"]
}

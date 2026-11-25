-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:11:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local VirtualEvents = script:FindFirstAncestor("VirtualEvents")

local gql = require(VirtualEvents.Parent.ApolloClient).gql

return {
    GET_VIRTUAL_EVENT = gql(require(script.Parent.GetVirtualEvent)),
    UPDATE_RSVP_STATUS = gql(require(script.Parent.UpdateRsvpStatus)),
    NEVER_SHOW_NOTIFICATIONS_MODAL_AGAIN = gql(require(script.Parent.NeverShowNotificationModalAgain)),
    ENABLE_PUSH_NOTIFICATIONS = gql(require(script.Parent.EnablePushNotifications)),
    GET_EVENTS_FOR_EXPERIENCE = gql(require(script.Parent.VirtualEventsForExperience))
}

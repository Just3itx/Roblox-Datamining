-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T17:01:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GraphQLServer = script:FindFirstAncestor("GraphQLServer")

local VirtualEventConnector = require(GraphQLServer.graphql.connectors.VirtualEventConnector)
local findVirtualEventById = VirtualEventConnector.findVirtualEventById
local findVirtualEventsByUniverseId = VirtualEventConnector.findVirtualEventsByUniverseId
local findRsvpCountersByVirtualEventId = VirtualEventConnector.findRsvpCountersByVirtualEventId
local findRsvpsByVirtualEventId = VirtualEventConnector.findRsvpsByVirtualEventId
local updateRsvpStatus = VirtualEventConnector.updateRsvpStatus
local neverShowNotificationModalAgain = VirtualEventConnector.neverShowNotificationModalAgain
local enablePushNotifications = VirtualEventConnector.enablePushNotifications
local ExperienceConnector = require(GraphQLServer.graphql.connectors.ExperienceConnector)
local findExperienceDetailsByUniverseId = ExperienceConnector.findExperienceDetailsByUniverseId
local findExperienceMediaByUniverseId = ExperienceConnector.findExperienceMediaByUniverseId
local _generatedTypes = require(GraphQLServer.graphql.generatedTypes)

return {
    VirtualEventMutations = {
        neverShowNotificationModalAgain = function(_, _, arg1)
            return neverShowNotificationModalAgain(arg1.fetchImpl)
        end,
        enablePushNotifications = function(_, _, arg1)
            return enablePushNotifications(arg1.fetchImpl)
        end
    },
    VirtualEvent = {
        experienceDetails = function(arg1, _, arg2)
            return findExperienceDetailsByUniverseId(tostring(arg1.universeId), arg2.fetchImpl)
        end,
        media = function(arg1, _, arg2)
            return findExperienceMediaByUniverseId(tostring(arg1.universeId), arg2.fetchImpl)
        end,
        rsvpCounters = function(arg1, _, arg2)
            return findRsvpCountersByVirtualEventId(arg1.id, arg2.fetchImpl)
        end,
        rsvps = function(arg1, _, arg2)
            return findRsvpsByVirtualEventId(arg1.id, arg2.fetchImpl)
        end
    },
    Mutation = {
        virtualEvents = function()
            return {}
        end,
        virtualEventRsvp = function(_, arg1, arg2)
            return updateRsvpStatus(arg1.id, arg1.rsvpStatus, arg2.fetchImpl)
        end
    },
    Query = {
        virtualEvent = function(_, arg1, arg2)
            return findVirtualEventById(arg1.id, arg2.fetchImpl)
        end,
        virtualEventsByUniverseId = function(_, arg1, arg2)
            return findVirtualEventsByUniverseId(arg1.universeId, arg1.options, arg2.fetchImpl)
        end
    }
}

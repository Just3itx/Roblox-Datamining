-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T16:51:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GraphQLServer = script:FindFirstAncestor("GraphQLServer")

local HttpService = game:GetService("HttpService")

local _LuauPolyfill = require(GraphQLServer.Parent.LuauPolyfill)

local _generatedTypes = require(GraphQLServer.graphql.generatedTypes)

local Promise = require(GraphQLServer.Parent.Promise)
local GraphQLError = require(GraphQLServer.Parent.GraphQL).GraphQLError
local Fetch = require(GraphQLServer.Parent.Fetch)
local fetch = Fetch.fetch

local Response = Fetch.Response
local UrlBuilder = require(GraphQLServer.Parent.UrlBuilder).UrlBuilder

local module = {}

local string2 = UrlBuilder.fromString("apis:virtual-events/v1/virtual-events/{id}")
local string3 = UrlBuilder.fromString("apis:virtual-events/v1/virtual-events/{id}/rsvps")
local string4 = UrlBuilder.fromString("apis:virtual-events/v1/virtual-events/{id}/rsvps/counters")
local string5 = UrlBuilder.fromString(
    "apis:virtual-events/v1/universes/{id}/virtual-events?cursor={cursor}&limit={limit}&fromUtc={fromUtc}"
)
local string6 = UrlBuilder.fromString("apis:virtual-events/v1/notifications/modal-history")
local string7 = UrlBuilder.fromString("apis:virtual-events/v1/notifications/preferences")

function module.findVirtualEventById(id: string, arg1)
    local var1 = arg1 or fetch

    return Promise.new(function(callback, callback2)
        local var2 = string2({ id = id })
        local var3 = var1(var2, { method = "GET" }):catch(function()
            return Response.error()
        end):expect()

        if not var3.ok then
            callback2(GraphQLError.new(string.format("Failed to find VirtualEvent matching id: %s.", id)))
            return
        end

        local var4 = var3:json():catch(function()
            return nil
        end):expect()

        if not var4 then
            callback2(
                GraphQLError.new(string.format("Failed to decode HTTP response as JSON for VirtualEvent matching id: %s.", id))
            )

            return
        end

        callback(var4)
    end)
end

function module.findVirtualEventsByUniverseId(id: number, arg1, arg2)
    local var1 = arg2 or fetch

    return Promise.new(function(callback, callback2)
        local var2 = string5({
            id = id,
            cursor = if arg1 and arg1.cursor then arg1.cursor else "",
            limit = if arg1 and arg1.limit then arg1.limit else 25,
            fromUtc = if arg1 and arg1.fromUtc then arg1.fromUtc else ""
        })

        local var3 = var1(var2, { method = "GET" }):catch(function()
            return Response.error()
        end):expect()

        if not var3.ok then
            callback2(GraphQLError.new(string.format("Failed to find experience matching universeId: %i", id)))
            return
        end

        local var4 = var3:json():catch(function()
            return nil
        end):expect()

        if not var4 then
            callback2(
                GraphQLError.new(string.format("Failed to decode HTTP response as JSON for experience matching universeId: %i", id))
            )

            return
        end

        callback({ cursor = var4.nextPageCursor, virtualEvents = var4.data })
    end)
end

function module.findRsvpsByVirtualEventId(id: string, arg1)
    local var1 = arg1 or fetch

    return Promise.new(function(callback, callback2)
        local var2 = string3({ id = id })
        local var3 = var1(var2, { method = "GET" }):catch(function()
            return Response.error()
        end):expect()

        if not var3.ok then
            callback2(GraphQLError.new(string.format("Failed to find RSVPs matching VirtualEvent id: %s.", id)))

            return
        end

        local var4 = var3:json():catch(function()
            return nil
        end):expect()

        if not var4 then
            callback2(
                GraphQLError.new(string.format("Failed to decode HTTP response as JSON for RSVPs matching VirtualEvent id: %s.", id))
            )

            return
        end

        callback(var4.data)
    end)
end

function module.findRsvpCountersByVirtualEventId(id: string, arg1)
    local var1 = arg1 or fetch

    return Promise.new(function(callback, callback2)
        local var2 = string4({ id = id })
        local var3 = var1(var2, { method = "GET" }):catch(function()
            return Response.error()
        end):expect()

        if not var3.ok then
            callback2(GraphQLError.new(string.format("Failed to find RSVP counters matching VirtualEvent id: %s.", id)))

            return
        end

        local var4 = var3:json():catch(function()
            return nil
        end):expect()

        if not var4 then
            callback2(
                GraphQLError.new(
                    string.format("Failed to decode HTTP response as JSON for RSVP counters matching VirtualEvent id: %s.", id)
                )
            )

            return
        end

        callback(var4.counters)
    end)
end

function module.updateRsvpStatus(id: string, rsvpStatus, arg1)
    local var1 = arg1 or fetch

    return Promise.new(function(callback, callback2)
        local var2 = string3({ id = id })
        local var3 = var1(var2, {
            method = "POST",
            body = HttpService:JSONEncode({ rsvpStatus = rsvpStatus }),
            headers = { ["Content-Type"] = "application/json", Accept = "application/json" }
        }):catch(
            function()
                return Response.error()
            end
        ):expect()

        if not var3.ok then
            callback2(GraphQLError.new(string.format("Failed to set RSVP status matching VirtualEvent id: %s.", id)))

            return
        end

        local var4 = var3:json():catch(function()
            return nil
        end):expect()

        if not var4 then
            callback2(
                GraphQLError.new(
                    string.format("Failed to decode HTTP response as JSON for RSVP status matching VirtualEvent id: %s.", id)
                )
            )

            return
        end

        callback({
            shouldSeeNotificationsUpsellModal = var4.shouldSeeNotificationsUpsellModal,
            virtualEvent = {
                id = id,
                userRsvpStatus = var4.rsvpStatus
            }
        })
    end)
end

function module.neverShowNotificationModalAgain(arg1)
    local var1 = arg1 or fetch

    return Promise.new(function(callback, callback2)
        local var2 = string6()
        if not var1(var2, { method = "POST" }):catch(function()
            return Response.error()
        end):expect().ok then
            callback2(GraphQLError.new("Failed to update modal history"))
            return
        end

        callback(true)
    end)
end

function module.enablePushNotifications(arg1)
    local var1 = arg1 or fetch

    return Promise.new(function(callback, callback2)
        local var2 = string7()

        if not var1(var2, {
            method = "POST",
            body = HttpService:JSONEncode({ isEnabled = true }),
            headers = { ["Content-Type"] = "application/json", Accept = "application/json" }
        }):catch(
            function()
                return Response.error()
            end
        ):expect().ok then
            callback2(GraphQLError.new("Failed to update notification preferences"))
            return
        end

        callback(true)
    end)
end

return module

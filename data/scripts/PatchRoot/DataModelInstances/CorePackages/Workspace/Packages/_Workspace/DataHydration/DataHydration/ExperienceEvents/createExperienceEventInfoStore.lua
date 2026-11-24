-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:50:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local Promise = require(DataHydrationParent.Promise)

local createDataCache = require(DataHydration.createDataCache)
local _DataHydrationTypes = require(DataHydration.DataHydrationTypes)
local ExperienceEventTypes = require(script.Parent.ExperienceEventTypes)
local ExperienceEventDerivedFields = require(script.Parent.ExperienceEventDerivedFields)
local ExperienceEventsUrlBuilder = require(script.Parent.ExperienceEventsUrlBuilder)
local createDataResolver = require(DataHydration.createDataResolver)
local DiscoveryUtils = require(DataHydrationParent.DiscoveryUtils)
local DiscoveryEventErrorLogger = DiscoveryUtils.DiscoveryEventErrorLogger
local logResponseError = DiscoveryUtils.logResponseError

local updateEventRsvp = require(script.Parent.updateEventRsvp)

local function createExperienceEventInfoStore()
    local cache = createDataCache()
    local dataResolver = createDataResolver({
        cache = cache,
        supportsMultiGet = false,
        fetchFn = function(_)
            return Promise.resolve({})
        end
    })

    return {
        getExperienceEventInfo = dataResolver.getCachedItem,
        getExperienceEventInfos = dataResolver.getCachedItems,
        updateExperienceEventInfo = cache.updateItem,
        updateExperienceEventInfos = function(tbl1)
            for value, value2 in tbl1 do
                tbl1[value] = ExperienceEventDerivedFields.enrichWithTimestamps(value2)
            end
            cache.updateItems(tbl1)
        end,
        calculateDerivedField = ExperienceEventDerivedFields.calculateDerivedField,
        patchRsvpStatus = function(eventId: string, bool1: boolean)
            local var1 = dataResolver.getCachedItem(eventId).data()
            local var2 = if bool1 then ExperienceEventTypes.EventRsvpTypes.Going else ExperienceEventTypes.EventRsvpTypes.NotGoing

            return (updateEventRsvp(eventId, var2):andThen(function(arg1)
                if var1 then
                    local rsvpCount = var1.rsvpCount or 0
                    local tbl1 = {
                        id = var1.id,
                        title = var1.title,
                        subtitle = var1.subtitle,
                        eventStart = var1.eventStart,
                        eventEnd = var1.eventEnd,
                        userRsvp = bool1,
                        mediaAssetId = var1.mediaAssetId,
                        description = var1.description,
                        rsvpCount = rsvpCount + (if bool1 then 1 else -1)
                    }
                    cache.updateItem(eventId, tbl1)
                end
                return arg1 and arg1.responseBody
            end):catch(function(arg1)
                if var1 then
                    cache.updateItem(eventId, var1)
                end

                local statusCode = if type(arg1) == "table" and arg1.StatusCode then arg1.StatusCode else nil

                if type(arg1) == "table" and arg1.StatusMessage then
                    arg1 = arg1.StatusMessage
                elseif type(arg1) ~= "string" then
                    arg1 = nil
                end
                logResponseError(ExperienceEventsUrlBuilder.RSVP_UPDATE_URL, { StatusCode = statusCode })

                DiscoveryEventErrorLogger.reportError(
                    "patchRsvpStatus",
                    "Error updating event RSVP",
                    {
                        eventId = eventId,
                        isRsvpGoing = bool1,
                        statusCode = statusCode,
                        statusMessage = arg1
                    }
                )
            end))
        end,
        clear = dataResolver.clear,
        dispose = dataResolver.dispose
    }
end

return createExperienceEventInfoStore

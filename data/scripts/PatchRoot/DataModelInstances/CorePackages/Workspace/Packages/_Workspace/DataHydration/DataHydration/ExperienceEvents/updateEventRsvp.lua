-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:50:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local HttpService = game:GetService("HttpService")
local HttpRequest = require(DataHydrationParent.HttpRequest)
local Promise = require(DataHydrationParent.Promise)
local getLocalPlayerUserId = require(DataHydration.DataHydrationUtils).getLocalPlayerUserId

local ExperienceEventsUrlBuilder = require(script.Parent.ExperienceEventsUrlBuilder)

local function updateEventRsvp(str1: string, rsvpStatus: string)
    local localPlayerUserId = getLocalPlayerUserId()
    if not localPlayerUserId or localPlayerUserId <= 0 then
        return Promise.reject({
            ClientError = "Missing or invalid local player ID",
            message = "Cannot RSVP to event: missing or invalid local player ID"
        })
    end

    local rsvpUpdateUrl = ExperienceEventsUrlBuilder.buildRsvpUpdateUrl(tostring(str1))

    return HttpRequest.config({
        requestFunction = function(str2: string, str3: string, arg1)
            return HttpRequest.requestFunctions.RequestInternal(str2, str3, arg1)
        end
    })(rsvpUpdateUrl, "POST", {
        postBody = HttpService:JSONEncode({ rsvpStatus = rsvpStatus })
    })
end
return updateEventRsvp

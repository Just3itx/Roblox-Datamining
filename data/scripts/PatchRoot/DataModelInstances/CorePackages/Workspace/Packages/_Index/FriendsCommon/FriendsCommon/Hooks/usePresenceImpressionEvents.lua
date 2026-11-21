-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T14:41:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsCommonParent = script:FindFirstAncestor("FriendsCommon").Parent

local React = require(FriendsCommonParent.React)
local Cryo = require(FriendsCommonParent.Cryo)

local SocialLuaAnalytics = require(FriendsCommonParent.SocialLuaAnalytics)
local LoggingProtocol = require(FriendsCommonParent.LoggingProtocol)

local throttlingThousandths = game:DefineFastInt("PresenceImpressionLoggingThrottlePerMyriad", 10000)

local FFlagFriendsSignalMigrationTelemetry = require(FriendsCommonParent.SharedFlags).FFlagFriendsSignalMigrationTelemetry

local emitter = SocialLuaAnalytics.Telemetry.createEmitter({
    telemetryImpl = LoggingProtocol.default,
    defaultTelemetryConfig = {
        throttlingThousandths = throttlingThousandths,
        links = "https://docs.google.com/document/d/1uj9vb188k-wC2u3U3-UX3fm7xLffIbbvF7BDq3hs2Ak"
    },
    getSharedInfo = function()
        return {}
    end
})

local telemetry = SocialLuaAnalytics.Telemetry.new({
    name = "PresenceImpression",
    description = "Emitted when the presence status of a friend updates on the client",
    lastUpdated = { 2025, 4, 10 },
    backendsList = {{
        type = "EventIngest",
        format = function<T>(tbl1, _): T
            return tbl1
        end
    }}
})

function areEqual(arg1, arg2): boolean
    return arg1.userPresenceType == arg2.userPresenceType and arg1.placeId == arg2.placeId
end

function usePresenceImpressionEvents(arg1)
    local var1, var2 = React.useState({})

    React.useEffect(function()
        local tbl1 = {}
        for _, value in pairs(arg1) do
            tbl1[value.id] = value.presence
        end

        local bool1 = false
        local var3 = Cryo.Dictionary.join(var1, tbl1)
        for observedUserId, value in pairs(var3) do
            if tbl1[observedUserId] == nil then
                emitter.emit(telemetry, {
                    observedUserId = observedUserId,
                    presenceType = "Offline",
                    lastLocation = "Website",
                    implementationVariant = if FFlagFriendsSignalMigrationTelemetry then "UniversalAppFriendsStore" else "UniversalAppGraphQL"
                })
                bool1 = true
            elseif var1[observedUserId] == nil or not areEqual(var1[observedUserId], tbl1[observedUserId]) then
                local tbl2 = {
                    observedUserId = value.id,
                    presenceType = value.userPresenceType,
                    placeId = value.placeId,
                    universeId = value.universeId,
                    gameId = value.gameId,
                    lastLocation = value.lastLocation,
                    implementationVariant = if FFlagFriendsSignalMigrationTelemetry then "UniversalAppFriendsStore" else "UniversalAppGraphQL"
                }

                emitter.emit(telemetry, tbl2)
                bool1 = true
            end
        end

        if bool1 then
            var2(tbl1)
        end
    end, { arg1 })
end

return usePresenceImpressionEvents

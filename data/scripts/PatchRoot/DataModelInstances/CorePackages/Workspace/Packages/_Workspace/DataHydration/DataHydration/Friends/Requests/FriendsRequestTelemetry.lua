-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:01:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local HttpService = game:GetService("HttpService")

local SocialLuaAnalytics = require(DataHydrationParent.SocialLuaAnalytics)
local LoggingProtocol = require(DataHydrationParent.LoggingProtocol)

local SupportedTelemetryBackends = SocialLuaAnalytics.Analytics.Enums.SupportedTelemetryBackends

local emitter = SocialLuaAnalytics.Telemetry.createEmitter({
    telemetryImpl = LoggingProtocol.default,
    defaultTelemetryConfig = {
        throttlingThousandths = game:DefineFastInt("FriendsCommonAnalyticsThrottlingThousandths", 10000),
        links = "https://docs.google.com/document/d/1uRCdl8pEuiW9wDiOTL39JPMGLhgxtpvVgiXovE8Xof4"
    },
    getSharedInfo = function()
        return {}
    end
})

local telemetry = SocialLuaAnalytics.Telemetry.new({
    name = "FriendsSortFeFindFriendsResponse",
    description = "User making a request to /FindFriends",
    lastUpdated = { 2026, 6, 18 },
    backendsList = {{
        type = SupportedTelemetryBackends.EventIngest,
        format = function<T>(tbl1, _): T
            return tbl1
        end
    }}
})

local telemetry2 = SocialLuaAnalytics.Telemetry.new({
    name = "FriendsSortFeGetAllOnlineFriendsResponse",
    description = "User making a request to /GetAllOnlineFriends",
    lastUpdated = { 2026, 6, 18 },
    backendsList = {{
        type = SupportedTelemetryBackends.EventIngest,
        format = function<T>(tbl1, _): T
            return tbl1
        end
    }}
})

local function safeEmit(telemetry3, tbl1) -- Luacid: Inlined by compiler; 2 call sites recovered
    pcall(function()
        emitter.emit(telemetry3, tbl1)
    end)
end

return {
    generateRequestId = function(): string
        return string.format("friends-sort-%s", HttpService:GenerateGUID(false))
    end,
    getRequestOptions = function(friendsSort: string?): {headers: {[any]: any}}?
        return if friendsSort == nil then nil else {
            headers = { ["friends-sort"] = friendsSort }
        }
    end,
    emitFindFriendsResponse = function(requestId: string, tbl1)
        safeEmit(telemetry, { requestId = requestId, friendIds = table.concat(tbl1, ","), sortType = "FriendScore" })
    end,
    emitGetAllOnlineFriendsResponse = function(requestId: string, tbl1)
        safeEmit(telemetry2, { requestId = requestId, friendIds = table.concat(tbl1, ","), sortType = "Carousel" })
    end
}

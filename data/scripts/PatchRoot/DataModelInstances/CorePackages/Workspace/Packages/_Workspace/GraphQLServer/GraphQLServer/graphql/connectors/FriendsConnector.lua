-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T16:51:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GraphQLServer = script:FindFirstAncestor("GraphQLServer")
local GraphQLServerParent = GraphQLServer.Parent

local UrlBuilder = require(GraphQLServer.Parent.UrlBuilder).UrlBuilder
local UrlBase = require(GraphQLServer.Parent.UrlBuilder).UrlBase
local _LuauPolyfill = require(GraphQLServer.Parent.LuauPolyfill)
local Promise = require(GraphQLServer.Parent.Promise)
local GraphQLError = require(GraphQLServer.Parent.GraphQL).GraphQLError
local _generatedTypes = require(GraphQLServer.graphql.generatedTypes)

local Fetch = require(GraphQLServer.Parent.Fetch)
local fetch = Fetch.fetch
local Response = Fetch.Response

local SocialLuaAnalytics = require(GraphQLServerParent.SocialLuaAnalytics)
local reportPromiseLoadingTimeWrapper = SocialLuaAnalytics.Analytics.Timing.reportPromiseLoadingTimeWrapper
local createDiagMetricString = SocialLuaAnalytics.Analytics.Formatters.createDiagMetricString
local Diag = SocialLuaAnalytics.Analytics.DefaultAnalyticsService.Diag
local getPlatformSuffix = SocialLuaAnalytics.Analytics.FireEvent.getPlatformSuffix
local PlatformSpecificity = SocialLuaAnalytics.Analytics.Enums.PlatformSpecificity

local HttpService = game:GetService("HttpService")

local LoggingProtocol = require(GraphQLServerParent.LoggingProtocol)
local SupportedTelemetryBackends = SocialLuaAnalytics.Analytics.Enums.SupportedTelemetryBackends

local urlBuilder = UrlBuilder.new({
    base = UrlBase.FRIENDS,
    path = "users/{userId}/friends/find",
    query = {
        { name = "limit", value = "{limit}", optional = false },
        { name = "userSort", value = "{userSort}", optional = true },
        { name = "cursor", value = "{cursor}", optional = true }
    }
})

local urlBuilder2 = UrlBuilder.new({
    base = UrlBase.FRIENDS,
    path = "users/{userId}/friends/online",
    query = {{ name = "userSort", value = "{userSort}", optional = true }}
})

local function func1(): string -- Luacid: Inlined by compiler; 2 call sites recovered
    return string.format("friends-sort-%s", HttpService:GenerateGUID(false))
end

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
    lastUpdated = { 2026, 3, 18 },
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
    lastUpdated = { 2026, 3, 18 },
    backendsList = {{
        type = SupportedTelemetryBackends.EventIngest,
        format = function<T>(tbl1, _): T
            return tbl1
        end
    }}
})

local function func2(requestId: string, tbl1, telemetry3, sortType: string) -- Luacid: Inlined by compiler; 2 call sites recovered
    local tbl2 = {
        requestId = requestId,
        friendIds = table.concat(tbl1, ","),
        sortType = sortType
    }
    emitter.emit(telemetry3, tbl2)
end

local function fireLoadingEvent(arg1, arg2, arg3)
    local var1 = createDiagMetricString(arg1, arg2) .. getPlatformSuffix(PlatformSpecificity.BucketsOnly)
    Diag:reportStats(var1, arg3)
end

return {
    getAllFriendsByUserId = reportPromiseLoadingTimeWrapper(function(tbl1, arg1) -- name: getAllFriendsByUserId
        local var1 = arg1 or fetch

        return Promise.new(function(callback, callback2)
            local var2 = urlBuilder({ userId = tbl1.userId, limit = tbl1.pageLimit or 50, cursor = tbl1.pageCursor, userSort = tbl1.sort })
            local requestId = func1()

            local var3 = var1(var2, { method = "GET", headers = { ["friends-sort"] = requestId } }):catch(function(arg2)
                local var3 = Response.error()
                var3.statusText = arg2.message
                return var3
            end):expect()

            if not var3.ok then
                callback2(
                    GraphQLError.new(
                        var3.statusText,
                        nil,
                        nil,
                        nil,
                        nil,
                        {
                            extensions = {
                                status = var3.status,
                                statusText = var3.statusText
                            }
                        }
                    )
                )
                return
            end

            local var4 = var3:json():catch(function()
                return nil
            end):expect()

            if not var4 then
                callback2(GraphQLError.new("Failed to decode HTTP response as JSON for friends API"))
                return
            end

            callback(var4)

            if requestId == nil then
                return
            end
            local tbl2 = {}
            for _, pageItem in pairs(var4.PageItems) do
                table.insert(tbl2, pageItem.id)
            end
            func2(requestId, tbl2, telemetry, "FriendScore")
        end)
    end, function(arg1)
        return {
            fetch = "friends_find",
            nextPage = arg1.pageCursor and arg1.pageCursor ~= ""
        }
    end, { fireEvent = fireLoadingEvent }),
    getOnlineFriendsByUserId = reportPromiseLoadingTimeWrapper(function(tbl1, arg1) -- name: getOnlineFriendsByUserId
        local var1 = arg1 or fetch

        return Promise.new(function(callback, callback2)
            local var2 = urlBuilder2({ userId = tbl1.userId, userSort = tbl1.sort })
            local requestId = func1()

            local var3 = var1(var2, { method = "GET", headers = { ["friends-sort"] = requestId } }):catch(function(arg2)
                local var3 = Response.error()
                var3.statusText = arg2.message
                return var3
            end):expect()

            if not var3.ok then
                callback2(
                    GraphQLError.new(
                        var3.statusText,
                        nil,
                        nil,
                        nil,
                        nil,
                        {
                            extensions = {
                                status = var3.status,
                                statusText = var3.statusText
                            }
                        }
                    )
                )
                return
            end

            local var4 = var3:json():catch(function()
                return nil
            end):expect()

            if not var4 then
                callback2(GraphQLError.new("Failed to decode HTTP response as JSON for friends API"))
                return
            end

            local data = var4.data or {}
            callback(data)

            if requestId == nil then
                return
            end
            local tbl2 = {}
            for _, value in data do
                table.insert(tbl2, value.id)
            end
            func2(requestId, tbl2, telemetry2, "Carousel")
        end)
    end, function(_)
        return { fetch = "friends_online" }
    end, { fireEvent = fireLoadingEvent })
}

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T16:51:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local GraphQLServer = script:FindFirstAncestor("GraphQLServer")
local GraphQLServerParent = GraphQLServer.Parent

local FFlagUserProfileBetterErrors = require(GraphQLServer.Flags.FFlagUserProfileBetterErrors)
local FFlagUserProfilePlatformProfile = require(GraphQLServerParent.SharedFlags).FFlagUserProfilePlatformProfile
local FFlagUserProfileMergeCachedNames = require(GraphQLServerParent.SharedFlags).FFlagUserProfileMergeCachedNames
local FIntUserProfileStoreBatchSize = require(GraphQLServerParent.SharedFlags).FIntUserProfileStoreBatchSize
local PlatformProfileRequest = require(GraphQLServer.PlatformProfileRequest)
local fillRequestedNames = require(GraphQLServer.fillRequestedNames)
local _LuauPolyfill = require(GraphQLServerParent.LuauPolyfill)
local UrlBuilder = require(GraphQLServerParent.UrlBuilder)
local Promise = require(GraphQLServerParent.Promise)
local Fetch = require(GraphQLServerParent.Fetch)
local Url = require(GraphQLServerParent.Http).Url

local UrlBuilder2 = UrlBuilder.UrlBuilder

local GraphQLError = require(GraphQLServerParent.GraphQL).GraphQLError
local fetch = Fetch.fetch

local Response = Fetch.Response
local _generatedTypes = require(script.Parent.Parent.generatedTypes)

local var1 = UrlBuilder2.new({ base = Url.APIS_URL, path = "user-profile-api/v1/user/profiles/get-profiles" })()

local function fetchProfilesByIds(userIds, fields, arg1)
    local var2 = arg1 or fetch
    return Promise.new(function(callback, callback2)
        if FFlagUserProfilePlatformProfile and #userIds > FIntUserProfileStoreBatchSize then
            local tbl1 = {}
            for i = 1, #userIds, FIntUserProfileStoreBatchSize do
                local tbl2 = {}
                local var3 = i + FIntUserProfileStoreBatchSize - 1
                local userIdsLen = #userIds

                for j = i, math.min(var3, userIdsLen) do
                    table.insert(tbl2, userIds[j])
                end
                for _, value in (fetchProfilesByIds(tbl2, fields, var2):expect()) do
                    table.insert(tbl1, value)
                end
            end
            callback(tbl1)
            return
        end

        local includePlatformProfile = if FFlagUserProfilePlatformProfile and PlatformProfileRequest.hasPlatformFields(fields) then true else nil

        local var4 = var2(var1, {
            body = HttpService:JSONEncode({ UserIds = userIds, Fields = fields, includePlatformProfile = includePlatformProfile }),
            method = "POST",
            headers = { ["Content-Type"] = "application/json", Accept = "application/json" }
        }):catch(
            function(arg2)
                if not FFlagUserProfileBetterErrors then
                    return Response.error()
                end

                local var4 = Response.error()
                var4.statusText = arg2.message
                return var4
            end
        ):expect()

        if not var4.ok then
            if FFlagUserProfileBetterErrors then
                callback2(
                    GraphQLError.new(
                        var4.statusText,
                        nil,
                        nil,
                        nil,
                        nil,
                        {
                            extensions = {
                                status = var4.status,
                                statusText = var4.statusText
                            }
                        }
                    )
                )
                return
            end

            callback2(GraphQLError.new(`Failed to fetch user profiles. Error code: {var4.status}`))

            return
        end

        local var5 = var4:json():catch(function()
            return nil
        end):expect()

        if not var4 then
            callback2(GraphQLError.new(`Failed to decode HTTP response as JSON for user matching id: {userIds[1]}`))
            return
        end
        local profileDetails = var5.profileDetails
        if FFlagUserProfilePlatformProfile then
            profileDetails = PlatformProfileRequest.normalizeProfiles(profileDetails, fields)
        end
        if FFlagUserProfileMergeCachedNames then
            profileDetails = fillRequestedNames(profileDetails, fields)
        end
        callback(profileDetails)
    end)
end

return { fetchProfilesByIds = fetchProfilesByIds }

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T16:51:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local GraphQLServerParent = script:FindFirstAncestor("GraphQLServer").Parent

local _LuauPolyfill = require(GraphQLServerParent.LuauPolyfill)
local UrlBuilder = require(GraphQLServerParent.UrlBuilder)
local Promise = require(GraphQLServerParent.Promise)
local Fetch = require(GraphQLServerParent.Fetch)

local UrlBuilder2 = UrlBuilder.UrlBuilder
local UrlBase = UrlBuilder.UrlBase

local GraphQLError = require(GraphQLServerParent.GraphQL).GraphQLError
local fetch = Fetch.fetch

local Response = Fetch.Response
local _generatedTypes = require(script.Parent.Parent.generatedTypes)

local var1 = UrlBuilder2.new({ base = UrlBase.APIS, path = "sharelinks/v1/get-or-create-link" })()

return {
    fetchShareLink = function(tbl1, arg1)
        local var2 = arg1 or fetch

        local str1 = HttpService:JSONEncode(tbl1.data)

        local body = HttpService:JSONEncode({ linkType = tbl1.linkType, data = str1 })

        return Promise.new(function(callback, callback2)
            local var3 = var2(
                var1,
                {
                    body = body,
                    method = "POST",
                    headers = { ["Content-Type"] = "application/json", Accept = "application/json" }
                }
            ):catch(
                function(arg2)
                    local var3 = Response.error()
                    var3.statusText = arg2.message
                    return var3
                end
            ):expect()

            if not var3.ok then
                print(var3.statusText .. " " .. var3.status)
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

            if not var3 then
                callback2(GraphQLError.new(`Failed to decode HTTP response as JSON for share link matching type: {type}`))
                return
            end

            callback(var4)
        end)
    end
}

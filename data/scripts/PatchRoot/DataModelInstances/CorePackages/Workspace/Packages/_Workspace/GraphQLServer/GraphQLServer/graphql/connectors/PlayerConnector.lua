-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T16:51:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GraphQLServerParent = script:FindFirstAncestor("GraphQLServer").Parent
local _LuauPolyfill = require(GraphQLServerParent.LuauPolyfill)

local Promise = require(GraphQLServerParent.Promise)
local GraphQLError = require(GraphQLServerParent.GraphQL).GraphQLError
local fetch = require(GraphQLServerParent.Fetch).fetch
local UrlBuilder = require(GraphQLServerParent.UrlBuilder).UrlBuilder
local UrlBase = require(GraphQLServerParent.UrlBuilder).UrlBase

local module = {}
local urlBuilder = UrlBuilder.new({
    base = UrlBase.new("thumbnails", 1),
    path = "users/avatar-headshot",
    query = { userIds = "{userIds}", size = "48x48", format = "Png", isCircular = "true" }
})

function module.findAvatarHeadshotById(userIds: string, arg1)
    local var1 = arg1 or fetch

    return Promise.new(function(callback, callback2)
        local var2 = urlBuilder({ userIds = userIds })

        local var3 = var1(var2, { method = "GET" }):expect()

        if not var3.ok then
            callback2(
                GraphQLError.new(string.format("Http error occurred while trying to fetch avatarHeadshot for user %s.", userIds))
            )

            return
        end

        local var4 = var3:json():catch(function()
            return nil
        end):expect()

        if not var4 then
            callback2(GraphQLError.new(string.format("Failed to parse avatarHeadshot HttpResponse for user %s.", userIds)))
            return
        end

        callback(var4.data[1].imageUrl)
    end)
end

return module

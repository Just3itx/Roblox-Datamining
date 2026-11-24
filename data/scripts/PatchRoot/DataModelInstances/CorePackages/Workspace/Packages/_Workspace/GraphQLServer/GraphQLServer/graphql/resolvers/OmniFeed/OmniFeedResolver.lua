-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T17:01:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GraphQLServerParent = script:FindFirstAncestor("GraphQLServer").Parent
local Array = require(GraphQLServerParent.LuauPolyfill).Array

local tbl1 = {}

local OmniFeedConnector = require(script.Parent.Parent.Parent.connectors.OmniFeed.OmniFeedConnector)

local findOmniFeedBySessionId = OmniFeedConnector.findOmniFeedBySessionId
local fetchMoreOmniRecommendationMetadata = OmniFeedConnector.fetchMoreOmniRecommendationMetadata

local _generatedTypes = require(script.Parent.Parent.Parent.generatedTypes)

tbl1.default = {
    OmniFeedItem = {
        experiences = function(tbl2)
            if not (tbl2.metadata and tbl2.metadata.Game and tbl2.recommendations) then
                return nil
            end
            local game = tbl2.metadata.Game
            local result = {}
            for _, recommendation in tbl2.recommendations do
                if not recommendation.contentId then
                    continue
                end

                local var1 = game[tostring(recommendation.contentId)]
                local contentMetadata = recommendation.contentMetadata
                local encryptedAdTrackingData = if contentMetadata and contentMetadata.EncryptedAdTrackingData then contentMetadata.EncryptedAdTrackingData else nil

                if not (var1 and var1.universeId) then
                    continue
                end

                local tbl3 = {
                    placeId = if var1.rootPlaceId then tostring(var1.rootPlaceId) else nil,
                    name = var1.name,
                    universeId = tostring(var1.universeId),
                    totalUpVotes = var1.totalUpVotes,
                    totalDownVotes = var1.totalDownVotes,
                    playerCount = var1.playerCount,
                    under9 = if var1.under9 then var1.under9 else false,
                    under13 = if var1.under13 then var1.under13 else false,
                    adId = encryptedAdTrackingData or "",
                    isSponsored = not (encryptedAdTrackingData == nil) and encryptedAdTrackingData ~= ""
                }
                table.insert(result, tbl3)
            end

            return result
        end
    },
    OmniFeedMetadata = {
        GameJSON = function(arg1)
            return arg1.Game
        end,
        CatalogAssetJSON = function(arg1)
            return arg1.CatalogAsset
        end,
        CatalogBundleJSON = function(arg1)
            return arg1.CatalogBundle
        end,
        RecommendedFriendJSON = function(arg1)
            return arg1.RecommendedFriend
        end
    },
    OmniFeed = {
        metadata = function(arg1)
            return arg1.contentMetadata
        end,
        sortsExpirationTime = function(arg1)
            if not arg1.sortsRefreshInterval then
                return nil
            end
            return math.floor((tick())) + arg1.sortsRefreshInterval
        end,
        recommendationsId = function(arg1)
            return arg1.requestId
        end,
        globalLayoutData = function(arg1)
            return arg1.globalLayoutData
        end,
        sorts = function(arg1)
            if not arg1.sorts then
                return nil
            end

            return (Array.map(arg1.sorts, function(arg2)
                return {
                    topic = arg2.topic,
                    topicId = arg2.topicId,
                    treatmentType = arg2.treatmentType,
                    recommendations = arg2.recommendationList,
                    metadata = arg1.contentMetadata
                }
            end))
        end
    },
    OmniFeedItemWithMetadata = {
        metadata = function(arg1)
            return arg1.contentMetadata
        end,
        sort = function(arg1)
            return {
                topicId = arg1.topicId,
                metadata = arg1.contentMetadata,
                recommendations = arg1.recommendations
            }
        end
    },
    Query = {
        omniFeed = function(_, arg1, arg2)
            return findOmniFeedBySessionId(arg1, arg2.fetchImpl)
        end,
        refreshOmniFeedItem = function(_, arg1, arg2)
            return fetchMoreOmniRecommendationMetadata(arg1, arg2.fetchImpl)
        end
    }
}

return tbl1

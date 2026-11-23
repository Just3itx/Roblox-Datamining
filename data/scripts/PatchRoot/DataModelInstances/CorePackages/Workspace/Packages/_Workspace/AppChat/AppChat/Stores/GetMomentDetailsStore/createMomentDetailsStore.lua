-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:20:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local DataHydration = require(AppChatParent.DataHydration)
local MomentsTypes = require(AppChatParent.MomentsTypes)
local _MomentsStoreTypes = require(AppChatParent.DataHydration.MomentsStoreTypes)
local MomentsGetMomentsStore = require(AppChatParent.DataHydration.MomentsGetMomentsStore)

local FFlagAppChatMomentShareCardEdgeCases = require(AppChat.Flags.FFlagAppChatMomentShareCardEdgeCases)

local var1 = require(AppChat.Logger):new(script.Name)

local MomentStatus = MomentsTypes.Enums.MomentStatus
local ShareLinkTargetIdType = MomentsTypes.Enums.ShareLinkTargetIdType

local function createMomentDetailsStore(tbl1)
    local tbl2 = tbl1 or {}

    local function createResolver(feedItemId)
        local cache = DataHydration.createDataCache(tbl2.ttlSeconds, tbl2.failedTtlSeconds)
        return DataHydration.createDataResolver({
            cache = cache,
            supportsMultiGet = true,
            queueProcessDelaySec = 0,
            replaceItems = true,
            logError = function(arg1)
                var1:warning(`Error resolving Moment details: {tostring(arg1)}`)
            end,
            fetchFn = function(tbl3)
                local tbl4 = {}
                for value in tbl3 do
                    table.insert(tbl4, value)
                end

                return MomentsGetMomentsStore(false).getMomentsByIds(tbl4, feedItemId):andThen(function(arg1)
                    local result = ({})
                    for _, moment in arg1.moments do
                        local bool1 = not (moment.isModerated == true) and moment.status ~= MomentStatus.Deleted

                        if not (FFlagAppChatMomentShareCardEdgeCases or bool1) then
                            continue
                        end

                        local var2 = if feedItemId == ShareLinkTargetIdType.FeedItemId then moment.recommendationMetadata.feedItemId else moment.momentId

                        if var2 ~= nil and tbl3[var2] ~= nil then
                            result[var2] = moment
                        end
                    end

                    return result
                end)
            end
        })
    end

    local resolver = createResolver(nil)
    local resolver2 = createResolver(ShareLinkTargetIdType.FeedItemId)

    local function getResolver(feedItemId) -- Luacid: Inlined by compiler; 3 call sites recovered
        return if feedItemId == ShareLinkTargetIdType.FeedItemId then resolver2 else resolver
    end

    return {
        getCachedMomentDetails = function(str1: string, feedItemId)
            return getResolver(feedItemId).getCachedItem(str1)
        end,
        fetchMomentDetails = function(str1: string, feedItemId)
            return getResolver(feedItemId).fetchItem(str1)
        end,
        getAndFetchMomentDetails = function(str1: string, feedItemId)
            return getResolver(feedItemId).getAndFetchItem(str1)
        end,
        clear = function()
            resolver.clear()
            resolver2.clear()
        end,
        dispose = function()
            resolver.dispose()
            resolver2.dispose()
        end
    }
end
return createMomentDetailsStore

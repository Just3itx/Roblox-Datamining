-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:21:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local createDataCache = require(DataHydration.createDataCache)
local createDataResolver = require(DataHydration.createDataResolver)
local _DataHydrationTypes = require(DataHydration.DataHydrationTypes)
local UserVoteFeedbackMetadataStoreTypes = require(script.Parent.UserVoteFeedbackMetadataStoreTypes)
local DiscoveryUtils = require(DataHydrationParent.DiscoveryUtils)
local logResponseError = DiscoveryUtils.logResponseError
local DiscoveryEventErrorLogger = DiscoveryUtils.DiscoveryEventErrorLogger
local fetchUserVoteFeedbackMetadata = require(script.Parent.fetchUserVoteFeedbackMetadata)
local UserVoteFeedbackMetdataUrlBuilder = require(script.Parent.UserVoteFeedbackMetdataUrlBuilder)
local UserVoteFeedbackMetadataDerivedFields = require(script.Parent.UserVoteFeedbackMetadataDerivedFields)

local function createUserVoteFeedbackMetadataStore()
    local cache = createDataCache()

    local dataResolver = createDataResolver({
        cache = cache,
        supportsMultiGet = false,
        logError = function(arg1)
            logResponseError(UserVoteFeedbackMetdataUrlBuilder.USER_VOTE_FEEDBACK_METADATA_URL, arg1)
        end,
        fetchFn = function(rootPlaceId: string, _)
            return fetchUserVoteFeedbackMetadata(rootPlaceId):andThen(function(arg1)
                local responseBody = arg1.responseBody

                if not UserVoteFeedbackMetadataStoreTypes.userVoteFeedbackMetadataResponseValidator(responseBody) then
                    DiscoveryEventErrorLogger.reportError(
                        "createUserVoteFeedbackMetadataStore",
                        "Invalid user vote feedback metadata response",
                        { rootPlaceId = rootPlaceId, responseBody = responseBody }
                    )

                    error({ StatusCode = arg1.responseCode })
                end

                return {
                    rootPlaceId = rootPlaceId,
                    canSubmitReview = responseBody.capabilities and responseBody.capabilities.can_submit_review,
                    canSubmitComment = responseBody.capabilities and responseBody.capabilities.can_submit_comment,
                    categories = responseBody.categories or {},
                    comment = responseBody.comment or {},
                    metadata = responseBody.metadata or {}
                }
            end)
        end
    })

    return {
        fetchUserVoteFeedbackMetadata = dataResolver.fetchItem,
        fetchUserVoteFeedbackMetadatas = dataResolver.fetchItems,
        getUserVoteFeedbackMetadata = dataResolver.getCachedItem,
        getUserVoteFeedbackMetadatas = dataResolver.getCachedItems,
        getAndFetchUserVoteFeedbackMetadata = dataResolver.getAndFetchItem,
        getAndFetchUserVoteFeedbackMetadatas = dataResolver.getAndFetchItems,
        clearItem = function(str1: string)
            cache.replaceItem(str1, nil)
        end,
        calculateDerivedField = UserVoteFeedbackMetadataDerivedFields.calculateDerivedField,
        clear = function()
            cache.clear()
            dataResolver.clear()
        end,
        dispose = function()
            dataResolver.dispose()
        end
    }
end
return createUserVoteFeedbackMetadataStore

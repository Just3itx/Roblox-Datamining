-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:21:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local DataHydration = require(AppChatParent.DataHydration)
local HttpClient = require(AppChatParent.HttpClient)

local classifyShareLinkV2 = require(AppChat.Components.ChatConversation.Utils.RobloxUrlUtils.classifyShareLinkV2)
local var1 = require(AppChat.Logger):new(script.Name)
local fetchResolvedShareLink = require(script.Parent.Requests.fetchResolvedShareLink)

local function createShareLinkV2Store(tbl1)
    local tbl2 = tbl1 or {}

    local cache = DataHydration.createDataCache(tbl2.ttlSeconds, tbl2.failedTtlSeconds)
    local dataResolver = DataHydration.createDataResolver({
        cache = cache,
        supportsMultiGet = false,
        replaceItems = true,
        logError = function(arg1)
            var1:warning(`Error resolving share link v2: {tostring(arg1)}`)
        end,
        fetchFn = function(str1: string)
            return HttpClient.asPromise(fetchResolvedShareLink(str1, tbl2.network)):andThen(classifyShareLinkV2)
        end
    })

    return {
        getCachedClassification = dataResolver.getCachedItem,
        fetchClassification = dataResolver.fetchItem,
        getAndFetchClassification = dataResolver.getAndFetchItem,
        clear = dataResolver.clear,
        dispose = dataResolver.dispose
    }
end

return createShareLinkV2Store

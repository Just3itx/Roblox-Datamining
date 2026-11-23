-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:11:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local AppChatNetworking = require(AppChatParent.AppChatNetworking)
local DataHydration = require(AppChatParent.DataHydration)
local _Signals = require(AppChatParent.Signals)
local LocalUserIdStore = require(AppChatParent.LocalUserIdStore).LocalUserIdStore

local var1 = require(AppChat.Logger):new(script.Name)

local function resolveLocalUserId(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    return LocalUserIdStore.getCurrentUserId(arg1)
end

local function createFriendsChatMetadataStore()
    local cache = DataHydration.createDataCache()
    local dataResolver = DataHydration.createDataResolver({
        cache = cache,
        supportsMultiGet = false,
        fetchFn = function(_: string)
            return AppChatNetworking.http.GetMetadata():andThen(function(arg1)
                return arg1.responseBody
            end)
        end,
        logError = function(arg1)
            var1:warning(`Failed to fetch Friends Chat metadata: {tostring(arg1)}`)
        end
    })

    return {
        getFriendsChatMetadata = function(arg1)
            return dataResolver.getAndFetchItem(resolveLocalUserId(arg1))
        end,
        getCachedFriendsChatMetadata = function(arg1)
            return dataResolver.getCachedItem(resolveLocalUserId(arg1))
        end,
        fetchFriendsChatMetadata = function()
            return dataResolver.fetchItem(resolveLocalUserId(false))
        end,
        updateFriendsChatMetadata = function(arg1)
            cache.replaceItem(resolveLocalUserId(false), arg1)
        end,
        clear = dataResolver.clear,
        dispose = dataResolver.dispose
    }
end

return createFriendsChatMetadataStore

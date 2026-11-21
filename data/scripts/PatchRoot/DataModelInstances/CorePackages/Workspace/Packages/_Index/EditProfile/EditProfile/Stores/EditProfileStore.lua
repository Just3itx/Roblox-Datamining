-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T12:10:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local EditProfileParent = script:FindFirstAncestor("EditProfile").Parent
local _Signals = require(EditProfileParent.Signals)

local DataHydration = require(EditProfileParent.DataHydration)
local createDataCache = DataHydration.createDataCache
local createDataResolver = DataHydration.createDataResolver
local fetchUserDescription = require(script.Parent.Requests.fetchUserDescription)
local fetchUsernameChangePrice = require(script.Parent.Requests.fetchUsernameChangePrice)
local updateUserDescription = require(script.Parent.Requests.updateUserDescription)

local cache = createDataCache()
local dataResolver = createDataResolver(
    {
        cache = cache,
        supportsMultiGet = false,
        fetchFn = fetchUserDescription,
        queueProcessDelaySec = 0
    }
)

local dataResolver2 = createDataResolver(
    {
        cache = createDataCache(),
        supportsMultiGet = false,
        fetchFn = fetchUsernameChangePrice,
        queueProcessDelaySec = 0
    }
)

return {
    getDescription = function(str1: string)
        return (dataResolver.getAndFetchItem(str1))
    end,
    getUsernameChangePrice = function(str1: string)
        return dataResolver2.getAndFetchItem(str1)
    end,
    updateDescription = function(str1: string, str2: string)
        return updateUserDescription(str2):andThen(function<T>(arg1: T): T
            cache.replaceItem(str1, arg1)
            return arg1
        end)
    end
}

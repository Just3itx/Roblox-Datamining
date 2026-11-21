-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T10:50:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DiscoveryAvailabilityParent = script:FindFirstAncestor("DiscoveryAvailability").Parent

local Signals = require(DiscoveryAvailabilityParent.Signals)

local _CacheStoreTypes = require(script.Parent.CacheStoreTypes)

return Signals.createComputed(function() -- name: createCacheStore
    local getHomePageDataSource, setHomePageDataSource = Signals.createSignal(nil)

    return {
        getHomePageDataSource = getHomePageDataSource,
        setHomePageDataSource = setHomePageDataSource
    }
end)

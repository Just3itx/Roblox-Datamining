-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T02:21:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local scriptParentParentParent = scriptParentParent.Parent

local Signals = require(scriptParentParentParent.Signals)
local NetworkProfiler = require(scriptParentParentParent.Http).NetworkProfiler
local _HttpStoreTypes = require(scriptParentParent.HttpStoreTypes)

local function createNetworkStatsHandler(arg1)
    return Signals.createEffect(function(arg2)
        local var1 = arg1(arg2)
        if var1.status ~= "Success" then
            return
        end

        local response = var1.response
        if not response.Stats then
            return
        end

        local Stats = response.Stats
        NetworkProfiler:track({
            queued = Stats.DurationInQueue or 0,
            nameLookup = Stats.DurationNameLookup or -1,
            connect = Stats.DurationConnect or -1,
            sslHandshake = Stats.DurationSSLHandshake or -1,
            makeRequest = Stats.DurationMakeRequest or -1,
            receiveResponse = Stats.DurationReceiveResponse or -1
        })
    end)
end

return createNetworkStatsHandler

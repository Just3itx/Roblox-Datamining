-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T04:30:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VirtualEventsState = script:FindFirstAncestor("VirtualEventsState")

local HttpRequest = require(VirtualEventsState.Parent.HttpRequest)
local RoduxNetworking = require(VirtualEventsState.Parent.RoduxNetworking)
local NetworkingVirtualEvents = require(VirtualEventsState.Parent.NetworkingVirtualEvents)
local NetworkingGames = require(VirtualEventsState.Parent.NetworkingGames)
local logger = require(VirtualEventsState.logger)

local maxRetryCount = game:DefineFastInt("VirtualEventsHttpRetryCount", 3)

local networkImpl = HttpRequest.config({
    requestFunction = function(arg1, arg2, arg3)
        logger:debug("GET {}", arg1)

        return HttpRequest.requestFunctions.RequestInternal(arg1, arg2, arg3)
    end,
    postRequestFunction = function(arg1, arg2)
        logger:debug("{} {} {}", arg1.StatusCode, arg2.url, arg1.Body)
    end,
    maxRetryCount = maxRetryCount
})

local var2 = RoduxNetworking.config({ keyPath = "VirtualEvents.networkStatus", networkImpl = networkImpl })

return {
    RoduxNetworking = var2,
    NetworkingVirtualEvents = NetworkingVirtualEvents.config({ roduxNetworking = var2 }),
    NetworkingGames = NetworkingGames.config({ roduxNetworking = var2 })
}

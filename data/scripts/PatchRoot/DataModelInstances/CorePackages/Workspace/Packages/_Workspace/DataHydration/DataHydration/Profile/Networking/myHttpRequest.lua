-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T05:10:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent
local HttpRequest = require(DataHydrationParent.HttpRequest)
local maxRetryCount = game:DefineFastInt("ProfileCTAHttpRetryCount", 3)

return (HttpRequest.config({
    requestFunction = function(arg1, arg2, arg3)
        return HttpRequest.requestFunctions.RequestInternal(arg1, arg2, arg3)
    end,
    maxRetryCount = maxRetryCount
}))

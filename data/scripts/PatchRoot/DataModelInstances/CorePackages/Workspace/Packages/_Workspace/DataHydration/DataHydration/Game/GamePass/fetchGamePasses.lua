-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:21:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local HttpRequest = require(DataHydrationParent.HttpRequest)

local _GamePassStoreTypes = require(script.Parent.GamePassStoreTypes)
local GamePassUrlBuilder = require(script.Parent.GamePassUrlBuilder)

local var1 = HttpRequest.config({
    requestFunction = function(str1: string, str2: string, arg1)
        return HttpRequest.requestFunctions.HttpRbxApi(str1, str2, arg1)
    end
})

local function fetchGamePasses(universeId: string)
    local gamePassesUrl = GamePassUrlBuilder.buildGamePassesUrl({ universeId = universeId })
    return var1(gamePassesUrl, "GET"):andThen(function(arg1)
        local gamePasses = arg1.responseBody and arg1.responseBody.gamePasses or {}
        return { universeId = universeId, gamePasses = gamePasses }
    end)
end

return fetchGamePasses

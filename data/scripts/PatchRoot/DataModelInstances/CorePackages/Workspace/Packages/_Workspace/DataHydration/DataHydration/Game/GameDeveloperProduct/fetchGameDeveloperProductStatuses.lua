-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:11:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local HttpRequest = require(DataHydrationParent.HttpRequest)

local GameDeveloperProductUrlBuilder = require(script.Parent.GameDeveloperProductUrlBuilder)

local var1 = HttpRequest.config({
    requestFunction = function(str1: string, str2: string, arg1)
        return HttpRequest.requestFunctions.HttpRbxApi(str1, str2, arg1)
    end
})

local function parseStatusCounts(arg1)
    local result = ({})
    if typeof(arg1) ~= "table" then
        return result
    end
    for _, value in ipairs(arg1) do
        if typeof(value) ~= "table" or not (value.actionArgs and value.receipt) then
            continue
        end

        for _, actionArg in ipairs(value.actionArgs) do
            if actionArg.Key == "productId" and actionArg.Value then
                local str1 = tostring(actionArg.Value)
                result[str1] = (result[tostring(actionArg.Value)] or 0) + 1
            end
        end
    end

    return result
end

return {
    fetch = function(playerId: string, placeId: string) -- name: fetchGameDeveloperProductStatuses
        local statusesUrl = GameDeveloperProductUrlBuilder.buildStatusesUrl({ playerId = playerId, placeId = placeId })
        return var1(statusesUrl, "GET"):andThen(function(arg1)
            return {
                playerId = playerId,
                placeId = placeId,
                counts = parseStatusCounts(arg1 and arg1.responseBody)
            }
        end)
    end,
    _parseStatusCounts = parseStatusCounts
}

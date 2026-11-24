-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T05:01:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local Promise = require(DataHydrationParent.Promise)
local HttpClient = require(DataHydrationParent.HttpClient)

local fetch = HttpClient.fetch
local asPromise = HttpClient.asPromise

local function pollAnalyticsOperation(tbl1)
    local delay = tbl1.delay or Promise.delay

    local function postQuery(num1: number)
        local var1 = fetch({
            network = tbl1.network,
            method = "POST",
            url = tbl1.url,
            body = tbl1.body,
            analyticsKey = tbl1.analyticsKey,
            decode = function(arg1)
                return arg1 and arg1.operation or {}
            end
        })
        return asPromise(var1):andThen(function(arg1)
            if arg1.done ~= true then
                if num1 >= 6 then
                    return Promise.reject({ errorMessage = tbl1.timeoutMessage })
                end
                return delay(2):andThen(function()
                    return postQuery(num1 + 1)
                end)
            elseif arg1.error ~= nil then
                return Promise.reject({ responseCode = arg1.error.code, errorMessage = arg1.error.message })
            else
                return Promise.resolve(tbl1.mapResult(arg1))
            end
        end)
    end
    return postQuery(1)
end

return pollAnalyticsOperation

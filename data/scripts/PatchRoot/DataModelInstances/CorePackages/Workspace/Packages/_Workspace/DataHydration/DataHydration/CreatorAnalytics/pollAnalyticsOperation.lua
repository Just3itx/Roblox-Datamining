-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:40:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local Promise = require(DataHydrationParent.Promise)
local HttpClient = require(DataHydrationParent.HttpClient)

local function toRejection(arg1): {[any]: any} | {errorMessage: string} -- Luacid: Inlined by compiler; 2 call sites recovered
    return if typeof(arg1) == "table" and typeof(arg1.errorMessage) == "string" then arg1 else {
        errorMessage = tostring(arg1)
    }
end

local fetch = HttpClient.fetch
local asPromise = HttpClient.asPromise

local function pollAnalyticsOperation(tbl1)
    local delay = tbl1.delay or Promise.delay

    return Promise.new(function(callback, callback2, callback3)
        local bool1 = false
        local var1 = nil
        local var2 = nil

        callback3(function()
            bool1 = true
            if var1 ~= nil then
                var1:cancel()
            end
            if var2 ~= nil then
                var2:cancel()
            end
        end)

        local function postQuery(num1: number)
            if bool1 then
                return
            end
            local var3 = asPromise(
                fetch({
                    network = tbl1.network,
                    method = "POST",
                    url = tbl1.url,
                    body = tbl1.body,
                    analyticsKey = tbl1.analyticsKey,
                    decode = function(arg1)
                        return arg1 and arg1.operation or {}
                    end
                })
            )

            var1 = var3
            var3:andThen(function(arg1)
                if bool1 then
                    return
                end

                if arg1.done ~= true then
                    if num1 >= 6 then
                        callback2({ errorMessage = tbl1.timeoutMessage })
                        return
                    end
                    local var4 = delay(2)
                    var2 = var4
                    var4:andThen(function()
                        postQuery(num1 + 1)
                    end)
                elseif arg1.error ~= nil then
                    callback2(
                        {
                            responseCode = arg1.error.code,
                            errorMessage = arg1.error.message or "analytics operation returned an error"
                        }
                    )
                else
                    local success, result = pcall(tbl1.mapResult, arg1)
                    if success then
                        callback(result)
                        return
                    end
                    callback2((toRejection(result)))
                end
            end, function(arg1)
                callback2((toRejection(arg1)))
            end)
        end

        postQuery(1)
    end)
end

return pollAnalyticsOperation

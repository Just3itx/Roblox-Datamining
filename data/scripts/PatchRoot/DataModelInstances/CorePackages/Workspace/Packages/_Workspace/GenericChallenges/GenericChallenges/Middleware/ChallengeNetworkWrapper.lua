-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T16:21:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericChallengesParent = script:FindFirstAncestor("GenericChallenges").Parent

local Promise = require(GenericChallengesParent.Promise)
local _HttpClient = require(GenericChallengesParent.HttpClient)
local IsChallengeHttpResponse = require(script.Parent.IsChallengeHttpResponse)
local InterceptChallenge = require(script.Parent.InterceptChallenge)

return function(arg1, arg2)
    local var1 = arg2 or InterceptChallenge

    return {
        request = function(arg3, callback: (...any) -> (...any))
            local bool1 = false
            local bool2 = false
            local var2 = nil

            local function settle(bool3: boolean, arg4) -- Luacid: Inlined by compiler; 5 call sites recovered
                if bool1 or bool2 then
                    return
                end
                bool2 = true
                callback(bool3, arg4)
            end

            local function retryWithChallengeHeaders(tbl1)
                if bool1 then
                    return Promise.reject()
                end
                return Promise.new(function(callback2)
                    local headers = not arg3.headers and {} or table.clone(arg3.headers)
                    for value, value2 in tbl1 do
                        headers[value] = value2
                    end

                    local var4 = table.clone(arg3)
                    var4.headers = headers
                    var2 = arg1.request(var4, function(success, response)
                        callback2({ success = success, response = response })
                    end)
                end)
            end

            var2 = arg1.request(arg3, function(arg4, arg5)
                var2 = nil
                if bool1 then
                    return
                end

                if not arg4 then
                    settle(arg4, arg5)
                    return
                end

                local headers = arg5.headers
                if not (headers and IsChallengeHttpResponse(arg5.statusCode, headers)) then
                    settle(arg4, arg5)
                    return
                end

                local success, result = pcall(var1, { rawResponseHeaders = headers, retryRequestCallback = retryWithChallengeHeaders })

                if not success then
                    settle(arg4, arg5)
                    return
                end

                result:andThen(function(tbl1)
                    settle(tbl1.success, tbl1.response)
                end):catch(function()
                    settle(arg4, arg5)
                end)
            end)

            return function()
                bool1 = true
                if var2 ~= nil then
                    var2()
                    var2 = nil
                end
            end
        end
    }
end

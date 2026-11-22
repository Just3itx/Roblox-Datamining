-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T02:41:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local scriptParentParent = script.Parent.Parent
local dependencies = require(scriptParentParent.dependencies)
local Promise = dependencies.Promise
local UrlBuilder = dependencies.UrlBuilder
local UrlBase = dependencies.UrlBase
local Fetch = dependencies.Fetch
local fetch = Fetch.fetch
local Response = Fetch.Response
local ConsentName = require(scriptParentParent.Enums.ConsentName)

local urlBuilder = UrlBuilder.new({ base = UrlBase.APIS, path = "user-consents-api/v1/user-consents/one-time" })

return {
    grantOneTimeUserConsent = function(arg1, ttlSeconds: number?, rbxAuditData: string)
        local consentType = ConsentName[arg1]
        if not consentType then
            return Promise.reject(`Invalid consent name type: {arg1}`)
        end

        local var2 = urlBuilder()
        return Promise.new(function(callback, callback2)
            local success, result = pcall(function()
                return fetch(var2, {
                    method = "POST",
                    body = HttpService:JSONEncode({ consentType = consentType, ttlSeconds = ttlSeconds }),
                    headers = {
                        ["Content-Type"] = "application/json",
                        Accept = "application/json",
                        ["rbx-audit-data"] = rbxAuditData
                    }
                }):catch(
                    function(_)
                        return Response.error()
                    end
                ):expect()
            end)

            if not success then
                callback2("Failed to make request: " .. tostring(result))
                return
            end

            if not result.ok then
                callback2(string.format("Got grant one time user consent HTTP Response: %d - %s", result.status, result.statusText))
            else
                callback()
            end
        end)
    end
}

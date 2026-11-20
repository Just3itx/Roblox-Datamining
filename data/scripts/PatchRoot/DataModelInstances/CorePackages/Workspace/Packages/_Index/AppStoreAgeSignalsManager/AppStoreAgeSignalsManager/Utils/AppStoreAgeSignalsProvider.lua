-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T23:41:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppStoreAgeSignalsManagerParent = script:FindFirstAncestor("AppStoreAgeSignalsManager").Parent

local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")

local UrlBuilder = require(AppStoreAgeSignalsManagerParent.UrlBuilder).UrlBuilder
local UrlBase = require(AppStoreAgeSignalsManagerParent.UrlBuilder).UrlBase
local Fetch = require(AppStoreAgeSignalsManagerParent.Fetch)
local Promise = require(AppStoreAgeSignalsManagerParent.Promise)
local fetch = Fetch.fetch
local Response = Fetch.Response

local urlBuilder = UrlBuilder.new({
    base = UrlBase.APIS,
    path = "app-signals-service/v1/app-signals/get-eligibility",
    query = { signalSource = "{signalSource}" }
})

local urlBuilder2 = UrlBuilder.new({ base = UrlBase.APIS, path = "app-signals-service/v1/app-signals/store-result" })

return {
    checkEligibility = function()
        local var1 = fetch
        local platformName = UserInputService:GetPlatform().Name
        return Promise.new(function(callback, callback2)
            local var2 = urlBuilder({ signalSource = platformName })
            local var3 = var1(var2, { method = "GET" }):catch(function()
                return Response.error()
            end):expect()

            if not var3.ok then
                callback2(string.format("Eligibility check failed with HTTP status: %d", var3.status))
                return
            end

            local var4 = var3:json():catch(function()
                return nil
            end):expect()

            if not var4 then
                callback2("Failed to decode eligibility response as JSON")
                return
            end

            callback({ eligible = var4.eligible, signalSource = platformName })
        end)
    end,
    publishResult = function(signalSource: string, encodedSignals: string, resultType: string)
        local var1 = fetch
        return Promise.new(function(callback, callback2)
            local var2 = urlBuilder2()
            local var3 = var1(var2, {
                method = "POST",
                body = HttpService:JSONEncode({ signalSource = signalSource, encodedSignals = encodedSignals, resultType = resultType }),
                headers = { ["Content-Type"] = "application/json", Accept = "application/json" }
            }):catch(
                function()
                    return Response.error()
                end
            ):expect()

            if not var3.ok then
                callback2(string.format("Publish result failed with HTTP status: %d", var3.status))
                return
            end

            callback()
        end)
    end
}

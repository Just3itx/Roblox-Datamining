-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:01:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpRbxApiService = game:GetService("HttpRbxApiService")
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")

local InExperienceShop = script:FindFirstAncestor("InExperienceShop")
local InExperienceShopParent = InExperienceShop.Parent

local Promise = require(InExperienceShopParent.Promise)
local Url = require(InExperienceShopParent.Http).Url
local Errors = require(script.Parent.Errors)
local ShopDebugLogger = require(InExperienceShop.Internal.ShopDebugLogger)

local apiUrl = Url.APIS_URL .. "game-passes/v1/game-passes:batchGetOwnership"

local function userOwnsGamePassHttp(gamePassId: number)
    return Promise.new(function(callback, callback2)
        task.spawn(function()
            local localPlayer = Players.LocalPlayer
            if localPlayer == nil then
                callback2((Errors.engineError("userOwnsGamePassHttp: no LocalPlayer")))
                return
            end

            local userId = localPlayer.UserId
            local input = {
                ownershipIdentifiers = {{ userId = userId, gamePassId = gamePassId }}
            }

            ShopDebugLogger.logLazy(function(): string
                return "userOwnsGamePassHttp: POST gamePassId=" .. gamePassId .. " userId=" .. userId
            end)
            local var1 = ShopDebugLogger.startTimer()

            local success, result = pcall(function(): string
                return HttpRbxApiService:PostAsyncFullUrl(apiUrl, HttpService:JSONEncode(input))
            end)
            if not success then
                ShopDebugLogger.logElapsed("userOwnsGamePassHttp: HTTP error", var1)
                ShopDebugLogger.logLazy(function(): string
                    return "userOwnsGamePassHttp: HTTP error detail=" .. tostring(result)
                end)
                callback2((Errors.networkError("userOwnsGamePassHttp: HTTP request failed", result)))
                return
            end

            ShopDebugLogger.logElapsed("userOwnsGamePassHttp: HTTP response received", var1)

            local success2, result2 = pcall(function()
                return HttpService:JSONDecode(result)
            end)
            if not success2 then
                ShopDebugLogger.logLazy(function(): string
                    return "userOwnsGamePassHttp: JSON parse error=" .. tostring(result2)
                end)
                callback2((Errors.parseError("userOwnsGamePassHttp: response body is not valid JSON", result2)))
                return
            end

            if typeof(result2) ~= "table" or typeof(result2.ownershipIdentifiers) ~= "table" then
                ShopDebugLogger.log("userOwnsGamePassHttp: schema error, missing ownershipIdentifiers")
                callback2(
                    (Errors.schemaError("userOwnsGamePassHttp: malformed response, expected { ownershipIdentifiers = ... }", result2))
                )
                return
            end

            for _, ownershipIdentifier in result2.ownershipIdentifiers do
                if typeof(ownershipIdentifier) ~= "table"
                    or ownershipIdentifier.userId ~= userId
                    or ownershipIdentifier.gamePassId ~= gamePassId
                then
                    continue
                end
                ShopDebugLogger.logLazy(function(): string
                    return "userOwnsGamePassHttp: owns=true gamePassId=" .. gamePassId
                end)
                callback(true)
                return
            end

            ShopDebugLogger.logLazy(function(): string
                return "userOwnsGamePassHttp: owns=false gamePassId=" .. gamePassId
            end)
            callback(false)
        end)
    end)
end

return userOwnsGamePassHttp

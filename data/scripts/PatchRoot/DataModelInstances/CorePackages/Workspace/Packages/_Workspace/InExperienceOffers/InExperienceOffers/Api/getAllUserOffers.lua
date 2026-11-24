-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T19:30:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpRbxApiService = game:GetService("HttpRbxApiService")
local HttpService = game:GetService("HttpService")

local InExperienceOffers = script:FindFirstAncestor("InExperienceOffers")
local InExperienceOffersParent = InExperienceOffers.Parent

local Promise = require(InExperienceOffersParent.Promise)
local Url = require(InExperienceOffersParent.Http).Url
local Errors = require(script.Parent.Errors)
local OffersDebugLogger = require(InExperienceOffers.Internal.OffersDebugLogger)
local logCounter = require(InExperienceOffers.Internal.logCounter)
local GetAllUserOffersFailedCounter = require(InExperienceOffers.Events.GetAllUserOffersFailedCounter)
local _Types = require(InExperienceOffers.Types)

local var1 = Url.APIS_URL .. "checkout/v1/offers"

local function buildUserOffersUrl(tbl1): string -- Luacid: Inlined by compiler; 1 call site recovered
    local var2 = Url:makeQueryString({ featureKeys = table.concat(tbl1, ",") })

    return `{var1}?{var2}`
end

local function getAllUserOffers(tbl1)
    return Promise.new(function(callback, callback2)
        local function rejectFetch(arg1) -- Luacid: Inlined by compiler; 3 call sites recovered
            local tbl2 = {
                errorKind = arg1.kind
            }
            logCounter(GetAllUserOffersFailedCounter, 1, tbl2)
            callback2(arg1)
        end

        task.spawn(function()
            local userOffersUrl = buildUserOffersUrl(tbl1)

            OffersDebugLogger.logLazy(function(): string
                return "getAllUserOffers: GET " .. userOffersUrl
            end)
            local var2 = OffersDebugLogger.startTimer()

            local success, result = pcall(function(): string
                return HttpRbxApiService:GetAsyncFullUrl(userOffersUrl)
            end)
            if not success then
                OffersDebugLogger.logElapsed("getAllUserOffers: HTTP error", var2)
                OffersDebugLogger.logLazy(function(): string
                    return "getAllUserOffers: HTTP error detail=" .. tostring(result)
                end)
                rejectFetch((Errors.networkError("getAllUserOffers: HTTP request failed", result)))
                return
            end

            OffersDebugLogger.logElapsed("getAllUserOffers: HTTP response received", var2)

            local success2, result2 = pcall(function()
                return HttpService:JSONDecode(result)
            end)
            if not success2 then
                OffersDebugLogger.logLazy(function(): string
                    return "getAllUserOffers: JSON parse error=" .. tostring(result2)
                end)

                rejectFetch((Errors.parseError("getAllUserOffers: response body is not valid JSON", result2)))
            elseif typeof(result2) ~= "table" or typeof(result2.offers) ~= "table" then
                OffersDebugLogger.log("getAllUserOffers: schema error, missing offers")

                rejectFetch((Errors.schemaError("getAllUserOffers: malformed response, expected { offers = ... }", result2)))
            else
                callback(result2)
            end
        end)
    end)
end
return getAllUserOffers

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:01:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpRbxApiService = game:GetService("HttpRbxApiService")
local HttpService = game:GetService("HttpService")

local InExperienceShop = script:FindFirstAncestor("InExperienceShop")
local InExperienceShopParent = InExperienceShop.Parent

local Promise = require(InExperienceShopParent.Promise)
local Http = require(InExperienceShopParent.Http)
local Url = Http.Url
local requestInternalWrapper = Http.NetworkLayers.requestInternalWrapper
local _Types = require(InExperienceShop.Types)
local Errors = require(script.Parent.Errors)
local ShopDebugLogger = require(InExperienceShop.Internal.ShopDebugLogger)
local FFlagUseShopRequestImpl = require(InExperienceShop.Flags.FFlagUseShopRequestImpl)
local FIntExperienceShopWidgetRequestPriority = require(InExperienceShop.Flags.FIntExperienceShopWidgetRequestPriority)
local FFlagSkipShopWidgetsCallInUnpublishedStudio = require(InExperienceShop.Flags.FFlagSkipShopWidgetsCallInUnpublishedStudio)
local RunService = game:GetService("RunService")

local var1 = Url.APIS_URL .. "marketplace-widgets/v1/widgets/shop-widgets"

local function buildShopWidgetsUrl(requestId: string): string -- Luacid: Inlined by compiler; 2 call sites recovered
    local var2 = Url:makeQueryString({ requestId = requestId, universeId = game.GameId })

    return `{var1}?{var2}`
end

local function logSuccess(tbl1) -- Luacid: Inlined by compiler; 1 call site recovered
    ShopDebugLogger.logLazy(function(): string
        return "fetchShopItemIds: success categories=" .. (typeof(tbl1.categories) == "table" and #tbl1.categories or 0)
    end)
end

local function validateAndResolve(arg1, callback: (...any) -> (...any), callback2: (...any) -> (...any)): boolean
    if typeof(arg1) ~= "table" or arg1.categories == nil then
        ShopDebugLogger.log("fetchShopItemIds: schema error, missing categories field")
        callback2((Errors.schemaError("fetchShopItemIds: malformed response, expected { categories = ... }", arg1)))

        return false
    end

    logSuccess(arg1)
    callback(arg1)
    return true
end

local function fetchShopItemIdsViaGetAsyncFullUrl(requestId: string)
    return Promise.new(function(arg1, callback)
        task.spawn(function()
            local shopWidgetsUrl = buildShopWidgetsUrl(requestId)

            ShopDebugLogger.logLazy(function(): string
                return "fetchShopItemIds: GET " .. shopWidgetsUrl
            end)
            local var2 = ShopDebugLogger.startTimer()

            local success, result = pcall(function(): string
                return HttpRbxApiService:GetAsyncFullUrl(shopWidgetsUrl)
            end)
            if not success then
                ShopDebugLogger.logElapsed("fetchShopItemIds: HTTP error", var2)
                ShopDebugLogger.logLazy(function(): string
                    return "fetchShopItemIds: HTTP error detail=" .. tostring(result)
                end)
                callback((Errors.networkError("fetchShopItemIds: HTTP request failed", result)))
                return
            end

            ShopDebugLogger.logElapsed("fetchShopItemIds: HTTP response received", var2)

            local success2, result2 = pcall(function()
                return HttpService:JSONDecode(result)
            end)
            if success2 then
                validateAndResolve(result2, arg1, callback)
                return
            end

            ShopDebugLogger.logLazy(function(): string
                return "fetchShopItemIds: JSON parse error=" .. tostring(result2)
            end)
            callback((Errors.parseError("fetchShopItemIds: response body is not valid JSON", result2)))
        end)
    end)
end

local function fetchShopItemIdsViaRequestImpl(requestId: string)
    local shopWidgetsUrl = buildShopWidgetsUrl(requestId)

    ShopDebugLogger.logLazy(function(): string
        return "fetchShopItemIds: GET " .. shopWidgetsUrl
    end)
    local var2 = ShopDebugLogger.startTimer()

    return requestInternalWrapper(HttpService)(
        shopWidgetsUrl,
        "GET",
        FIntExperienceShopWidgetRequestPriority ~= 0 and {
            priority = FIntExperienceShopWidgetRequestPriority
        } or nil
    ):andThen(
        function(arg1)
            ShopDebugLogger.logElapsed("fetchShopItemIds: HTTP response received", var2)
            return Promise.new(function(callback, arg2)
                validateAndResolve(arg1.responseBody, callback, arg2)
            end)
        end
    ):catch(
        function(arg1)
            if typeof(arg1) == "table" and arg1.kind ~= nil then
                return Promise.reject(arg1)
            end

            if typeof(arg1) == "table" and arg1.isJSONValid == false then
                ShopDebugLogger.logLazy(function(): string
                    return "fetchShopItemIds: JSON parse error=" .. tostring(arg1)
                end)
                return Promise.reject((Errors.parseError("fetchShopItemIds: response body is not valid JSON", arg1)))
            end

            ShopDebugLogger.logElapsed("fetchShopItemIds: HTTP error", var2)
            ShopDebugLogger.logLazy(function(): string
                return "fetchShopItemIds: HTTP error detail=" .. tostring(arg1)
            end)
            return Promise.reject((Errors.networkError("fetchShopItemIds: HTTP request failed", arg1)))
        end
    )
end

local function fetchShopItemIds(requestId: string)
    if FFlagSkipShopWidgetsCallInUnpublishedStudio and RunService:IsStudio() and game.GameId == 0 then
        ShopDebugLogger.logLazy(function(): string
            return "fetchShopItemIds: skipped unpublished Studio experience requestId=" .. requestId
        end)
        return Promise.resolve({ categories = {} })
    elseif FFlagUseShopRequestImpl then
        ShopDebugLogger.logLazy(function(): string
            local str1 = if FIntExperienceShopWidgetRequestPriority == 0 then "" else ` priority={FIntExperienceShopWidgetRequestPriority}`

            return `fetchShopItemIds: transport=requestInternalWrapper requestId={requestId}{str1}`
        end)
        return fetchShopItemIdsViaRequestImpl(requestId)
    else
        ShopDebugLogger.logLazy(function(): string
            return `fetchShopItemIds: transport=GetAsyncFullUrl requestId={requestId}`
        end)
        return fetchShopItemIdsViaGetAsyncFullUrl(requestId)
    end
end
return fetchShopItemIds

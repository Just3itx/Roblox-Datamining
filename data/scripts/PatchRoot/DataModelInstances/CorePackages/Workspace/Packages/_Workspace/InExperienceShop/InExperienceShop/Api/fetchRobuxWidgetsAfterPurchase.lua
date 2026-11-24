-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:00:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpRbxApiService = game:GetService("HttpRbxApiService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")

local InExperienceShop = script:FindFirstAncestor("InExperienceShop")
local InExperienceShopParent = InExperienceShop.Parent

local Promise = require(InExperienceShopParent.Promise)
local Http = require(InExperienceShopParent.Http)
local Url = Http.Url
local requestInternalWrapper = Http.NetworkLayers.requestInternalWrapper
local Constants = require(InExperienceShop.Constants)
local _Types = require(InExperienceShop.Types)
local Errors = require(script.Parent.Errors)
local multiGetProductInfo = require(script.Parent.multiGetProductInfo)
local buildShopDataFromWidgets = require(script.Parent.buildShopDataFromWidgets)
local ShopDebugLogger = require(InExperienceShop.Internal.ShopDebugLogger)
local FFlagUseShopRequestImpl = require(InExperienceShop.Flags.FFlagUseShopRequestImpl)
local FIntExperienceShopWidgetRequestPriority = require(InExperienceShop.Flags.FIntExperienceShopWidgetRequestPriority)
local FFlagSkipShopWidgetsCallInUnpublishedStudio = require(InExperienceShop.Flags.FFlagSkipShopWidgetsCallInUnpublishedStudio)

local ROBUX_CATEGORY_NAME = Constants.ROBUX_CATEGORY_NAME
local var1 = Url.APIS_URL .. "marketplace-widgets/v1/widgets/robux-widget"

local EMPTY_SHOP_DATA = {
    categories = {},
    sections = {},
    failedItems = {}
}

local function buildRobuxWidgetUrl(requestId: string): string -- Luacid: Inlined by compiler; 2 call sites recovered
    local var2 = Url:makeQueryString({ requestId = requestId, universeId = game.GameId })

    return `{var1}?{var2}`
end

local function validateAndResolve(arg1, callback: (...any) -> (...any), callback2: (...any) -> (...any)): boolean
    if typeof(arg1) ~= "table" then
        callback2((Errors.schemaError("fetchRobuxWidgetsAfterPurchase: malformed response, expected { category = ... }", arg1)))

        return false
    elseif arg1.category ~= nil and typeof(arg1.category) ~= "table" then
        callback2((Errors.schemaError("fetchRobuxWidgetsAfterPurchase: malformed response, category must be a table", arg1)))

        return false
    else
        callback(arg1)
        return true
    end
end

local function buildFromWidgetResponse(arg1, arg2)
    local category = arg1.category
    if category == nil then
        return Promise.resolve(EMPTY_SHOP_DATA)
    end

    local items = {}
    for _, item in ipairs(category.items) do
        if item.type == "Robux" then
            table.insert(items, item)
        end
    end

    local tbl3 = {
        categories = {{
            id = category.id,
            name = ROBUX_CATEGORY_NAME,
            items = items,
            metadata = category.metadata
        }}
    }
    return buildShopDataFromWidgets(tbl3, arg2)
end

local function fetchViaGetAsyncFullUrl(requestId: string)
    return Promise.new(function(arg1, callback)
        task.spawn(function()
            local robuxWidgetUrl = buildRobuxWidgetUrl(requestId)
            ShopDebugLogger.logLazy(function(): string
                return "fetchRobuxWidgetsAfterPurchase: GET " .. robuxWidgetUrl
            end)
            local var2 = ShopDebugLogger.startTimer()
            local success, result = pcall(function(): string
                return HttpRbxApiService:GetAsyncFullUrl(robuxWidgetUrl)
            end)
            if not success then
                ShopDebugLogger.logElapsed("fetchRobuxWidgetsAfterPurchase: HTTP error", var2)
                callback((Errors.networkError("fetchRobuxWidgetsAfterPurchase: HTTP request failed", result)))

                return
            end

            ShopDebugLogger.logElapsed("fetchRobuxWidgetsAfterPurchase: HTTP response received", var2)
            local success2, result2 = pcall(function()
                return HttpService:JSONDecode(result)
            end)
            if not success2 then
                callback((Errors.parseError("fetchRobuxWidgetsAfterPurchase: response body is not valid JSON", result2)))

                return
            end
            validateAndResolve(result2, arg1, callback)
        end)
    end)
end

local function fetchViaRequestImpl(requestId: string)
    local robuxWidgetUrl = buildRobuxWidgetUrl(requestId)

    ShopDebugLogger.logLazy(function(): string
        return "fetchRobuxWidgetsAfterPurchase: GET " .. robuxWidgetUrl
    end)
    local var2 = ShopDebugLogger.startTimer()
    return requestInternalWrapper(HttpService)(
        robuxWidgetUrl,
        "GET",
        FIntExperienceShopWidgetRequestPriority ~= 0 and {
            priority = FIntExperienceShopWidgetRequestPriority
        } or nil
    ):andThen(
        function(arg1)
            ShopDebugLogger.logElapsed("fetchRobuxWidgetsAfterPurchase: HTTP response received", var2)
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
                return Promise.reject((Errors.parseError("fetchRobuxWidgetsAfterPurchase: response body is not valid JSON", arg1)))
            end

            ShopDebugLogger.logElapsed("fetchRobuxWidgetsAfterPurchase: HTTP error", var2)
            return Promise.reject((Errors.networkError("fetchRobuxWidgetsAfterPurchase: HTTP request failed", arg1)))
        end
    )
end

local function fetchRobuxWidget(requestId: string)
    if FFlagSkipShopWidgetsCallInUnpublishedStudio and RunService:IsStudio() and game.GameId == 0 then
        ShopDebugLogger.logLazy(function(): string
            return "fetchRobuxWidgetsAfterPurchase: skipped unpublished Studio requestId=" .. requestId
        end)
        return Promise.resolve({})
    elseif FFlagUseShopRequestImpl then
        return fetchViaRequestImpl(requestId)
    else
        return fetchViaGetAsyncFullUrl(requestId)
    end
end

return {
    fetchRobuxWidgetsAfterPurchase = function()
        local str1 = HttpService:GenerateGUID(false)
        ShopDebugLogger.logLazy(function(): string
            return "fetchRobuxWidgetsAfterPurchase: start requestId=" .. str1
        end)
        return fetchRobuxWidget(str1):andThen(function(arg1)
            return buildFromWidgetResponse(arg1, multiGetProductInfo)
        end)
    end,
    buildFromWidgetResponse = buildFromWidgetResponse,
    EMPTY_SHOP_DATA = EMPTY_SHOP_DATA
}

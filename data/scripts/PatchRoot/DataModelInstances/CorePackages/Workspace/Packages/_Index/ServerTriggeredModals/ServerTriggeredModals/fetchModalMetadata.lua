-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T15:31:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerTriggeredModals = script:FindFirstAncestor("ServerTriggeredModals")
local ServerTriggeredModalsParent = ServerTriggeredModals.Parent

local DeepLink = require(ServerTriggeredModalsParent.DeepLink)
local UrlBuilder = require(ServerTriggeredModalsParent.UrlBuilder).UrlBuilder
local UrlBase = require(ServerTriggeredModalsParent.UrlBuilder).UrlBase
local Promise = require(ServerTriggeredModalsParent.Promise)
local SharedFlags = require(ServerTriggeredModalsParent.SharedFlags)
local t = require(ServerTriggeredModalsParent.t)
local validateSduiComponentConfig = require(ServerTriggeredModalsParent.ServerDrivenUi).validateSduiComponentConfig

local _EntryPoint = require(ServerTriggeredModals.EntryPoint)
local logResponseStatus = require(ServerTriggeredModals.logResponseStatus)
local logResponseLatency = require(ServerTriggeredModals.logResponseLatency)
local _createModalSignalStore = require(ServerTriggeredModals.SignalStores.createModalSignalStore)
local getModalSignalStore = require(ServerTriggeredModals.SignalStores.getModalSignalStore)

local FFlagLuaAppSupportNonSduiTypeForServerTriggeredModals = SharedFlags.FFlagLuaAppSupportNonSduiTypeForServerTriggeredModals
local FFlagEnableDeepLinkHistoryWithModalAPI = SharedFlags.FFlagEnableDeepLinkHistoryWithModalAPI

local var1 = t.interface({
    modalId = t.string,
    modalType = t.string,
    sdui = if FFlagLuaAppSupportNonSduiTypeForServerTriggeredModals then t.optional(t.table) else t.table,
    isCustomHandler = if FFlagLuaAppSupportNonSduiTypeForServerTriggeredModals then t.optional(t.boolean) else nil
})

local tbl1 = ({})

local function getModalMetadataUrl(entryPoint)
    local bool1

    if FFlagEnableDeepLinkHistoryWithModalAPI then
        local var2 = DeepLink.DeepLinkLuaReceiverStatusStore(false).getLastDetectedPostAuthUrl(false)
        if var2 == nil then
            bool1 = false
        else
            bool1 = var2 ~= ""
        end
    else
        bool1 = nil
    end
    return UrlBuilder.new({
        base = UrlBase.APIS,
        path = "modals-api/v1/modal",
        query = {
            entryPoint = entryPoint,
            hasDetectedDeepLink = if FFlagEnableDeepLinkHistoryWithModalAPI then tostring(bool1) else nil
        }
    })()
end

local function parseResponseToMetadata(responseBody)
    local var2, errorMessage = var1(responseBody)
    if not var2 then
        return { metadata = nil, errorMessage = errorMessage }
    end

    local isCustomHandler = if FFlagLuaAppSupportNonSduiTypeForServerTriggeredModals then responseBody and responseBody.isCustomHandler else false

    if not (FFlagLuaAppSupportNonSduiTypeForServerTriggeredModals and isCustomHandler) then
        local var4, var5 = validateSduiComponentConfig(responseBody.sdui)
        if not var4 then
            return {
                metadata = nil,
                errorMessage = if var5 and var5.message then var5.message else "Invalid sdui config"
            }
        end
    end
    return {
        metadata = {
            modalId = responseBody.modalId,
            modalType = responseBody.modalType,
            sduiConfig = responseBody.sdui,
            isCustomHandler = if FFlagLuaAppSupportNonSduiTypeForServerTriggeredModals then responseBody.isCustomHandler else nil
        },
        errorMessage = nil
    }
end

return function(arg1, entryPoint)
    local modalSignalStore = getModalSignalStore(false)
    local var2 = modalSignalStore.getMetadataGetter(entryPoint)(false)
    if var2 ~= nil then
        return Promise.resolve(var2)
    end

    local var3 = tbl1[entryPoint]
    if var3 then
        return var3
    end
    local modalMetadataUrl = getModalMetadataUrl(entryPoint)

    local promise = Promise.new(function(callback, callback2, callback3)
        local var4 = arg1(modalMetadataUrl, "GET")

        var4:andThen(function(arg2)
            local responseCode = if arg2 then arg2.responseCode or nil else nil
            logResponseLatency("modals-api/v1/modal", arg2.responseTimeMs, responseCode)
            if responseCode ~= 200 then
                callback2(`Unexpected responseCode when fetching metadata: {responseCode}`)
                return
            end

            local var5 = parseResponseToMetadata(arg2.responseBody)
            if not var5.metadata then
                callback2(`Failed to parse modal metadata response: {var5.errorMessage}`)
                return
            end

            modalSignalStore.setMetadata(entryPoint, var5.metadata)
            callback(var5)
        end):catch(function(arg2)
            logResponseStatus("modals-api/v1/modal", arg2.StatusCode)
            callback2(`Failed to fetch modal metadata: {arg2}`)
        end)

        callback3(function()
            var4:cancel()
        end)
    end)
    tbl1[entryPoint] = promise

    promise:finally(function()
        assert(tbl1[entryPoint] == promise, "In-flight request promise mismatch")
        tbl1[entryPoint] = nil
    end)

    return promise
end

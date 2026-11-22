-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T15:40:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local ServerTriggeredModals = script:FindFirstAncestor("ServerTriggeredModals")
local ServerTriggeredModalsParent = ServerTriggeredModals.Parent

local UrlBuilder = require(ServerTriggeredModalsParent.UrlBuilder).UrlBuilder
local UrlBase = require(ServerTriggeredModalsParent.UrlBuilder).UrlBase

local Logger = require(ServerTriggeredModals.Logger)
local logResponseStatus = require(ServerTriggeredModals.logResponseStatus)
local logResponseLatency = require(ServerTriggeredModals.logResponseLatency)

local urlBuilder = UrlBuilder.new({ base = UrlBase.APIS, path = "modals-api/v1/impression" })

return function(arg1, modalId: string, modalType: string)
    if not arg1 then
        Logger:error("Missing networking implementation")
        return
    end

    local success, result = pcall(function()
        local var1 = urlBuilder()
        local postBody = HttpService:JSONEncode({ modalId = modalId, modalType = modalType })
        return arg1(var1, "POST", { postBody = postBody })
    end)
    if not success then
        Logger:error(`Report impression request failed to start: {result}`)
        return
    end

    result:andThen(function(arg2)
        local responseCode = if arg2 then arg2.responseCode or nil else nil
        logResponseLatency("modals-api/v1/impression", arg2.responseTimeMs, responseCode)
        if responseCode ~= nil and responseCode ~= 200 then
            Logger:error(`Unexpected responseCode when reporting impression: {responseCode}`)
        end
    end):catch(function(arg2)
        logResponseStatus("modals-api/v1/impression", arg2.StatusCode)
        Logger:error(`Report Impression request error: {arg2}`)
    end)
end

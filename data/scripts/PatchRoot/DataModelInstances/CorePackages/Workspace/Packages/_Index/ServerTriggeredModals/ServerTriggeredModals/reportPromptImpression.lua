-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T15:40:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local ServerTriggeredModals = script:FindFirstAncestor("ServerTriggeredModals")
local ServerTriggeredModalsParent = ServerTriggeredModals.Parent

local Promise = require(ServerTriggeredModalsParent.Promise)
local Logger = require(ServerTriggeredModals.Logger)
local logResponseStatus = require(ServerTriggeredModals.logResponseStatus)
local logResponseLatency = require(ServerTriggeredModals.logResponseLatency)

local FFlagServerTriggeredModalsAccepts2xxImpressionResponses = require(ServerTriggeredModals.Flags.FFlagServerTriggeredModalsAccepts2xxImpressionResponses)

local UrlBuilder = require(ServerTriggeredModalsParent.UrlBuilder).UrlBuilder
local UrlBase = require(ServerTriggeredModalsParent.UrlBuilder).UrlBase

local urlBuilder = UrlBuilder.new({ base = UrlBase.APIS, path = "modals-api/v1/prompts/impression" })

return function(promptType: string, promptId: string?)
    local url = urlBuilder()
    local body = HttpService:JSONEncode({ promptType = promptType, promptId = promptId })

    local var2 = HttpService:RequestInternal(
        {
            Url = url,
            Method = "POST",
            Headers = { ["Content-Type"] = "application/json" },
            Body = body
        }
    )
    return Promise.new(function(callback, callback2)
        var2:Start(function(arg1, arg2)
            local statusCode = arg2 and arg2.StatusCode
            if FFlagServerTriggeredModalsAccepts2xxImpressionResponses then
                if arg1 then
                    if statusCode == nil or not (statusCode >= 200) then
                        arg1 = false
                    else
                        arg1 = statusCode < 300
                    end
                end
            else
                arg1 = arg1 and statusCode == 200
            end

            if not arg1 then
                logResponseStatus("modals-api/v1/prompts/impression", statusCode)
                Logger:error(`Report Prompt Impression request error with status code: {statusCode}`)
                callback2()
                return
            end

            local roundTripTime = arg2 and arg2.Stats and arg2.Stats.RoundTripTime
            local var3 = roundTripTime and roundTripTime * 1000
            if var3 then
                logResponseLatency("modals-api/v1/prompts/impression", var3, statusCode)
            end
            callback()
        end)
    end)
end

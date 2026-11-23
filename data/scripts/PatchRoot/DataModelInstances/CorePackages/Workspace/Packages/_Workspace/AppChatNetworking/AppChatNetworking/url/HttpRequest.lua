-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T12:11:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local AppChatNetworking = script:FindFirstAncestor("AppChatNetworking")
local AppChatNetworkingParent = AppChatNetworking.Parent
local HttpRequest = require(AppChatNetworkingParent.HttpRequest)

local FFlagLuaAppDefaultHttpRetry = require(AppChatNetworkingParent.SharedFlags).FFlagLuaAppDefaultHttpRetry
local logger = require(AppChatNetworkingParent.Loggers).Logger:new("AppChat.Networking")
local AppChatNetworkingTelemetry = require(AppChatNetworking.analytics.AppChatNetworkingTelemetry)

local getFFlagDebugUnfilteredThreads = require(AppChatNetworkingParent.SharedFlags).getFFlagDebugUnfilteredThreads
local ChallengeRequestWrapper = require(AppChatNetworkingParent.GenericChallenges).Middleware.ChallengeRequestWrapper

local var2 = require(AppChatNetworkingParent.SocialLuaAnalytics).Telemetry.new({
    name = "AppChat.NetworkResponse",
    description = "Event when a response is received from AppChat's networking layer",
    lastUpdated = { 2024, 10, 18 },
    backendsList = {{
        type = "RobloxTelemetryCounter",
        format = function(tbl1)
            local var2 = string.match(tbl1.url, ".%w+/(.*)")

            return {
                endpoint = string.match(var2 or "", "([^?#]+)") or "unknown",
                statusCode = tostring(tbl1.statusCode),
                isOK = tbl1.isOK
            }
        end
    }}
})

local function chunkAndLogString(str1: string)
    local tbl1 = {}
    for i = 1, #str1, 800 do
        local num1 = i + 800 - 1
        table.insert(tbl1, str1:sub(i, num1))
    end
    for _, value in tbl1 do
        logger:debug(value)
    end
end

local config = HttpRequest.config

local tbl1 = {
    requestFunction = function(arg1, arg2, arg3)
        logger:info(`Fetching: [ requestMethod = "{arg2}", url = "{arg1}" ]`)
        if getFFlagDebugUnfilteredThreads() then
            local var3 = not arg3 and {} or arg3.postBody or {}
            if string.find(arg1, "get%-conversations") then
                local str1 = ""

                for _, value in var3.ids or {} do
                    str1 = `{str1}, {value}`
                end
                chunkAndLogString(`FETCHING CONVERSATIONS{str1}`)
            elseif string.find(arg1, "get%-modal%-sequence") then
                local var4 = var3.conversation_id or var3.friend_id
                logger:debug(`FETCHING MODAL SEQUENCE sequence: {var3.modal_sequence} id: {var4}`)
            elseif string.find(arg1, "record%-modal%-sequence%-response") then
                local modalId = var3.modal_id
                local modalVariant = var3.modal_variant
                local var4 = var3.conversation_id or var3.friend_id
                logger:debug(
                    `RECORDING MODAL SEQUENCE RESPONSE action: {var3.action_type} sequence: {var3.modal_sequence} id: {modalId} variant: {modalVariant} conversationId: {var4}`
                )
            end
        end
        return HttpRequest.requestFunctions.RequestInternal(arg1, arg2, arg3)
    end,
    postRequestFunction = function(arg1, arg2)
        logger:debug(
            `Returned: [ requestMethod = "{arg2.requestMethod}", url = "{arg2.url}", statusCode = {arg1.StatusCode}{if arg1.HttpError == Enum.HttpError.OK then "" else `, HttpError = {arg1.HttpError}` or ""}]`
        )

        AppChatNetworkingTelemetry.emit(
            var2,
            {
                url = arg2.url,
                statusCode = arg1.StatusCode,
                isOK = arg1.HttpError == Enum.HttpError.OK
            }
        )
        if not getFFlagDebugUnfilteredThreads() then
            return
        end

        local success, result = pcall(function()
            return HttpService:JSONDecode(arg1.Body)
        end)
        if not success then
            return
        end
        local var3 = arg2.options and arg2.options.postBody and (arg2.options.postBody.conversation_id or arg2.options.postBody.friend_id)

        if string.find(arg2.url, "get%-user%-conversations") or string.find(arg2.url, "get%-conversations") then
            local str1 = ""

            for _, value in result and result.conversations or {} do
                str1 = `{str1}, {value.id} {value.moderation_type} {value.user_pending_status}`
            end
            chunkAndLogString(`RETURNED CONVERSATIONS{str1}`)
            return
        end

        if string.find(arg2.url, "get%-modal%-sequence") then
            local modalVariant = result and result.modal_variant
            local modalSequence = arg2.options and arg2.options.postBody and arg2.options.postBody.modal_sequence
            logger:debug(
                `RETURNED MODAL VARIANT sequence: {modalSequence} variant: {modalVariant} conversationId: {var3}`
            )
        end
    end,
    maxRetryCount = if FFlagLuaAppDefaultHttpRetry then game:DefineFastInt("AppChatNetworkingHttpRetryCount", 4) else nil
}

return {
    default = ChallengeRequestWrapper((config(tbl1))),
    logger = logger
}

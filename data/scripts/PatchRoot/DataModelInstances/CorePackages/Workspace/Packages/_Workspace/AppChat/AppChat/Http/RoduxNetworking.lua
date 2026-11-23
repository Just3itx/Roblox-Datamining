-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:50:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local FFlagLuaAppDefaultHttpRetry = require(AppChatParent.SharedFlags).FFlagLuaAppDefaultHttpRetry
local HttpRequest = require(AppChatParent.HttpRequest)
local RoduxNetworking = require(AppChatParent.RoduxNetworking)

local Logger = require(AppChatParent.Loggers).Logger
local logger = Logger.new(Logger, "AppChat")

return RoduxNetworking.config({
    keyPath = "ChatAppReducer.networkStatus",
    networkImpl = HttpRequest.config({
        requestFunction = function(arg1, arg2, arg3)
            logger:info("Fetching: {}", string.format("[ requestMethod = %q, url = %q ]", arg2, arg1))
            return HttpRequest.requestFunctions.HttpRbxApi(arg1, arg2, arg3)
        end,
        postRequestFunction = function(arg1, arg2)
            logger:debug(
                "Returned: {}",
                string.format("[ requestMethod = %q, url = %q, statusCode = %s ]", arg2.requestMethod, arg2.url, arg1.StatusCode)
            )
        end,
        maxRetryCount = if FFlagLuaAppDefaultHttpRetry then game:DefineFastInt("AppChatRoduxNetworkingHttpRetryCount", 4) else nil
    }),
    killRequestWithFilteredIds = true
})

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T18:01:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SquadsCoreParent = script:FindFirstAncestor("SquadsCore").Parent

local HttpRequest = require(SquadsCoreParent.HttpRequest)
local RoduxNetworking = require(SquadsCoreParent.RoduxNetworking)

local Logger = require(SquadsCoreParent.Loggers).Logger
local logger = Logger.new(Logger, "SquadsCore")

local maxRetryCount = game:DefineFastInt("SquadHttpRetryCount", 3)

return RoduxNetworking.config({
    keyPath = "Squad.NetworkStatus",
    networkImpl = HttpRequest.config({
        requestFunction = function(arg1, arg2, arg3)
            logger:info("Fetching: {}", string.format("[ requestMethod = %q, url = %q ]", arg2, arg1))
            return HttpRequest.requestFunctions.RequestInternal(arg1, arg2, arg3)
        end,
        postRequestFunction = function(arg1, arg2)
            logger:debug(
                "Returned: {}",
                string.format(
                    "[ requestMethod = %q, url = %q, statusCode = %s, body = %s ]",
                    arg2.requestMethod,
                    arg2.url,
                    arg1.StatusCode,
                    arg1.Body
                )
            )
        end,
        maxRetryCount = maxRetryCount
    })
})

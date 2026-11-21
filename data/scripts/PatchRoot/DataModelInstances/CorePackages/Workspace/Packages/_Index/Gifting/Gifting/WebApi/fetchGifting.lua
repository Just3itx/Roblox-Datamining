-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T23:31:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local Gifting = script:FindFirstAncestor("Gifting")
local GiftingParent = Gifting.Parent

local HttpClient = require(GiftingParent.HttpClient)
local Promise = require(GiftingParent.Promise)

local GiftErrorModel = require(Gifting.Models.GiftErrorModel)
local _Types = require(Gifting.Types)

local fetch = HttpClient.fetch
local asPromise = HttpClient.asPromise

local tbl1 = {
    400,
    403,
    404,
    503
}

local function decodeErrorBody(arg1)
    local responseBody = arg1.responseBody
    if typeof(responseBody) == "buffer" then
        responseBody = buffer.tostring(responseBody)
    end

    if responseBody == nil or responseBody == "" then
        return {}
    end

    local success, result = pcall(HttpService.JSONDecode, HttpService, responseBody)
    return if success and type(result) == "table" then result else {}
end

local function fetchGifting(tbl2)
    local var1 = nil

    local function captureGiftError(arg1)
        var1 = GiftErrorModel.format(decodeErrorBody(arg1), arg1.statusCode)
    end

    local statusCodeActions = ({})
    for _, value in tbl1 do
        statusCodeActions[value] = { captureGiftError }
    end

    local var2 = fetch({
        network = tbl2.network,
        retry = false,
        method = tbl2.method,
        url = tbl2.url,
        body = tbl2.body,
        analyticsKey = tbl2.analyticsKey,
        decode = function(arg1)
            local var2, var3 = tbl2.decode(arg1)
            if var2 == nil then
                error(var3 or "malformed response", 0)
            end
            return var2
        end,
        statusCodeActions = statusCodeActions
    })

    return asPromise(var2):catch(function(arg1)
        return Promise.reject(var1 or GiftErrorModel.format({}, arg1.responseCode, arg1.errorMessage))
    end)
end

return fetchGifting

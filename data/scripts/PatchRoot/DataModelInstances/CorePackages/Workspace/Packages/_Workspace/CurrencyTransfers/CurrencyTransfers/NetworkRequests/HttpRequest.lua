-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:41:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CurrencyTransfers = script:FindFirstAncestor("CurrencyTransfers")
local CurrencyTransfersParent = CurrencyTransfers.Parent

local HttpService = game:GetService("HttpService")
local Promise = require(CurrencyTransfersParent.Promise)
local ErrorTransferModel = require(CurrencyTransfers.Models.ErrorTransferModel)

local module = {}
module.__index = module

function module.new(http)
    local self = setmetatable({}, module)
    self.http = http or game:GetService("HttpService")
    self.networkImpl = nil
    return self
end

function module.fromNetworkImpl(networkImpl)
    local self = setmetatable({}, module)
    self.http = nil
    self.networkImpl = networkImpl
    return self
end

local function rejectFromNetworkImpl(callback, arg1)
    local statusCode = arg1 and arg1.StatusCode or 0
    local body = arg1 and arg1.Body
    local var1 = nil
    if type(body) == "table" then
        var1 = body
    elseif type(body) == "string" and body ~= "" then
        local success, result = pcall(HttpService.JSONDecode, HttpService, body)
        if success then
            var1 = result
        end
    end

    if var1 then
        callback(ErrorTransferModel.format(var1))
        return
    end
    callback({ status = statusCode, body = body })
end

function module:get(url)
    if self.networkImpl then
        return Promise.new(function(callback, arg1)
            self.networkImpl(url, "GET", { headers = { Accept = "application/json" } }):andThen(function(arg2)
                callback(arg2.responseBody)
            end, function(arg2)
                rejectFromNetworkImpl(arg1, arg2)
            end)
        end)
    end

    return Promise.new(function(callback, callback2)
        self.http:RequestInternal({ Url = url, Method = "GET", Headers = { Accept = "application/json" } }):Start(function(_, arg1)
            if arg1.StatusCode == 200 then
                callback(self.http:JSONDecode(arg1.Body))
                return
            end

            if arg1.StatusCode ~= 400 and arg1.StatusCode ~= 403 then
                callback2({ status = arg1.StatusCode, body = arg1.Body })
                return
            end

            local var1 = if arg1.Body and arg1.Body ~= "" then self.http:JSONDecode(arg1.Body) else nil

            if var1 then
                local var2 = ErrorTransferModel.format(var1)
                callback2(var2)
                return
            end
            callback2({ status = arg1.StatusCode, body = arg1.Body })
        end)
    end)
end

function module:post(url, input)
    if self.networkImpl then
        return Promise.new(function(callback, arg1)
            self.networkImpl(url, "POST", {
                headers = { ["Content-Type"] = "application/json", Accept = "application/json" },
                postBody = HttpService:JSONEncode(input)
            }):andThen(
                function(arg2)
                    callback(arg2.responseBody)
                end,
                function(arg2)
                    rejectFromNetworkImpl(arg1, arg2)
                end
            )
        end)
    end
    return Promise.new(function(callback, callback2)
        self.http:RequestInternal({
            Url = url,
            Method = "POST",
            Headers = { ["Content-Type"] = "application/json", Accept = "application/json" },
            Body = self.http:JSONEncode(input)
        }):Start(
            function(_, arg1)
                if arg1.StatusCode == 200 then
                    callback(self.http:JSONDecode(arg1.Body))
                    return
                end

                if arg1.StatusCode ~= 400 and arg1.StatusCode ~= 403 then
                    callback2({ status = arg1.StatusCode, body = arg1.Body })
                    return
                end

                local var1 = if arg1.Body and arg1.Body ~= "" then self.http:JSONDecode(arg1.Body) else nil

                if var1 then
                    local var2 = ErrorTransferModel.format(var1)
                    callback2(var2)
                    return
                end
                callback2({ status = arg1.StatusCode, body = arg1.Body })
            end
        )
    end)
end

return module

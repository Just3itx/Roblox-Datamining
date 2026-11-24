-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:41:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CurrencyTransfers = script:FindFirstAncestor("CurrencyTransfers")
local CurrencyTransfersParent = CurrencyTransfers.Parent

local UrlBuilder = require(CurrencyTransfersParent.UrlBuilder)
local t = require(CurrencyTransfersParent.t)
local Promise = require(CurrencyTransfersParent.Promise)

local GetTransferByIdModel = require(CurrencyTransfers.Models.GetTransferByIdModel)
local HttpRequest = require(CurrencyTransfers.NetworkRequests.HttpRequest)

local UrlBuilder2 = UrlBuilder.UrlBuilder
local UrlBase = UrlBuilder.UrlBase

local function getTransferByIdUrl(transferRequestId: string)
    return UrlBuilder2.new({ base = UrlBase.APIS, path = `transfer/v1/robux-transfer/transfer/{transferRequestId}` })()
end

local var1 = t.strictInterface({ transferRequestId = t.string })

local function getTransferRequestByIdRequest(arg1, arg2, arg3)
    assert(var1(arg1))
    local var2 = if arg3 ~= nil then HttpRequest.fromNetworkImpl(arg3) else HttpRequest.new(arg2)

    return var2:get(getTransferByIdUrl(arg1.transferRequestId)):andThen(function(arg4)
        return GetTransferByIdModel.format(arg4)
    end):catch(function(arg4)
        return Promise.reject(arg4)
    end)
end

return getTransferRequestByIdRequest

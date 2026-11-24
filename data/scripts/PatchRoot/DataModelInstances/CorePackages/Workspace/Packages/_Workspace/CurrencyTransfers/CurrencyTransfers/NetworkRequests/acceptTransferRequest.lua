-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:41:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CurrencyTransfers = script:FindFirstAncestor("CurrencyTransfers")
local CurrencyTransfersParent = CurrencyTransfers.Parent

local UrlBuilder = require(CurrencyTransfersParent.UrlBuilder)
local t = require(CurrencyTransfersParent.t)
local Promise = require(CurrencyTransfersParent.Promise)

local AcceptTransferModel = require(CurrencyTransfers.Models.AcceptTransferModel)
local HttpRequest = require(CurrencyTransfers.NetworkRequests.HttpRequest)

local UrlBuilder2 = UrlBuilder.UrlBuilder
local UrlBase = UrlBuilder.UrlBase

local function acceptTransferUrl(transferRequestId: string) -- Luacid: Inlined by compiler; 1 call site recovered
    return UrlBuilder2.new(
        {
            base = UrlBase.APIS,
            path = `transfer/v1/robux-transfer/accept-transfer/{transferRequestId}`
        }
    )()
end

local var1 = t.strictInterface({ transferRequestId = t.string })

local function acceptTransferRequest(arg1, arg2, arg3)
    assert(var1(arg1))
    local var2 = if arg3 ~= nil then HttpRequest.fromNetworkImpl(arg3) else HttpRequest.new(arg2)

    return var2:post(acceptTransferUrl(arg1.transferRequestId), { recipientId = 0 }):andThen(function(arg4)
        return AcceptTransferModel.format(arg4)
    end):catch(function(arg4)
        return Promise.reject(arg4)
    end)
end

return acceptTransferRequest

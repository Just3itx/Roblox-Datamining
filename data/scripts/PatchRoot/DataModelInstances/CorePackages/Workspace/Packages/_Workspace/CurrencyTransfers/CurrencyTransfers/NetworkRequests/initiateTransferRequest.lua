-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:41:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CurrencyTransfers = script:FindFirstAncestor("CurrencyTransfers")
local CurrencyTransfersParent = CurrencyTransfers.Parent

local UrlBuilder = require(CurrencyTransfersParent.UrlBuilder)
local t = require(CurrencyTransfersParent.t)
local Promise = require(CurrencyTransfersParent.Promise)

local InitiateTransferModel = require(CurrencyTransfers.Models.InitiateTransferModel)
local HttpRequest = require(CurrencyTransfers.NetworkRequests.HttpRequest)
local TransferOrigination = require(CurrencyTransfers.Enums.TransferOrigination)

local UrlBuilder2 = UrlBuilder.UrlBuilder
local UrlBase = UrlBuilder.UrlBase

local var1 = UrlBuilder2.new({ base = UrlBase.APIS, path = "transfer/v1/robux-transfer/initiate-transfer" })()

local var2 = t.strictInterface({ recipientId = t.number, transferOrigination = t.optional(t.string) })

local function initiateTransferRequest(arg1, arg2, arg3)
    assert(var2(arg1))
    local var3 = if arg3 ~= nil then HttpRequest.fromNetworkImpl(arg3) else HttpRequest.new(arg2)
    local var4 = arg1.transferOrigination or TransferOrigination.Unknown
    local transferOrigin = TransferOrigination.toEnumInteger[var4] or TransferOrigination.toEnumInteger[TransferOrigination.Unknown]
    local tbl1 = {
        recipientId = arg1.recipientId,
        transferOrigin = transferOrigin
    }

    return var3:post(var1, tbl1):andThen(function(arg4)
        return InitiateTransferModel.format(arg4)
    end):catch(function(arg4)
        return Promise.reject(arg4)
    end)
end

return initiateTransferRequest

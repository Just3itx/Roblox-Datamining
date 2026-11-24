-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:20:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CurrencyTransfers = script:FindFirstAncestor("CurrencyTransfers")
local _createTransferStore = require(CurrencyTransfers.Stores.createTransferStore)
local getTransferRequestByIdRequest = require(CurrencyTransfers.NetworkRequests.getTransferRequestByIdRequest)
local _GetTransferByIdModel = require(CurrencyTransfers.Models.GetTransferByIdModel)
local _ErrorTransferModel = require(CurrencyTransfers.Models.ErrorTransferModel)
local handleGetError = require(CurrencyTransfers.Actions.handleGetError)

local function getTransfer(arg1)
    local networkImpl = arg1.getNetworkImpl()
    local setRobuxTransfer = arg1.setRobuxTransfer
    local transferRequestId = arg1.getTransferRequestId(false)

    if not transferRequestId then
        handleGetError(arg1, nil)
        return
    end

    return getTransferRequestByIdRequest({ transferRequestId = transferRequestId }, nil, networkImpl):andThen(function(arg2)
        if arg2 and arg2.transfer then
            setRobuxTransfer(arg2.transfer)
            return
        end
        handleGetError(arg1, nil)
    end):catch(function(arg2)
        if typeof(arg2) == "table" and arg2.errorMessage then
            handleGetError(arg1, arg2)
            return
        end
        handleGetError(arg1, nil)
    end)
end

return getTransfer

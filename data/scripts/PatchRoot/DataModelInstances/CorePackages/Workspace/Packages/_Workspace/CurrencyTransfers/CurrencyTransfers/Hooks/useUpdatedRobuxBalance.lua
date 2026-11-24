-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:40:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CurrencyTransfers = script:FindFirstAncestor("CurrencyTransfers")
local CurrencyTransfersParent = CurrencyTransfers.Parent

local React = require(CurrencyTransfersParent.React)
local SignalsReact = require(CurrencyTransfersParent.SignalsReact)
local Promise = require(CurrencyTransfersParent.Promise)

local getBalanceRequest = require(CurrencyTransfers.NetworkRequests.getBalanceRequest)
local _useTransferStore = require(CurrencyTransfers.Hooks.useTransferStore)

local function useUpdatedRobuxBalance(arg1)
    local setRobuxBalanceAmount = arg1.setRobuxBalanceAmount
    local setBalanceReceivedFromApi = arg1.setBalanceReceivedFromApi

    React.useEffect(function()
        local bool1 = false

        getBalanceRequest(nil, arg1.getNetworkImpl()):andThen(function(arg2)
            if bool1 then
                return
            end
            setRobuxBalanceAmount(arg2)
            setBalanceReceivedFromApi(true)

            Promise.delay(0.5):andThen(function()
                if bool1 then
                    return
                end

                return getBalanceRequest(nil, arg1.getNetworkImpl()):andThen(function(arg3)
                    if bool1 then
                        return
                    end
                    setRobuxBalanceAmount(arg3)
                end):catch(function() end)
            end):catch(function() end)
        end):catch(function() end)

        return function()
            bool1 = true
        end
    end, { setRobuxBalanceAmount, setBalanceReceivedFromApi })

    return SignalsReact.useSignalState(arg1.getRobuxBalanceAmount) or 0
end

return useUpdatedRobuxBalance

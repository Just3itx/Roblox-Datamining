-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:41:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CurrencyTransfers = script:FindFirstAncestor("CurrencyTransfers")
local CurrencyTransfersParent = CurrencyTransfers.Parent

local Signals = require(CurrencyTransfersParent.Signals)

local PromptState = require(CurrencyTransfers.Enums.PromptState)
local _types = require(CurrencyTransfers.types)
local _TransferDirection = require(CurrencyTransfers.Enums.TransferDirection)
local _TransferOrigination = require(CurrencyTransfers.Enums.TransferOrigination)
local _ErrorTransferModel = require(CurrencyTransfers.Models.ErrorTransferModel)
local _TransferRetryOrigin = require(CurrencyTransfers.Enums.TransferRetryOrigin)
local _TransferBenefitSource = require(CurrencyTransfers.Enums.TransferBenefitSource)

return function()
    local getPromptState, setPromptState = Signals.createSignal(PromptState.Unspecified)
    local getTransferRequestId, setTransferRequestId = Signals.createSignal(nil)
    local getRecipientUserId, setRecipientUserId = Signals.createSignal(0)
    local getRobuxBalanceAmount, setRobuxBalanceAmount = Signals.createSignal(0)
    local getBalanceReceivedFromApi, setBalanceReceivedFromApi = Signals.createSignal(false)
    local getSelectedAmount, setSelectedAmount = Signals.createSignal(nil)
    local getUserRelationshipDetail, setUserRelationshipDetail = Signals.createSignal(nil)
    local getRecipient, setRecipient = Signals.createSignal(nil)
    local getSender, setSender = Signals.createSignal(nil)
    local getDirection, setDirection = Signals.createSignal(nil)
    local getTransferOrigination, setTransferOrigination = Signals.createSignal(nil)
    local getRobuxTransfer, setRobuxTransfer = Signals.createSignal(nil)
    local getIsAlreadyAccepted, setIsAlreadyAccepted = Signals.createSignal(false)
    local getErrorTransferModel, setErrorTransferModel = Signals.createSignal(nil)
    local getAmpRecourseActions, setAmpRecourseActions = Signals.createSignal(nil)
    local getAmpFeatureCheck, setAmpFeatureCheck = Signals.createSignal(nil)
    local getPreviousPromptState, setPreviousPromptState = Signals.createSignal(nil)
    local getTransferRetryOrigin, setTransferRetryOrigin = Signals.createSignal(nil)
    local getTransferClientSessionId, setTransferClientSessionId = Signals.createSignal("")
    local getMinimumTransferAmount, setMinimumTransferAmount = Signals.createSignal(nil)
    local getMaximumTransferAmount, setMaximumTransferAmount = Signals.createSignal(nil)
    local getTransferBenefitSource, setTransferBenefitSource = Signals.createSignal(nil)
    local getNumFreeTransfersRemaining, setNumFreeTransfersRemaining = Signals.createSignal(nil)
    local getFreeTransfersExhausted, setFreeTransfersExhausted = Signals.createSignal(false)

    local var49 = nil
    local var50 = nil
    local var51 = nil
    local bool1 = false

    local function setOnClose(func1: ((...any) -> (...any))?)
        var49 = func1
    end

    local function triggerOnClose()
        if var49 then
            var49()
        end
    end

    local function setOnPromptOptimisticHide(func1: ((...any) -> (...any))?)
        var50 = func1
    end

    local function triggerOnPromptOptimisticHide()
        if var50 then
            var50()
        end
    end

    local function setOnPromptDismissCommitted(func1: ((...any) -> (...any))?)
        var51 = func1
        bool1 = false
    end

    local function triggerOnPromptDismissCommitted()
        if bool1 or var51 == nil then
            return
        end
        bool1 = true
        var51()
    end

    local getNetworkImpl = nil
    return {
        getPromptState = getPromptState,
        setPromptState = setPromptState,
        getTransferRequestId = getTransferRequestId,
        setTransferRequestId = setTransferRequestId,
        getRecipientUserId = getRecipientUserId,
        setRecipientUserId = setRecipientUserId,
        getRobuxBalanceAmount = getRobuxBalanceAmount,
        setRobuxBalanceAmount = setRobuxBalanceAmount,
        getBalanceReceivedFromApi = getBalanceReceivedFromApi,
        setBalanceReceivedFromApi = setBalanceReceivedFromApi,
        getSelectedAmount = getSelectedAmount,
        setSelectedAmount = setSelectedAmount,
        getUserRelationshipDetail = getUserRelationshipDetail,
        setUserRelationshipDetail = setUserRelationshipDetail,
        getRecipient = getRecipient,
        setRecipient = setRecipient,
        getSender = getSender,
        setSender = setSender,
        getDirection = getDirection,
        setDirection = setDirection,
        getTransferOrigination = getTransferOrigination,
        setTransferOrigination = setTransferOrigination,
        getRobuxTransfer = getRobuxTransfer,
        setRobuxTransfer = setRobuxTransfer,
        getIsAlreadyAccepted = getIsAlreadyAccepted,
        setIsAlreadyAccepted = setIsAlreadyAccepted,
        getErrorTransferModel = getErrorTransferModel,
        setErrorTransferModel = setErrorTransferModel,
        getAmpRecourseActions = getAmpRecourseActions,
        setAmpRecourseActions = setAmpRecourseActions,
        getAmpFeatureCheck = getAmpFeatureCheck,
        setAmpFeatureCheck = setAmpFeatureCheck,
        getPreviousPromptState = getPreviousPromptState,
        setPreviousPromptState = setPreviousPromptState,
        getTransferRetryOrigin = getTransferRetryOrigin,
        setTransferRetryOrigin = setTransferRetryOrigin,
        getTransferClientSessionId = getTransferClientSessionId,
        setTransferClientSessionId = setTransferClientSessionId,
        getMinimumTransferAmount = getMinimumTransferAmount,
        setMinimumTransferAmount = setMinimumTransferAmount,
        getMaximumTransferAmount = getMaximumTransferAmount,
        setMaximumTransferAmount = setMaximumTransferAmount,
        getTransferBenefitSource = getTransferBenefitSource,
        setTransferBenefitSource = setTransferBenefitSource,
        getNumFreeTransfersRemaining = getNumFreeTransfersRemaining,
        setNumFreeTransfersRemaining = setNumFreeTransfersRemaining,
        getFreeTransfersExhausted = getFreeTransfersExhausted,
        setFreeTransfersExhausted = setFreeTransfersExhausted,
        setOnClose = setOnClose,
        triggerOnClose = triggerOnClose,
        setOnPromptOptimisticHide = setOnPromptOptimisticHide,
        triggerOnPromptOptimisticHide = triggerOnPromptOptimisticHide,
        setOnPromptDismissCommitted = setOnPromptDismissCommitted,
        triggerOnPromptDismissCommitted = triggerOnPromptDismissCommitted,
        getNetworkImpl = function()
            return getNetworkImpl
        end,
        setNetworkImpl = function(arg1)
            getNetworkImpl = arg1
        end
    }
end

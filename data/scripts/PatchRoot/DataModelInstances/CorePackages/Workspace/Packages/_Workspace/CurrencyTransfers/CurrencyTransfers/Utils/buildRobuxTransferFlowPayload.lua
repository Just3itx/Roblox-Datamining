-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:41:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CurrencyTransfers = script:FindFirstAncestor("CurrencyTransfers")

local Players = game:GetService("Players")

local _createTransferStore = require(CurrencyTransfers.Stores.createTransferStore)
local TransferDirection = require(CurrencyTransfers.Enums.TransferDirection)

local function buildRobuxTransferFlowPayload(arg1, eventName: string)
    local localPlayer = Players.LocalPlayer
    local num1 = if localPlayer then localPlayer.UserId else 0

    local direction = arg1.getDirection(false)
    local num2 = 0
    local num3 = 0
    if direction == TransferDirection.Send then
        local recipient = arg1.getRecipient(false)
        if recipient then
            local targetId = recipient.targetId
            num2 = num1
            num1 = targetId
        else
            local recipientUserId = arg1.getRecipientUserId(false)
            num2 = num1
            num1 = recipientUserId
        end
    elseif direction == TransferDirection.Receive then
        local sender = arg1.getSender(false)
        if sender then
            num2 = sender.targetId
        else
            num2 = 0
        end
    else
        num1 = num3
    end

    local transferRequestId = arg1.getTransferRequestId(false)
    local selectedAmount = arg1.getSelectedAmount(false)
    local robuxTransfer = arg1.getRobuxTransfer(false)

    if selectedAmount == nil and robuxTransfer then
        selectedAmount = robuxTransfer.transferAmount
    end

    local gameId = game.GameId
    if not (gameId > 0) then
        gameId = nil
    end

    local transferOrigination = arg1.getTransferOrigination(false)
    local transferDirection = if direction then tostring(direction) else ""
    local str1 = if transferOrigination then tostring(transferOrigination) else ""

    local tbl1 = {
        transfer_request_id = transferRequestId or "",
        transfer_client_session_id = arg1.getTransferClientSessionId(false),
        event_name = eventName,
        sender_user_id = num2,
        recipient_user_id = num1,
        transfer_amount = selectedAmount,
        transfer_prompt_state = tostring(arg1.getPromptState(false)),
        transfer_origination = str1,
        transfer_direction = transferDirection,
        ingest_timestamp_milliseconds = DateTime.now().UnixTimestampMillis
    }

    if direction == TransferDirection.Send and arg1.getBalanceReceivedFromApi(false) then
        tbl1.user_balance = arg1.getRobuxBalanceAmount(false)
    end

    if gameId ~= nil then
        tbl1.universe_id = gameId
    end

    return tbl1
end

return buildRobuxTransferFlowPayload

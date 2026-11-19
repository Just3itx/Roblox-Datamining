-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T11:50:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent

local Promise = require(scriptParentParent.Promise)

local CallProtocolConstants = require(scriptParent.CallProtocolConstants)
local _CallProtocolTypes = require(scriptParent.CallProtocolTypes)

local MessageBusService = game:GetService("MessageBusService")

local module = ({})
module.__index = module

function module.new()
    return (setmetatable({}, module))
end

function module.initCall(_, callerId: number, calleeId: number, callerCombinedName: string, calleeCombinedName: string, muted: boolean, camEnabled: boolean, callerUniqueIdentifier: string, tag: string?)
    MessageBusService:Publish(CallProtocolConstants.MESSAGE_INIT_CALL, {
        callerId = callerId,
        calleeId = calleeId,
        callerCombinedName = callerCombinedName,
        calleeCombinedName = calleeCombinedName,
        muted = muted,
        camEnabled = camEnabled,
        callerUniqueIdentifier = callerUniqueIdentifier,
        tag = tag or ""
    })
end

function module.answerCall(_, callId: string)
    MessageBusService:Publish(CallProtocolConstants.MESSAGE_ANSWER_CALL, { callId = callId })
end

function module.answerSuccessCall(_, callId: string)
    MessageBusService:Publish(CallProtocolConstants.MESSAGE_ANSWER_SUCCESS_CALL, { callId = callId })
end

function module.rejectCall(_, callId: string)
    MessageBusService:Publish(CallProtocolConstants.MESSAGE_REJECT_CALL, { callId = callId })
end

function module.cancelCall(_, callId: string)
    MessageBusService:Publish(CallProtocolConstants.MESSAGE_CANCEL_CALL, { callId = callId })
end

function module.teleportSuccessCall(_, callId: string)
    MessageBusService:Publish(CallProtocolConstants.MESSAGE_TELEPORT_SUCCESS_CALL, { callId = callId })
end

function module.finishCall(_, callId: string)
    MessageBusService:Publish(CallProtocolConstants.MESSAGE_FINISH_CALL, { callId = callId })
end

function module.getCallState(_)
    return (Promise.new(function(callback, _)
        MessageBusService:MakeRequest(CallProtocolConstants.NAME, CallProtocolConstants.METHOD_GET_CALL_STATE, {}, function(arg1)
            callback(arg1)
        end, {})
    end))
end

function module.updateMicAndCamState(_, muted, camEnabled)
    local tbl1 = {}
    if muted ~= nil then
        tbl1.muted = muted
    end

    if camEnabled ~= nil then
        tbl1.camEnabled = camEnabled
    end
    MessageBusService:Publish(CallProtocolConstants.MESSAGE_UDPATE_MIC_AND_CAM_STATE, tbl1)
end

function module.listenToHandleInitCall(_, callback: (...any) -> (...any)): Instance
    return MessageBusService:Subscribe(CallProtocolConstants.MESSAGE_HANDLE_INIT_CALL, callback, false, true)
end

function module.listenToHandleConnectingCall(_, callback: (...any) -> (...any)): Instance
    return MessageBusService:Subscribe(CallProtocolConstants.MESSAGE_HANDLE_CONNECTING_CALL, callback, false, true)
end

function module.listenToHandleTeleportingCall(_, callback: (...any) -> (...any)): Instance
    return MessageBusService:Subscribe(CallProtocolConstants.MESSAGE_HANDLE_TELEPORTING_CALL, callback, false, true)
end

function module.listenToHandleActiveCall(_, callback: (...any) -> (...any)): Instance
    return MessageBusService:Subscribe(CallProtocolConstants.MESSAGE_HANDLE_ACTIVE_CALL, callback, false, true)
end

function module.listenToHandleEndCall(_, callback: (...any) -> (...any)): Instance
    return MessageBusService:Subscribe(CallProtocolConstants.MESSAGE_HANDLE_END_CALL, callback, false, true)
end

function module.listenToHandleCallMessage(_, callback: (...any) -> (...any)): Instance
    return MessageBusService:Subscribe(CallProtocolConstants.MESSAGE_HANDLE_CALL_MESSAGE, callback, false, true)
end

function module.listenToHandleMicAndCamChanged(_, callback: (...any) -> (...any)): Instance
    return MessageBusService:Subscribe(CallProtocolConstants.MESSAGE_HANDLE_MIC_AND_CAM_CHANGED, callback, false, true)
end

function module.listenToHandleTransferCallTeleportLeave(_, callback: (...any) -> (...any)): Instance
    return MessageBusService:Subscribe(CallProtocolConstants.MESSAGE_HANDLE_TRANSFER_CALL_TELEPORT_LEAVE, callback, false, true)
end

function module.listenToHandleTransferCallTeleportJoin(_, callback: (...any) -> (...any)): Instance
    return MessageBusService:Subscribe(CallProtocolConstants.MESSAGE_HANDLE_TRANSFER_CALL_TELEPORT_JOIN, callback, false, true)
end

module.default = module.new()

return module

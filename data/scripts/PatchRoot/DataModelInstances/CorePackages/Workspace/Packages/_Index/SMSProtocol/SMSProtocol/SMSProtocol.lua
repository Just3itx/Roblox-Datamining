-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T16:31:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local MessageBus = require(scriptParentParent.MessageBus).MessageBus
local Promise = require(scriptParentParent.Promise)
local t = require(scriptParentParent.t)

local _SMSProtocolTypes = require(script.Parent.SMSProtocolTypes)

local validateParams = t.strictInterface({ sent = t.optional(t.boolean) })

local module = {
    SEND_SMS_PROTOCOL_METHOD_REQUEST_DESCRIPTOR = {
        protocolName = "SMSProtocol",
        methodName = "sendSMS",
        validateParams = t.strictInterface({ address = t.string, message = t.string })
    },
    SEND_SMS_PROTOCOL_METHOD_RESPONSE_DESCRIPTOR = {
        protocolName = "SMSProtocol",
        methodName = "sendSMS",
        validateParams = validateParams
    },
    SUPPORTS_SMS_PROTOCOL_METHOD_REQUEST_DESCRIPTOR = {
        protocolName = "SMSProtocol",
        methodName = "supportsSMS",
        validateParams = t.table
    },
    SUPPORTS_SMS_PROTOCOL_METHOD_RESPONSE_DESCRIPTOR = {
        protocolName = "SMSProtocol",
        methodName = "supportsSMS",
        validateParams = t.table
    }
}
module.__index = module

function module.new()
    return (setmetatable({ subscriber = MessageBus.Subscriber.new() }, module))
end

function module.sendSMS(arg1, arg2)
    local promise = Promise.new(function(callback, _)
        local sendSmsProtocolMethodResponseDescriptor = arg1.SEND_SMS_PROTOCOL_METHOD_RESPONSE_DESCRIPTOR
        arg1.subscriber:subscribeProtocolMethodResponse(sendSmsProtocolMethodResponseDescriptor, function(arg3)
            arg1.subscriber:unsubscribeToProtocolMethodResponse(sendSmsProtocolMethodResponseDescriptor)
            callback(arg3)
        end)
    end)

    MessageBus.publishProtocolMethodRequest(arg1.SEND_SMS_PROTOCOL_METHOD_REQUEST_DESCRIPTOR, arg2, {})

    return promise
end

function module.supportsSMS(arg1)
    local promise = Promise.new(function(callback, _)
        local supportsSmsProtocolMethodResponseDescriptor = arg1.SUPPORTS_SMS_PROTOCOL_METHOD_RESPONSE_DESCRIPTOR
        arg1.subscriber:subscribeProtocolMethodResponse(supportsSmsProtocolMethodResponseDescriptor, function(tbl1)
            arg1.subscriber:unsubscribeToProtocolMethodResponse(supportsSmsProtocolMethodResponseDescriptor)
            callback(tbl1.support)
        end)
    end)
    MessageBus.publishProtocolMethodRequest(
        arg1.SUPPORTS_SMS_PROTOCOL_METHOD_REQUEST_DESCRIPTOR,
        { includeStatus = false },
        {}
    )
    return promise
end

module.default = module.new()

return module

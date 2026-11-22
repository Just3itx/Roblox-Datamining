-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:41:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local MessageBus = require(scriptParentParent.MessageBus).MessageBus
local Promise = require(scriptParentParent.Promise)
local t = require(scriptParentParent.t)

local getFFlagLuaIdentityProtocol = require(script.Parent.Flags.getFFlagLuaIdentityProtocol)
local GetFFlagLuaIdentityGetSMSOTP = require(scriptParentParent.SharedFlags).GetFFlagLuaIdentityGetSMSOTP
local GetFFlagLuaIdentityGetPhoneNumber = require(scriptParentParent.SharedFlags).GetFFlagLuaIdentityGetPhoneNumber
local GetFFlagLuaIdentityVerifySNA = require(scriptParentParent.SharedFlags).GetFFlagLuaIdentityVerifySNA
local _IdentityProtocolTypes = require(script.Parent.IdentityProtocolTypes)

local validateParams = t.strictInterface({ result = t.optional(t.string) })

local module = {
    GET_PHONE_NUMBER_METHOD_REQUEST_DESCRIPTOR = {
        protocolName = "IdentityProtocol",
        methodName = "getPhoneNumber",
        validateParams = t.table
    },
    GET_PHONE_NUMBER_METHOD_RESPONSE_DESCRIPTOR = {
        protocolName = "IdentityProtocol",
        methodName = "getPhoneNumber",
        validateParams = validateParams
    },
    SUPPORTS_GET_PHONE_NUMBER_METHOD_REQUEST_DESCRIPTOR = {
        protocolName = "IdentityProtocol",
        methodName = "supportsGetPhoneNumber",
        validateParams = t.table
    },
    SUPPORTS_GET_PHONE_NUMBER_METHOD_RESPONSE_DESCRIPTOR = {
        protocolName = "IdentityProtocol",
        methodName = "supportsGetPhoneNumber",
        validateParams = t.table
    },
    GET_SMS_OTP_METHOD_REQUEST_DESCRIPTOR = {
        protocolName = "IdentityProtocol",
        methodName = "getSMSOTP",
        validateParams = t.table
    },
    GET_SMS_OTP_METHOD_RESPONSE_DESCRIPTOR = {
        protocolName = "IdentityProtocol",
        methodName = "getSMSOTP",
        validateParams = validateParams
    },
    SUPPORTS_GET_SMS_OTP_METHOD_REQUEST_DESCRIPTOR = {
        protocolName = "IdentityProtocol",
        methodName = "supportsGetSMSOTP",
        validateParams = t.table
    },
    SUPPORTS_GET_SMS_OTP_METHOD_RESPONSE_DESCRIPTOR = {
        protocolName = "IdentityProtocol",
        methodName = "supportsGetSMSOTP",
        validateParams = t.table
    },
    SUPPORTS_VERIFY_SNA_METHOD_REQUEST_DESCRIPTOR = {
        protocolName = "IdentityProtocol",
        methodName = "supportsVerifySNA",
        validateParams = t.table
    },
    SUPPORTS_VERIFY_SNA_METHOD_RESPONSE_DESCRIPTOR = {
        protocolName = "IdentityProtocol",
        methodName = "supportsVerifySNA",
        validateParams = t.table
    },
    VERIFY_SNA_METHOD_REQUEST_DESCRIPTOR = {
        protocolName = "IdentityProtocol",
        methodName = "verifySNA",
        validateParams = t.table
    },
    VERIFY_SNA_METHOD_RESPONSE_DESCRIPTOR = {
        protocolName = "IdentityProtocol",
        methodName = "verifySNA",
        validateParams = t.table
    }
}
module.__index = module

function module.new()
    return (setmetatable({ subscriber = MessageBus.Subscriber.new() }, module))
end

function module.supportsVerifySNA(arg1)
    if not (getFFlagLuaIdentityProtocol() and GetFFlagLuaIdentityVerifySNA()) then
        return Promise.resolve(false)
    end

    local promise = Promise.new(function(callback, _)
        local supportsVerifySnaMethodResponseDescriptor = arg1.SUPPORTS_VERIFY_SNA_METHOD_RESPONSE_DESCRIPTOR
        arg1.subscriber:subscribeProtocolMethodResponse(supportsVerifySnaMethodResponseDescriptor, function(tbl1)
            arg1.subscriber:unsubscribeToProtocolMethodResponse(supportsVerifySnaMethodResponseDescriptor)
            callback(tbl1.support)
        end)
    end)

    MessageBus.publishProtocolMethodRequest(arg1.SUPPORTS_VERIFY_SNA_METHOD_REQUEST_DESCRIPTOR, {}, {})

    return promise
end

function module.verifySNA(arg1, arg2)
    if not (getFFlagLuaIdentityProtocol() and GetFFlagLuaIdentityVerifySNA()) then
        return Promise.resolve(false)
    end

    local promise = Promise.new(function(callback, _)
        local verifySnaMethodResponseDescriptor = arg1.VERIFY_SNA_METHOD_RESPONSE_DESCRIPTOR
        arg1.subscriber:subscribeProtocolMethodResponse(verifySnaMethodResponseDescriptor, function(tbl1)
            arg1.subscriber:unsubscribeToProtocolMethodResponse(verifySnaMethodResponseDescriptor)
            callback(tbl1.result)
        end)
    end)

    MessageBus.publishProtocolMethodRequest(arg1.VERIFY_SNA_METHOD_REQUEST_DESCRIPTOR, arg2, {})

    return promise
end

function module.getPhoneNumber(arg1)
    if not (getFFlagLuaIdentityProtocol() and GetFFlagLuaIdentityGetPhoneNumber()) then
        return Promise.resolve()
    end
    local promise = Promise.new(function(callback, _)
        local getPhoneNumberMethodResponseDescriptor = arg1.GET_PHONE_NUMBER_METHOD_RESPONSE_DESCRIPTOR
        arg1.subscriber:subscribeProtocolMethodResponse(getPhoneNumberMethodResponseDescriptor, function(tbl1)
            arg1.subscriber:unsubscribeToProtocolMethodResponse(getPhoneNumberMethodResponseDescriptor)
            callback(tbl1.result)
        end)
    end)

    MessageBus.publishProtocolMethodRequest(arg1.GET_PHONE_NUMBER_METHOD_REQUEST_DESCRIPTOR, { includeStatus = false }, {})

    return promise
end

function module.supportsGetPhoneNumber(arg1)
    if not (getFFlagLuaIdentityProtocol() and GetFFlagLuaIdentityGetPhoneNumber()) then
        return Promise.resolve()
    end

    local promise = Promise.new(function(callback, _)
        local supportsGetPhoneNumberMethodResponseDescriptor = arg1.SUPPORTS_GET_PHONE_NUMBER_METHOD_RESPONSE_DESCRIPTOR
        arg1.subscriber:subscribeProtocolMethodResponse(supportsGetPhoneNumberMethodResponseDescriptor, function(tbl1)
            arg1.subscriber:unsubscribeToProtocolMethodResponse(supportsGetPhoneNumberMethodResponseDescriptor)
            callback(tbl1.support)
        end)
    end)
    MessageBus.publishProtocolMethodRequest(
        arg1.SUPPORTS_GET_PHONE_NUMBER_METHOD_REQUEST_DESCRIPTOR,
        { includeStatus = false },
        {}
    )
    return promise
end

function module.getSMSOTP(arg1)
    if not (getFFlagLuaIdentityProtocol() and GetFFlagLuaIdentityGetSMSOTP()) then
        return Promise.resolve()
    end
    local promise = Promise.new(function(callback, _)
        local getSmsOtpMethodResponseDescriptor = arg1.GET_SMS_OTP_METHOD_RESPONSE_DESCRIPTOR
        arg1.subscriber:subscribeProtocolMethodResponse(getSmsOtpMethodResponseDescriptor, function(tbl1)
            arg1.subscriber:unsubscribeToProtocolMethodResponse(getSmsOtpMethodResponseDescriptor)
            callback(tbl1.result)
        end)
    end)

    MessageBus.publishProtocolMethodRequest(arg1.GET_SMS_OTP_METHOD_REQUEST_DESCRIPTOR, { includeStatus = false }, {})

    return promise
end

function module.supportsGetSMSOTP(arg1)
    if not (getFFlagLuaIdentityProtocol() and GetFFlagLuaIdentityGetSMSOTP()) then
        return Promise.resolve()
    end

    local promise = Promise.new(function(callback, _)
        local supportsGetSmsOtpMethodResponseDescriptor = arg1.SUPPORTS_GET_SMS_OTP_METHOD_RESPONSE_DESCRIPTOR
        arg1.subscriber:subscribeProtocolMethodResponse(supportsGetSmsOtpMethodResponseDescriptor, function(tbl1)
            arg1.subscriber:unsubscribeToProtocolMethodResponse(supportsGetSmsOtpMethodResponseDescriptor)
            callback(tbl1.support)
        end)
    end)
    MessageBus.publishProtocolMethodRequest(
        arg1.SUPPORTS_GET_SMS_OTP_METHOD_REQUEST_DESCRIPTOR,
        { includeStatus = false },
        {}
    )
    return promise
end

module.default = module.new()

return module

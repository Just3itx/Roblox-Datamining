-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T09:20:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local MessageBus = require(scriptParentParent.MessageBus).MessageBus
local Promise = require(scriptParentParent.Promise)
local t = require(scriptParentParent.t)

local _ContactsProtocolTypes = require(script.Parent.ContactsProtocolTypes)

local validateParams = t.strictInterface(
    {
        firstName = t.optional(t.string),
        lastName = t.optional(t.string),
        phoneNumbers = t.optional(t.table)
    }
)
local module = {
    GET_CONTACTS_PROTOCOL_METHOD_REQUEST_DESCRIPTOR = {
        protocolName = "ContactsProtocol",
        methodName = "getContacts",
        validateParams = t.table
    },
    GET_CONTACTS_REQUEST_PROTOCOL_METHOD_RESPONSE_DESCRIPTOR = {
        protocolName = "ContactsProtocol",
        methodName = "getContacts",
        validateParams = validateParams
    },
    SUPPORTS_CONTACTS_PROTOCOL_METHOD_REQUEST_DESCRIPTOR = {
        protocolName = "ContactsProtocol",
        methodName = "SupportsContacts",
        validateParams = t.table
    },
    SUPPORTS_CONTACTS_PROTOCOL_METHOD_RESPONSE_DESCRIPTOR = {
        protocolName = "ContactsProtocol",
        methodName = "SupportsContacts",
        validateParams = t.table
    }
}
module.__index = module

function module.new()
    return (setmetatable({ subscriber = MessageBus.Subscriber.new() }, module))
end

function module.getContacts(arg1)
    local promise = Promise.new(function(callback, _)
        local getContactsRequestProtocolMethodResponseDescriptor = arg1.GET_CONTACTS_REQUEST_PROTOCOL_METHOD_RESPONSE_DESCRIPTOR
        arg1.subscriber:subscribeProtocolMethodResponse(getContactsRequestProtocolMethodResponseDescriptor, function(arg2)
            arg1.subscriber:unsubscribeToProtocolMethodResponse(getContactsRequestProtocolMethodResponseDescriptor)
            callback(arg2)
        end)
    end)

    MessageBus.publishProtocolMethodRequest(
        arg1.GET_CONTACTS_PROTOCOL_METHOD_REQUEST_DESCRIPTOR,
        { includeVariable = false },
        {}
    )

    return promise
end

function module.supportsContacts(arg1)
    local promise = Promise.new(function(callback, _)
        local supportsContactsProtocolMethodResponseDescriptor = arg1.SUPPORTS_CONTACTS_PROTOCOL_METHOD_RESPONSE_DESCRIPTOR
        arg1.subscriber:subscribeProtocolMethodResponse(supportsContactsProtocolMethodResponseDescriptor, function(tbl1)
            arg1.subscriber:unsubscribeToProtocolMethodResponse(supportsContactsProtocolMethodResponseDescriptor)
            callback(tbl1.support)
        end)
    end)

    MessageBus.publishProtocolMethodRequest(
        arg1.SUPPORTS_CONTACTS_PROTOCOL_METHOD_REQUEST_DESCRIPTOR,
        { includeStatus = false },
        {}
    )
    return promise
end

module.default = module.new()

return module

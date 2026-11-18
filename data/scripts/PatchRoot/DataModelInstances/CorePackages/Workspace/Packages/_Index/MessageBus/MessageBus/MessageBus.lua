-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-18T22:56:33Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local MessageBusService = game:GetService("MessageBusService")

local _MessageBusTypes = require(script.Parent.MessageBusTypes)

local bool1 = game:DefineFastFlag("DisableMessageBusUnSubscribeError", false)

local bool2 = game:DefineFastFlag("EnableMessageBusUnSubscribeErrorTelemetry", false)

local module = ({})
module.__index = module

function module.publish(arg1, arg2)
    assert(arg1.validateParams(arg2))
    MessageBusService:Publish(arg1.mid, arg2)
end

function module.publishProtocolMethodRequest(arg1, message, customTelemetryData)
    assert(arg1.validateParams(message))
    MessageBusService:PublishProtocolMethodRequest(arg1.protocolName, arg1.methodName, message, customTelemetryData)
end

function module.publishProtocolMethodResponse(arg1, message, responseCode: number, customTelemetryData)
    assert(arg1.validateParams(message))
    MessageBusService:PublishProtocolMethodResponse(
        arg1.protocolName,
        arg1.methodName,
        message,
        responseCode,
        customTelemetryData
    )
end

function module.getLast(arg1)
    local last = MessageBusService:GetLast(arg1.mid)
    if last == nil then
        return nil
    end
    assert(arg1.validateParams(last))
    return last
end

function module.getMessageId(domainName: string, messageName: string): string
    return MessageBusService:GetMessageId(domainName, messageName)
end

function module.getProtocolMethodRequestMessageId(protocolName: string, methodName: string): string
    return MessageBusService:GetProtocolMethodRequestMessageId(protocolName, methodName)
end

function module.getProtocolMethodResponseMessageId(protocolName: string, methodName: string): string
    return MessageBusService:GetProtocolMethodResponseMessageId(protocolName, methodName)
end

function module.call(arg1, input)
    assert(arg1.validateParams(input))
    return MessageBusService:Call(arg1.fid, input)
end

local Subscriber = ({})
Subscriber.__index = Subscriber

function Subscriber.new()
    return (setmetatable({ connections = {} }, Subscriber))
end

function Subscriber:getSubscriptionCount(): number
    local num1 = 0
    for _ in pairs(self.connections) do
        num1 += 1
    end
    return num1
end

function Subscriber:subscribe(arg1, func1: (...any) -> (...any), bool3: boolean?, bool4: boolean?)
    if bool3 == nil then
        bool3 = true
    end

    if bool4 == nil then
        bool4 = false
    end

    local mid = arg1.mid
    if self.connections[mid] ~= nil then
        self:unsubscribe(arg1)
    end
    local var1 = MessageBusService:Subscribe(mid, func1, bool4, bool3)
    self.connections[mid] = var1
end

function Subscriber:subscribeProtocolMethodRequest(arg1, func1: (...any) -> (...any), bool3: boolean?, bool4: boolean?)
    if bool3 == nil then
        bool3 = true
    end

    if bool4 == nil then
        bool4 = false
    end

    local protocolName = arg1.protocolName
    local methodName = arg1.methodName
    local protocolMethodRequestMessageId = module.getProtocolMethodRequestMessageId(protocolName, methodName)
    if self.connections[protocolMethodRequestMessageId] ~= nil then
        self:unsubscribeWithMsgId(protocolMethodRequestMessageId)
    end
    local var1 = MessageBusService:SubscribeToProtocolMethodRequest(protocolName, methodName, func1, bool4, bool3)
    self.connections[protocolMethodRequestMessageId] = var1
end

function Subscriber:subscribeProtocolMethodResponse(arg1, func1: (...any) -> (...any), bool3: boolean?, bool4: boolean?)
    if bool3 == nil then
        bool3 = true
    end

    if bool4 == nil then
        bool4 = false
    end

    local protocolName = arg1.protocolName
    local methodName = arg1.methodName
    local protocolMethodResponseMessageId = module.getProtocolMethodResponseMessageId(protocolName, methodName)
    if self.connections[protocolMethodResponseMessageId] ~= nil then
        self:unsubscribeWithMsgId(protocolMethodResponseMessageId)
    end
    local var1 = MessageBusService:SubscribeToProtocolMethodResponse(protocolName, methodName, func1, bool4, bool3)
    self.connections[protocolMethodResponseMessageId] = var1
end

function Subscriber.unsubscribeToProtocolMethodRequest(arg1, arg2)
    arg1:unsubscribeWithMsgId(MessageBusService:GetProtocolMethodRequestMessageId(arg2.protocolName, arg2.methodName))
end

function Subscriber.unsubscribeToProtocolMethodResponse(arg1, arg2)
    arg1:unsubscribeWithMsgId(MessageBusService:GetProtocolMethodResponseMessageId(arg2.protocolName, arg2.methodName))
end

function Subscriber:unsubscribe(arg1)
    self:unsubscribeWithMsgId(arg1.mid)
end

function Subscriber:unsubscribeWithMsgId(str1: string)
    local connection = self.connections[str1]
    if connection == nil then
        if bool1 then
            if bool2 then
                local input = {
                    eventType = "RobloxTelemetry",
                    config = {
                        eventName = "MessageBusErrorEvent",
                        backends = { "Points" },
                        throttlingPercentage = 10000,
                        lastUpdated = { 24, 11, 20 },
                        description = "Report MessageBus errors to Points\"",
                        links = ""
                    },
                    data = {
                        standardizedFields = nil,
                        customFields = {
                            err = "unsubscribing from a message id not subscribed to: " .. str1
                        },
                        eventContext = nil
                    }
                }

                MessageBusService:Call("Telemetry.logEventFromLua", input)
            end

            return
        end
        error("unsubscribing from a message id not subscribed to: " .. str1)
    end

    self.connections[str1] = nil
    connection:Disconnect()
end

function Subscriber:unsubscribeFromAllMessages()
    for k, connection in pairs(self.connections) do
        self.connections[k] = nil
        connection:Disconnect()
    end
end

module.Subscriber = Subscriber

return module

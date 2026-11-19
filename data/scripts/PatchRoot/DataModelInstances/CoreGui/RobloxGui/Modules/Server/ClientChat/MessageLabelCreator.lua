-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:31:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}

local Chat = game:GetService("Chat")
local ClientChatModules = Chat:WaitForChild("ClientChatModules")
local MessageCreatorModules = ClientChatModules:WaitForChild("MessageCreatorModules")
local Util = require(MessageCreatorModules:WaitForChild("Util"))
local scriptParent = script.Parent
local _ChatSettings = require(ClientChatModules:WaitForChild("ChatSettings"))
local ObjectPool = require(scriptParent:WaitForChild("ObjectPool"))
local _MessageSender = require(scriptParent:WaitForChild("MessageSender"))

local tbl1 = {}
tbl1.__index = tbl1

function mergeProps(arg1, extraData)
    if not arg1 then
        return
    end

    for k, value in pairs(arg1) do
        extraData[k] = value
    end
end

function ReturnToObjectPoolRecursive(arg1, objectPool)
    local children = arg1:GetChildren()
    for i = 1, #children do
        ReturnToObjectPoolRecursive(children[i], objectPool)
    end
    arg1.Parent = nil
    objectPool:ReturnInstance(arg1)
end

function GetMessageCreators()
    local messageCreators = {}
    local children = MessageCreatorModules:GetChildren()
    for i = 1, #children do
        if children[i]:IsA("ModuleScript") and children[i].Name ~= "Util" then
            local var1 = require(children[i])
            messageCreators[var1[Util.KEY_MESSAGE_TYPE]] = var1[Util.KEY_CREATOR_FUNCTION]
        end
    end

    return messageCreators
end

function tbl1:WrapIntoMessageObject(arg1, arg2)
    local baseFrame = arg2[Util.KEY_BASE_FRAME]
    local baseMessage = if Util.KEY_BASE_MESSAGE then arg2[Util.KEY_BASE_MESSAGE] else nil
    local updateTextFunction = arg2[Util.KEY_UPDATE_TEXT_FUNC]
    local getHeightFunction = arg2[Util.KEY_GET_HEIGHT]
    local fadeInFunction = arg2[Util.KEY_FADE_IN]
    local fadeOutFunction = arg2[Util.KEY_FADE_OUT]
    local updateAnimFunction = arg2[Util.KEY_UPDATE_ANIMATION]

    return {
        ID = arg1.ID,
        BaseFrame = baseFrame,
        BaseMessage = baseMessage,
        UpdateTextFunction = updateTextFunction or function()
            warn("NO MESSAGE RESIZE FUNCTION")
        end,
        GetHeightFunction = getHeightFunction,
        FadeInFunction = fadeInFunction,
        FadeOutFunction = fadeOutFunction,
        UpdateAnimFunction = updateAnimFunction,
        ObjectPool = self.ObjectPool,
        Destroyed = false,
        Destroy = function(arg3)
            ReturnToObjectPoolRecursive(arg3.BaseFrame, arg3.ObjectPool)
            arg3.Destroyed = true
        end
    }
end

function tbl1:CreateMessageLabel_Chat(callbackArguments, channel, arg1)
    callbackArguments.Channel = channel
    local chatCallbackResult = nil
    pcall(function()
        chatCallbackResult = Chat:InvokeChatCallback(Enum.ChatCallbackType.OnClientFormattingMessage, callbackArguments)
    end)
    callbackArguments.ExtraData = callbackArguments.ExtraData or {}
    mergeProps(chatCallbackResult, callbackArguments.ExtraData)

    local messageType = callbackArguments.MessageType
    if self.MessageCreators[messageType] then
        local var1 = self.MessageCreators[messageType](callbackArguments, channel, arg1)
        if var1 then
            return self:WrapIntoMessageObject(callbackArguments, var1)
        end

        return
    end
    if self.DefaultCreatorType then
        local var1 = self.MessageCreators[self.DefaultCreatorType](callbackArguments, channel, arg1)
        if var1 then
            return self:WrapIntoMessageObject(callbackArguments, var1)
        end
    else
        error("No message creator available for message type: " .. messageType)
    end
end

function tbl1:CreateMessageLabel(callbackArguments, channel)
    callbackArguments.Channel = channel
    local chatCallbackResult = nil
    pcall(function()
        chatCallbackResult = Chat:InvokeChatCallback(Enum.ChatCallbackType.OnClientFormattingMessage, callbackArguments)
    end)
    callbackArguments.ExtraData = callbackArguments.ExtraData or {}
    mergeProps(chatCallbackResult, callbackArguments.ExtraData)

    local messageType = callbackArguments.MessageType
    if self.MessageCreators[messageType] then
        local var1 = self.MessageCreators[messageType](callbackArguments, channel)
        if var1 then
            return self:WrapIntoMessageObject(callbackArguments, var1)
        end

        return
    end
    if self.DefaultCreatorType then
        local var1 = self.MessageCreators[self.DefaultCreatorType](callbackArguments, channel)
        if var1 then
            return self:WrapIntoMessageObject(callbackArguments, var1)
        end
    else
        error("No message creator available for message type: " .. messageType)
    end
end

function module.new()
    local self = setmetatable({}, tbl1)

    self.ObjectPool = ObjectPool.new(50)
    self.MessageCreators = GetMessageCreators()
    self.DefaultCreatorType = Util.DEFAULT_MESSAGE_CREATOR

    Util:RegisterObjectPool(self.ObjectPool)

    return self
end

function module.GetStringTextBounds(_, arg1, arg2, arg3, arg4)
    return Util:GetStringTextBounds(arg1, arg2, arg3, arg4)
end

return module

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T19:01:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TextChannelWindowParent = script:FindFirstAncestor("TextChannelWindow").Parent

local SharedFlags = require(TextChannelWindowParent.SharedFlags)
local Message = require(script.Parent.Message)
local TextChannelWindowAnalytics = require(script.Parent.TextChannelWindowAnalytics)
local TextChannelWindowPerfTracker = require(TextChannelWindowParent.ChatUIPrimitives).Telemetry.TextChannelWindowPerfTracker
local TextChatServiceIntegration = require(script.Parent.TextChatServiceIntegration)
local _createChannelMessagesStore = require(script.Parent.createChannelMessagesStore)
local isTextSourceMuted = require(script.Parent.isTextSourceMuted)
local connectHistoryReplay = require(script.Parent.connectHistoryReplay)

local FFlagExpChatTextChannelWindowHistoryReplay = require(script.Parent.Flags.FFlagExpChatTextChannelWindowHistoryReplay)

local getFFlagExpChatProtectedChatInternalAPIs = SharedFlags.getFFlagExpChatProtectedChatInternalAPIs
local getFFlagExpChatUseChatMuteStore = require(script.Parent.getFFlagExpChatUseChatMuteStore)

local function getMessageStatus(arg1): string
    local status = arg1.Status

    if status == Enum.TextChatMessageStatus.Success then
        return "success"
    end

    if status == Enum.TextChatMessageStatus.TextFilterFailed then
        return "filter_failed"
    end

    if status == Enum.TextChatMessageStatus.Floodchecked then
        return "floodchecked"
    end

    if status == Enum.TextChatMessageStatus.InvalidPrivacySettings then
        return "invalid_privacy_settings"
    end

    if status == Enum.TextChatMessageStatus.InvalidTextChannelPermissions then
        return "invalid_permissions"
    end

    if status == Enum.TextChatMessageStatus.MessageTooLong then
        return "message_too_long"
    end

    if status == Enum.TextChatMessageStatus.ModerationTimeout then
        return "moderation_timeout"
    end

    return "unknown"
end

local function createTextChatServiceBridge(service, str1: string, arg1, tbl1)
    local tbl2 = ({})

    local function connectChannel(arg2)
        if tbl2[arg2] then
            return
        end

        local bool1 = arg2.Name == "RBXSystem"
        local tbl3 = {
            (arg2.MessageReceived:Connect(function(arg3)
                if not arg3.TextSource and not bool1
                    or getFFlagExpChatUseChatMuteStore() and arg3.TextSource and isTextSourceMuted(arg3.TextSource)
                then
                    return
                end

                local var1 = TextChatServiceIntegration.mapTextChatMessage(arg3, str1)
                if var1.content == "" then
                    arg1.removeMessage(arg2, var1.messageId)
                else
                    arg1.upsertMessage(arg2, var1)
                end

                if arg3.TextSource and tostring(arg3.TextSource.UserId) ~= str1 then
                    TextChannelWindowPerfTracker.startReceiveInterval(arg3.MessageId, arg2.Name)
                end
                TextChannelWindowAnalytics.emit(TextChannelWindowAnalytics.Counters.MessageReceived, {
                    status = getMessageStatus(arg3),
                    target_text_channel_category = TextChannelWindowAnalytics.getChannelCategory(arg2.Name)
                })
            end))
        }

        tbl2[arg2] = tbl3

        local destroying = arg2.Destroying

        table.insert(tbl3, destroying:Connect(function()
            for _, value in tbl3 do
                value:Disconnect()
            end
            tbl2[arg2] = nil
        end))

        arg2.ChildRemoved:Connect(function(child: Instance)
            if child:IsA("TextSource") and tostring(child.UserId) == str1 then
                arg1.clearChannel(arg2)
            end
        end)
    end

    service.SendingMessage:Connect(function(textChatMessage: TextChatMessage)
        if not textChatMessage.TextSource
            or (if getFFlagExpChatProtectedChatInternalAPIs() then textChatMessage.TextInternal else textChatMessage.Text) == ""
        then
            return
        end

        local textChannel = textChatMessage.TextChannel
        if not textChannel then
            return
        end

        TextChannelWindowPerfTracker.startSendInterval(textChatMessage.MessageId, textChannel.Name)
        local var1 = TextChatServiceIntegration.mapSendingMessage(textChatMessage, str1)
        arg1.insertIfAbsent(textChannel, var1)
    end)

    for _, descendant in service:GetDescendants() do
        if descendant:IsA("TextChannel") then
            connectChannel(descendant)
        end
    end

    service.DescendantAdded:Connect(function(descendant: Instance)
        if descendant:IsA("TextChannel") then
            connectChannel(descendant)
        end
    end)
    service.DescendantRemoving:Connect(function(descendant: Instance)
        if descendant:IsA("TextChannel") then
            arg1.removeChannelEntry(descendant)
        end
    end)

    if not FFlagExpChatTextChannelWindowHistoryReplay then
        return
    end
    local function startHistoryReplay()
        connectHistoryReplay(function(arg2)
            local tbl3 = ({})
            for _, value in arg2 do
                local textChannel = value.TextChannel
                local textSource = value.TextSource
                if not textChannel or not textSource or getFFlagExpChatUseChatMuteStore() and isTextSourceMuted(textSource) then
                    continue
                end

                local var1 = TextChatServiceIntegration.mapTextChatMessage(value, str1)
                if var1.content ~= "" then
                    local var2 = tbl3[textChannel] or {}
                    tbl3[textChannel] = var2
                    table.insert(var2, Message.markHistorical(var1))
                end
            end

            for value, value2 in tbl3 do
                arg1.insertHistorical(value, value2)
            end
        end, {
            service = service,
            defer = if tbl1 then tbl1.defer else nil
        })
    end
    if tbl1 and tbl1.whenCanChat then
        tbl1.whenCanChat(startHistoryReplay)
        return
    end
    startHistoryReplay()
end

return createTextChatServiceBridge

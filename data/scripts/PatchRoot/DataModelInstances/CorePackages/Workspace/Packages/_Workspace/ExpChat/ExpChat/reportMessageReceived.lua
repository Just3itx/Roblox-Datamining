-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:20:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local Analytics = require(ExpChat.Parent.ExpChatShared).Analytics

local function getCounterName(arg1)
    if arg1.Status == Enum.TextChatMessageStatus.Success then
        local textChannel = arg1.TextChannel
        if textChannel then
            local textChannelName = textChannel.Name

            if string.find(textChannelName, "^RBX") == nil then
                return "expChatMessageReceivedSuccessCustom"
            end

            if textChannelName == "RBXGeneral" then
                return "expChatMessageReceivedSuccessGeneral"
            elseif textChannelName == "RBXSystem" then
                return "expChatMessageReceivedSuccessSystem"
            end

            if string.find(textChannelName, "^RBXWhisper") then
                return "expChatMessageReceivedSuccessWhisper"
            end

            if string.find(textChannelName, "^RBXTeam") then
                return "expChatMessageReceivedSuccessTeam"
            end

            return "expChatMessageReceivedSuccessCustom"
        end
    end

    if arg1.Status == Enum.TextChatMessageStatus.Unknown then
        return "expChatMessageReceivedUnknown"
    end

    if arg1.Status == Enum.TextChatMessageStatus.InvalidTextChannelPermissions then
        return "expChatMessageReceivedInvalidTextChannelPermissions"
    end

    if arg1.Status == Enum.TextChatMessageStatus.InvalidPrivacySettings then
        return "expChatMessageReceivedInvalidPrivacySettings"
    end

    if arg1.Status == Enum.TextChatMessageStatus.TextFilterFailed then
        return "expChatMessageReceivedTextFilterFailed"
    end

    if arg1.Status == Enum.TextChatMessageStatus.Floodchecked then
        return "expChatMessageReceivedFloodchecked"
    end

    if arg1.Status == Enum.TextChatMessageStatus.MessageTooLong then
        return "expChatMessageReceivedMessageTooLong"
    end

    if arg1.Status == Enum.TextChatMessageStatus.ModerationTimeout then
        return "expChatMessageReceivedModerationTimeout"
    end

    return nil
end

return function(userId: number, arg1)
    local textSource = arg1.TextSource
    if not textSource or userId ~= textSource.UserId then
        return
    end

    local counterName = getCounterName(arg1)

    if counterName then
        Analytics.reportCounter(counterName)
    end
end

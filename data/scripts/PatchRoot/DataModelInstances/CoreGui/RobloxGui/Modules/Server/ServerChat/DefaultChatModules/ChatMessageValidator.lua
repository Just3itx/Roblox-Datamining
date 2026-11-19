-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:40:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Chat = game:GetService("Chat")
local RunService = game:GetService("RunService")
local ClientChatModules = Chat:WaitForChild("ClientChatModules")
local ChatSettings = require(ClientChatModules:WaitForChild("ChatSettings"))
local ChatConstants = require(ClientChatModules:WaitForChild("ChatConstants"))

local var1 = nil

pcall(function()
    var1 = require(game:GetService("Chat").ClientChatModules.ChatLocalization)
end)

var1 = var1 == nil and {} or var1
if not (var1.FormatMessageToSend and var1.LocalizeFormattedMessage) then
    function var1.FormatMessageToSend<T>(_, _, arg1: T): T
        return arg1
    end
end

local tbl1 = {
    "\n",
    "\r",
    "\t",
    "\11",
    "\f"
}
if ChatSettings.DisallowedWhiteSpace then
    tbl1 = ChatSettings.DisallowedWhiteSpace
end

local function isMessageValidServer(str1: string): boolean
    return not (str1:len() > ChatSettings.MaximumMessageLength * 6)
        and not (utf8.len(str1) == nil)
        and not (utf8.len(utf8.nfcnormalize(str1)) > ChatSettings.MaximumMessageLength)
end

local function CanUserChat(player) -- Luacid: Inlined by compiler; 1 call site recovered
    if RunService:IsStudio() then
        return true
    end
    local success, result = pcall(function(): boolean
        return Chat:CanUserChatAsync(player.UserId)
    end)
    return success and result
end

local function Run(arg1)
    arg1:RegisterProcessCommandsFunction("message_validation", function(arg2, arg3, arg4) -- name: ValidateChatFunction
        local speaker = arg1:GetSpeaker(arg2)
        local player = speaker:GetPlayer()
        if not (speaker and player) then
            return false
        elseif not RunService:IsStudio() and player.UserId < 1 then
            return true
        elseif not CanUserChat(player) then
            speaker:SendSystemMessage(
                var1:FormatMessageToSend(
                    "GameChat_ChatMessageValidator_SettingsError",
                    "Your chat settings prevent you from sending messages."
                ),
                arg4
            )
            return true
        elseif not isMessageValidServer(arg3) then
            speaker:SendSystemMessage(
                var1:FormatMessageToSend(
                    "GameChat_ChatMessageValidator_MaxLengthError",
                    "Your message exceeds the maximum message length."
                ),
                arg4
            )
            return true
        else
            for _, value in pairs(tbl1) do
                if arg3:find(value) then
                    speaker:SendSystemMessage(
                        var1:FormatMessageToSend(
                            "GameChat_ChatMessageValidator_WhitespaceError",
                            "Your message contains whitespace that is not allowed."
                        ),
                        arg4
                    )
                    return true
                end
            end

            return false
        end
    end, ChatConstants.VeryHighPriority)
end

return Run

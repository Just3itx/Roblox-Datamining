-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T10:20:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TextChatService = game:GetService("TextChatService")
local RobloxReplicatedStorage = game:GetService("RobloxReplicatedStorage")

local ExpChatShared = script:FindFirstAncestor("ExpChatShared")

local ExpChatSharedParent = ExpChatShared.Parent
local Dictionary = require(ExpChatSharedParent.llama).Dictionary
local var1 = require(ExpChatShared.Logger):new("ExpChat/Command/Whisper")

local Actions = ExpChatShared.Actions
local ChatInputBarActivatedWhisperMode = require(Actions.ChatInputBarActivatedWhisperMode)

local Commands = script:FindFirstAncestor("Commands")
local getAutocompletePlayersFromString = require(Commands.getAutocompletePlayersFromString)
local getNameFromWhisper = require(Commands.Whisper.getNameFromWhisper)
local _types = require(Commands.types)

return {
    name = script.Name,
    alias = { "/whisper", "/w" },
    clientRun = function(arg1, num1: number, str1: string)
        local autoCastCommand = arg1:getState().AutoCastCommands[script.Name]
        local rbxName = getNameFromWhisper(str1, autoCastCommand)

        if rbxName then
            local Players = arg1:getState().Players
            local var2 = Dictionary.join(Players, { byUserId = Dictionary.removeKey(Players.byUserId, tostring(num1)) })

            local autocompletePlayersFromString = getAutocompletePlayersFromString(var2, rbxName)
            if #autocompletePlayersFromString == 0 then
                var1:debug("Autocomplete: No matches!")

                local var3 = Players.byUserId[tostring(num1)]
                return if var3 and (rbxName == var3.displayName or rbxName == "@" .. var3.username) then {
                    key = "InGame.UnknownNamespace.GameChat_PrivateMessaging_CannotWhisperToSelf",
                    args = nil,
                    metadata = "Roblox.Whisper.Error.CannotWhisperToSelf"
                } else {
                    key = "CoreScripts.TextChat.Mute.Error.TargetDoesNotExist",
                    args = {
                        RBX_NAME = rbxName or ""
                    },
                    metadata = "Roblox.Whisper.Error.TargetDoesNotExist"
                }
            end
            if #autocompletePlayersFromString ~= 1 then
                var1:debug("Autocomplete: Too many matches!")
                return {
                    key = "CoreScripts.TextChat.Whisper.Error.CannotChat",
                    metadata = "Roblox.Whisper.Error.TooManyMatches"
                }
            end

            local var3 = autocompletePlayersFromString[1]

            local var4 = tonumber(var3.userId)
            if var4 then
                local format = string.format
                local str2 = "RBXWhisper:%d_%d"
                local num2 = num1 < var4 and num1 or var4
                if var4 < num1 then
                    var4 = num1 or var4
                end

                local name = format(str2, num2, var4)

                local var5 = TextChatService:FindFirstChild(name, true)
                if not var5 then
                    local experienceChat = RobloxReplicatedStorage:FindFirstChild("ExperienceChat")
                    if not experienceChat then
                        var1:error("Could not create whisper channel because RobloxReplicatedStorage.ExperienceChat is missing.")

                        return { key = "", metadata = "Roblox.Whisper.Error.Unknown" }
                    end

                    local whisperChat = experienceChat:FindFirstChild("WhisperChat")
                    if not (whisperChat and whisperChat:IsA("RemoteFunction")) then
                        var1:error("Could not create whisper channel because WhisperChat RemoteFunction is missing.")

                        return { key = "", metadata = "Roblox.Whisper.Error.Unknown" }
                    end

                    var5 = whisperChat:InvokeServer(var3.userId)

                    if not var5 then
                        var1:error("Could not create whisper channel for some reason.")
                        return {
                            key = "CoreScripts.TextChat.Whisper.Error.CannotChat",
                            args = nil,
                            metadata = "Roblox.Whisper.Error.Unknown"
                        }
                    end
                end

                arg1:dispatch(ChatInputBarActivatedWhisperMode(nil, var5))

                return {
                    key = "CoreScripts.TextChat.Notification.WhisperChat.Created",
                    args = { RBX_NAME = rbxName },
                    metadata = "Roblox.Whisper.Info.Success"
                }
            end
        end

        return { key = "", metadata = "Roblox.Whisper.Error.Unknown" }
    end
}

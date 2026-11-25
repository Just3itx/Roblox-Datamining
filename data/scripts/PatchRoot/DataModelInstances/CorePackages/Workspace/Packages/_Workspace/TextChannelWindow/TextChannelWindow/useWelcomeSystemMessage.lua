-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T19:10:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local Players = game:GetService("Players")

local React = require(scriptParentParent.React)
local Message = require(script.Parent.Message)
local MessageWriterContext = require(script.Parent.MessageWriterContext)
local getWhisperChannelOtherDisplayName = require(script.Parent.getWhisperChannelOtherDisplayName)
local useInExperienceLocalization = require(scriptParentParent.ChatUIPrimitives).Hooks.useInExperienceLocalization

local FFlagExpChatTextChannelWindowWelcomeAndSummary = require(script.Parent.Flags.FFlagExpChatTextChannelWindowWelcomeAndSummary)

local var1 = (setmetatable({}, { __mode = "k" }))

local function isWhisperChannel(str1: string): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return string.find(str1.Name, "^RBXWhisper") ~= nil
end

local function useWelcomeSystemMessage(str1: string, str2: string)
    local var2 = MessageWriterContext.useMessageWriter()
    local var3 = useInExperienceLocalization()

    React.useEffect(function()
        if not FFlagExpChatTextChannelWindowWelcomeAndSummary or not var2 or str1 == nil then
            return
        end

        local str3 = str1

        if not isWhisperChannel(str3) or var1[str3] then
            return
        end

        local function trySend(): boolean
            if var1[str3] then
                return true
            end
            local rbxName = getWhisperChannelOtherDisplayName(str3, str2)
            if not rbxName then
                return false
            end
            local var4 = var3("CoreScripts.TextChat.Notification.WhisperChat.Created", { RBX_NAME = rbxName })
            if var4 == "" then
                return false
            end
            var1[str3] = true
            var2.write(Message.createSystemMessage(var4, "Roblox.Whisper.Welcome.Sent:" .. str3.Name))
            return true
        end

        if trySend() then
            return
        end

        local connection = nil
        local connection2 = nil
        local function cleanup() -- Luacid: Inlined by compiler; 1 call site recovered
            connection:Disconnect()
            connection2:Disconnect()
        end
        local function retry()
            if trySend() then
                cleanup()
            end
        end

        connection = str3.ChildAdded:Connect(retry)
        connection2 = Players.PlayerAdded:Connect(retry)
        return cleanup
    end, {
        var2,
        var3,
        str1,
        str2
    })
end
return useWelcomeSystemMessage

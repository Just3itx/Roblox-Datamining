-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:30:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Chat = game:GetService("Chat")
local Players = game:GetService("Players")

local scriptParent = script.Parent
local Util = require(scriptParent:WaitForChild("Util"))

local var1 = nil
pcall(function()
    var1 = require(Chat.ClientChatModules.ChatLocalization)
end)

var1 = var1 == nil and {
    Get = function<T>(_, _, arg1: T): T
        return arg1
    end
} or var1

local LocalPlayer = Players.LocalPlayer

local tbl1 = {
    wave = true,
    point = true,
    dance = true,
    dance2 = true,
    dance3 = true,
    laugh = true,
    cheer = true
}

local tbl2 = {
    ["InGame.Chat.Response.EmotesNotSupported"] = "You can't use Emotes here.",
    ["InGame.Chat.Response.EmotesWrongAvatarType"] = "Only R15 avatars can use Emotes.",
    ["InGame.Chat.ErrorMessageSwitchToR15"] = "Switch to your R15 avatar to play Emote.",
    ["InGame.Chat.Response.EmoteNotAvailable"] = "You can't use that Emote.",
    ["InGame.Chat.Response.EmotesTemporarilyUnavailable"] = "You can't use Emotes right now.",
    ["InGame.Chat.ErrorMessageAnimationPlaying"] = "You cannot play Emotes during this action."
}

local brightRed = Color3.fromRGB(245, 50, 50)

local function getEmoteName(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    if string.sub(arg1, 1, 3) == "/e " then
        return string.sub(arg1, 4)
    elseif string.sub(arg1, 1, 7) == "/emote " then
        return string.sub(arg1, 8)
    end

    return nil
end

local function sendErrorMessage(currentChannel, str1: string) -- Luacid: Inlined by compiler; 9 call sites recovered
    local var2 = var1:Get(str1, tbl2[str1])
    Util:SendSystemMessageToSelf(var2, currentChannel, { ChatColor = brightRed })
end

local function ProcessMessage(arg1, arg2, _): boolean
    local emoteName = getEmoteName(arg1)

    if not emoteName then
        return false
    elseif tbl1[emoteName] then
        return true
    else
        local currentChannel = arg2:GetCurrentChannel()
        if not currentChannel then
            return true
        end

        local character = LocalPlayer.Character
        if not character then
            sendErrorMessage(currentChannel, "InGame.Chat.Response.EmotesTemporarilyUnavailable")
            return true
        end

        local animate = character:FindFirstChild("Animate")
        if not (animate and animate:FindFirstChild("PlayEmote")) then
            sendErrorMessage(currentChannel, "InGame.Chat.Response.EmotesNotSupported")
            return true
        else
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if not humanoid then
                sendErrorMessage(currentChannel, "InGame.Chat.Response.EmotesTemporarilyUnavailable")
                return true
            elseif humanoid.RigType ~= Enum.HumanoidRigType.R15 then
                sendErrorMessage(currentChannel, "InGame.Chat.Response.EmotesWrongAvatarType")
                return true
            else
                local humanoidDescription = humanoid:FindFirstChildOfClass("HumanoidDescription")
                if not humanoidDescription then
                    sendErrorMessage(currentChannel, "InGame.Chat.Response.EmotesTemporarilyUnavailable")
                    return true
                end

                local tbl3 = {}

                local emotes = humanoidDescription:GetEmotes()
                for k, _ in pairs(emotes) do
                    tbl3[string.lower(k)] = k
                end

                local var2 = tonumber(emoteName)
                if var2 then
                    local equippedEmotes = humanoidDescription:GetEquippedEmotes()
                    for _, value in pairs(equippedEmotes) do
                        if value.Slot == var2 then
                            emoteName = value.Name
                        end
                    end
                end

                local emoteName2 = tbl3[string.lower(emoteName)]

                if not emoteName2 then
                    sendErrorMessage(currentChannel, "InGame.Chat.Response.EmoteNotAvailable")
                    return true
                end

                spawn(function()
                    local success, result = pcall(function(): boolean
                        return humanoid:PlayEmote(emoteName2)
                    end)
                    if not success then
                        sendErrorMessage(currentChannel, "InGame.Chat.Response.EmotesNotSupported")
                    elseif not result then
                        sendErrorMessage(currentChannel, "InGame.Chat.Response.EmotesTemporarilyUnavailable")
                    end
                end)

                return true
            end
        end
    end
end

return {
    [Util.KEY_COMMAND_PROCESSOR_TYPE] = Util.COMPLETED_MESSAGE_PROCESSOR,
    [Util.KEY_PROCESSOR_FUNCTION] = ProcessMessage
}

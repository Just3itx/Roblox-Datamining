-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:40:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Chat = game:GetService("Chat")
local Players = game:GetService("Players")
local _FriendService = game:GetService("FriendService")

local ClientChatModules = Chat:WaitForChild("ClientChatModules")
local ChatSettings = require(ClientChatModules:WaitForChild("ChatSettings"))
local _ChatConstants = require(ClientChatModules:WaitForChild("ChatConstants"))

local bool1 = false

local success, result = pcall(function()
    return UserSettings():IsUserFeatureEnabled("UserHandleFriendJoinNotifierOnClient")
end)
if success then
    bool1 = result
end

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
    ChatColor = Color3.fromRGB(255, 255, 255)
}
local function Run(arg1)
    local function ShowFriendJoinNotification() -- Luacid: Inlined by compiler; 1 call site recovered
        return bool1 == false and ChatSettings.ShowFriendJoinNotification ~= nil and ChatSettings.ShowFriendJoinNotification
    end

    local function SendFriendJoinNotification(arg2, player: Player)
        local speaker = arg1:GetSpeaker(arg2.Name)
        if not speaker then
            return
        end

        local playerName = player.Name
        if ChatSettings.PlayerDisplayNamesEnabled then
            playerName = player.DisplayName
        end

        speaker:SendSystemMessage(
            var1:FormatMessageToSend(
                "GameChat_FriendChatNotifier_JoinMessage",
                string.format("Your friend %s has joined the game.", playerName),
                "RBX_NAME",
                playerName
            ),
            "System",
            tbl1
        )
    end

    local function TrySendFriendNotification(arg2, player: Player) -- Luacid: Inlined by compiler; 1 call site recovered
        if arg2 == player then
            return
        end

        coroutine.wrap(function()
            if arg2:IsFriendsWith(player.UserId) then
                SendFriendJoinNotification(arg2, player)
            end
        end)()
    end

    if not ShowFriendJoinNotification() then
        return
    end

    Players.PlayerAdded:connect(function(player: Player)
        local players = Players:GetPlayers()
        for i = 1, #players do
            TrySendFriendNotification(players[i], player)
        end
    end)
end

return Run

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:01:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
local Players = game:GetService("Players")
local CorePackages = game:GetService("CorePackages")

local LocalPlayer = Players.LocalPlayer

local RobloxGui = CoreGui:WaitForChild("RobloxGui")
local RobloxTranslator = require(CorePackages.Workspace.Packages.RobloxTranslator)
local FriendingUtility = require(RobloxGui.Modules.FriendingUtility)
local SendNotificationInfo = RobloxGui:WaitForChild("SendNotificationInfo")
local FFlagRemoveHardCodedFriendLimitPrompt = require(RobloxGui.Modules.Flags.FFlagRemoveHardCodedFriendLimitPrompt)

local function RequestFriendship(player: Player, arg1)
    return function()
        coroutine.wrap(function()
            if FFlagRemoveHardCodedFriendLimitPrompt then
                RbxAnalyticsService:ReportCounter("PlayerDropDown-RequestFriendship")
                RbxAnalyticsService:TrackEvent("Game", "RequestFriendship", "PlayerDropDown")

                if player.Parent == Players then
                    LocalPlayer:RequestFriendship(player)
                end

                return
            end

            local friendCountAsync = FriendingUtility:GetFriendCountAsync(player.UserId)
            local friendCountAsync2 = FriendingUtility:GetFriendCountAsync(LocalPlayer.UserId)
            if not (friendCountAsync2 and friendCountAsync) then
                return
            end
            if friendCountAsync2 < 200 and friendCountAsync < 200 then
                RbxAnalyticsService:ReportCounter("PlayerDropDown-RequestFriendship")
                RbxAnalyticsService:TrackEvent("Game", "RequestFriendship", "PlayerDropDown")

                if player.Parent == Players then
                    LocalPlayer:RequestFriendship(player)
                end

                return
            end
            if friendCountAsync2 >= 200 then
                SendNotificationInfo:Fire({
                    Title = if arg1 then "Cannot accept friend request" else "Cannot send friend request",
                    Text = "You are at the max friends limit.",
                    Duration = 5
                })
                return
            end

            if not (friendCountAsync >= 200) then
                return
            end

            local title = if arg1 then "Cannot accept friend request" else "Cannot send friend request"
            local var1 = RobloxTranslator:FormatByKey("InGame.PlayerDropDown.OtherPlayerFriendLimit", { RBX_NAME = player.Name })

            SendNotificationInfo:Fire({ Title = title, Text = var1, Duration = 5 })
        end)()
    end
end

return RequestFriendship

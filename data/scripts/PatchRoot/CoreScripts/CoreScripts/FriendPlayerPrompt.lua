-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:31:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local StarterGui = game:GetService("StarterGui")
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
local IXPService = game:GetService("IXPService")
local CorePackages = game:GetService("CorePackages")

local RobloxGui = CoreGui.RobloxGui
local LocalPlayer = Players.LocalPlayer
while LocalPlayer == nil do
    Players.ChildAdded:wait()
    LocalPlayer = Players.LocalPlayer
end

local Modules = RobloxGui.Modules
local PromptCreator = require(Modules.PromptCreator)
local SocialUtil = require(Modules.SocialUtil)
local FriendingUtility = require(Modules.FriendingUtility)

local RobloxTranslator = require(CorePackages.Workspace.Packages.RobloxTranslator)
local UserRelationshipModals = require(CorePackages.Workspace.Packages.UserRelationshipModals)

local LegacyThumbnailUrls = require(Modules.Common.LegacyThumbnailUrls)
local FFlagRemoveHardCodedFriendLimitPrompt = require(Modules.Flags.FFlagRemoveHardCodedFriendLimitPrompt)
local bool1 = game:DefineFastFlag("FriendRequestModalIxpEnabled", false)
local layerName = game:DefineFastString("FriendRequestModalIxpLayer", "")

local _Thumbnail = LegacyThumbnailUrls.Thumbnail
local _Bust = LegacyThumbnailUrls.Bust

local Size150x150 = Enum.ThumbnailSize.Size150x150
local Size352x352 = Enum.ThumbnailSize.Size352x352

local HeadShot = Enum.ThumbnailType.HeadShot
local AvatarThumbnail = Enum.ThumbnailType.AvatarThumbnail

local function LocalizedGetString(arg1, arg2) -- Luacid: unused: defined but never referenced
    pcall(function()
        arg2 = RobloxTranslator:FormatByKey(arg1)
    end)
    return arg2
end

function createFetchImageFunction(...)
    local tbl1 = { ... }
    return function(arg1)
        spawn(function()
            local image = SocialUtil.GetPlayerImage(unpack(tbl1))
            if arg1 and arg1.Parent then
                arg1.Image = image
            end
        end)
    end
end

function SendFriendRequest(player: Player): boolean
    RbxAnalyticsService:ReportCounter("FriendPlayerPrompt-RequestFriendship")
    RbxAnalyticsService:TrackEvent("Game", "RequestFriendship", "FriendPlayerPrompt")

    return (pcall(function()
        LocalPlayer:RequestFriendship(player)
    end))
end

function AtFriendLimit(arg1): boolean
    assert(
        not FFlagRemoveHardCodedFriendLimitPrompt,
        "Should not call AtFriendLimit when FFlagRemoveHardCodedFriendLimitPrompt is enabled"
    )

    local friendCountAsync = FriendingUtility:GetFriendCountAsync(arg1.UserId)
    return not (friendCountAsync == nil) and FriendingUtility:MaxFriendCount() <= friendCountAsync
end

function DoPromptRequestFriendPlayer(player)
    if LocalPlayer:IsFriendsWithAsync(player.UserId) then
        return
    end

    if bool1 then
        IXPService:LogFlagLinkedUserLayerExposure(layerName)
    end
    UserRelationshipModals.launchPromptFriendRequestModal(player.UserId)
end

function PromptRequestFriendPlayer(player)
    if LocalPlayer.UserId < 0 then
        error("PromptSendFriendRequest can not be called for guests!")
    end
    if typeof(player) ~= "Instance" or not player:IsA("Player") then
        error("Invalid argument to PromptSendFriendRequest")

        return
    end

    if player.UserId < 0 then
        error("PromptSendFriendRequest can not be called on guests!")
    end
    if player == LocalPlayer then
        error("PromptSendFriendRequest: A user can not friend themselves!")
    end
    DoPromptRequestFriendPlayer(player)
end

function UnFriendPlayer(player: Player): boolean
    return (pcall(function()
        LocalPlayer:RevokeFriendship(player)
    end))
end

function DoPromptUnfriendPlayer(player)
    if not LocalPlayer:IsFriendsWithAsync(player.UserId) then
        return
    end

    local function promptCompletedCallback(arg1)
        if not arg1 or UnFriendPlayer(player) then
            return
        end

        while PromptCreator:IsCurrentlyPrompting() do
            wait()
        end

        local mainText = string.format("An error occurred while unfriending %s. Please try again later.", player.Name)

        PromptCreator:CreatePrompt({
            WindowTitle = "Error Unfriending Person",
            MainText = mainText,
            ConfirmationText = "Okay",
            CancelActive = false,
            Image = "",
            ImageConsoleVR = "",
            FetchImageFunction = createFetchImageFunction(player.UserId, Size150x150, HeadShot),
            FetchImageFunctionConsoleVR = createFetchImageFunction(player.UserId, Size352x352, AvatarThumbnail),
            StripeColor = Color3.fromRGB(183, 34, 54)
        })
    end

    local mainText = string.format("Would you like to remove %s from your friends list?", player.Name)

    PromptCreator:CreatePrompt({
        WindowTitle = "Unfriend Person?",
        MainText = mainText,
        ConfirmationText = "Unfriend",
        CancelText = "Cancel",
        CancelActive = true,
        Image = "",
        ImageConsoleVR = "",
        FetchImageFunction = createFetchImageFunction(player.UserId, Size150x150, HeadShot),
        FetchImageFunctionConsoleVR = createFetchImageFunction(player.UserId, Size352x352, AvatarThumbnail),
        PromptCompletedCallback = promptCompletedCallback
    })
end

function PromptUnfriendPlayer(player)
    if LocalPlayer.UserId < 0 then
        error("PromptUnfriend can not be called for guests!")
    end
    if typeof(player) ~= "Instance" or not player:IsA("Player") then
        error("Invalid argument to PromptUnfriend")

        return
    end

    if player.UserId < 0 then
        error("PromptUnfriend can not be called on guests!")
    end
    if player == LocalPlayer then
        error("PromptUnfriend: A user can not unfriend themselves!")
    end
    DoPromptUnfriendPlayer(player)
end
StarterGui:RegisterSetCore("PromptSendFriendRequest", PromptRequestFriendPlayer)
StarterGui:RegisterSetCore("PromptUnfriend", PromptUnfriendPlayer)

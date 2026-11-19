-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:31:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local SharedFlags = require(CorePackages.Workspace.Packages.SharedFlags)
local FFlagEnableModerateChatRemoteEvent = SharedFlags.FFlagEnableModerateChatRemoteEvent
local FFlagPlatformLeaderboardRccEnabled = SharedFlags.FFlagPlatformLeaderboardRccEnabled
local FFlagLuaAppsEnablePromptVIPServerPurchase = SharedFlags.FFlagLuaAppsEnablePromptVIPServerPurchase

local bool1 = game:DefineFastFlag("RemoteAllowListAddExpChatFeatureValueChanged", false)

return function()
    assert(game:FindService("NetworkServer") ~= nil)
    local NetworkServer = game:GetService("NetworkServer")

    local names = {}

    table.insert(names, "GetServerVersion")
    table.insert(names, "GetServerChannel")

    table.insert(names, "WhisperChat")

    table.insert(names, "GetServerType")

    table.insert(names, "ServerSideBulkPurchaseEvent")

    table.insert(names, "CanChatWith")
    table.insert(names, "SetPlayerBlockList")
    table.insert(names, "UpdatePlayerBlockList")
    table.insert(names, "NewPlayerGroupDetails")
    table.insert(names, "NewPlayerCanManageDetails")
    table.insert(names, "SendPlayerBlockList")
    table.insert(names, "UpdateLocalPlayerBlockList")
    table.insert(names, "SendPlayerProfileSettings")
    table.insert(names, "UpdatePlayerProfileSettings")
    table.insert(names, "ShowPlayerJoinedFriendsToast")
    table.insert(names, "ShowFriendJoinedPlayerToast")
    table.insert(names, "CreateOrJoinParty")
    table.insert(names, "RequestPlayerProfileSettings")
    if FFlagEnableModerateChatRemoteEvent then
        table.insert(names, "ModerateChatSettingUpdated")
    end
    if bool1 then
        table.insert(names, "ExpChatFeatureValueChanged")
    end

    table.insert(names, "SetDialogInUse")

    table.insert(names, "RequestDeviceCameraOrientationCapability")
    table.insert(names, "RequestDeviceCameraCFrame")
    table.insert(names, "ReplicateDeviceCameraCFrame")

    table.insert(names, "ReferredPlayerJoin")

    table.insert(names, "BuildExperiencePlaytestTeleport")

    if FFlagLuaAppsEnablePromptVIPServerPurchase then
        table.insert(names, "TeleportToPurchasedVIPServer")
    end

    table.insert(names, "SetUserActive")

    table.insert(names, "AvatarGesturesVRPlayer")

    if FFlagPlatformLeaderboardRccEnabled then
        table.insert(names, "PlatformLeaderboardPush")
        table.insert(names, "PlatformLeaderboardTabOpened")
        table.insert(names, "PlatformLeaderboardTabClosed")
    end

    NetworkServer:InitializeRemoteAllowList(names)
end

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:41:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local HttpRbxApiService = game:GetService("HttpRbxApiService")
local Players = game:GetService("Players")
local RobloxReplicatedStorage = game:GetService("RobloxReplicatedStorage")
local _RunService = game:GetService("RunService")
local Chat = game:GetService("Chat")
local TextChatService = game:GetService("TextChatService")
local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")
local RobloxGui = CoreGui:WaitForChild("RobloxGui")
local Url = require(CorePackages.Workspace.Packages.CoreScriptsCommon).Url
game:DefineFastFlag("EnableSetUserBlocklistInitialized", false)

local FFlagInExperienceUserProfileSettingsEnabled = require(RobloxGui.Modules.Common.Flags.FFlagInExperienceUserProfileSettingsEnabled)

local FFlagInExperienceRequestProfileSettings = require(RobloxGui.Modules.Common.Flags.FFlagInExperienceRequestProfileSettings)

local FStringRccInExperienceNameEnabledAllowList = require(RobloxGui.Modules.Common.Flags.FStringRccInExperienceNameEnabledAllowList)
local bool1 = game:DefineFastFlag("UseNewDirectChatAPI", false)
local bool2 = game:DefineFastFlag("EnableCreatePartyNudge", false)
local bool3 = game:DefineFastFlag("EnableCreatePartyNudgeWithVersion", false)

local FFlagEnablePartyNudgeAfterJoin = require(CorePackages.Workspace.Packages.SharedFlags).FFlagEnablePartyNudgeAfterJoin

local FFlagShowFriendJoinedYouToastForNonReferredJoins = require(CorePackages.Workspace.Packages.SharedFlags).FFlagShowFriendJoinedYouToastForNonReferredJoins

local FFlagBadgeVisibilitySettingEnabled = require(CorePackages.Workspace.Packages.SharedFlags).FFlagBadgeVisibilitySettingEnabled

local FFlagEnableModerateChatRemoteEvent = require(CorePackages.Workspace.Packages.SharedFlags).FFlagEnableModerateChatRemoteEvent

local FFlagEnableSummarySystemMessageOnLua = require(CorePackages.Workspace.Packages.SharedFlags).FFlagEnableSummarySystemMessageOnLua

local FFlagAIRephraseSettingEnabled = require(CorePackages.Workspace.Packages.SharedFlags).FFlagAIRephraseSettingEnabled

local FFlagChatSummariesSettingEnabled = require(CorePackages.Workspace.Packages.SharedFlags).FFlagChatSummariesSettingEnabled
local bool4 = game:DefineFastFlag("ProfileSettingsSlidingWindowRateLimit", false)
local num1 = game:DefineFastInt("ProfileSettingsRateLimitSeconds", 5)
local num2 = game:DefineFastInt("ProfileSettingsMaxRequestsPerWindow", 3)
local num3 = game:DefineFastInt("ProfileSettingsRateLimitWindowSeconds", 60)
local bool5 = game:DefineFastFlag("DisableRCCAntiHarrasmentAllowList", false)
local shouldShowFriendJoinedPlayerToast = require(RobloxGui.Modules.Server.shouldShowFriendJoinedPlayerToast)
local bool6 = game:DefineFastFlag("GatePrivateServerNudge", false)

local tbl1 = ({})

local tbl2 = {
    Admin = { GroupId = 1200769 },
    Intern = { GroupId = 2868472, GroupRank = 100 },
    Star = { GroupId = 4199740 },
    SpanishLocalizationExpert = { GroupId = 4265462, GroupRank = 252 },
    BrazilianLocalizationExpert = { GroupId = 4265456, GroupRank = 252 },
    FrenchLocalizationExpert = { GroupId = 4265443, GroupRank = 252 },
    GermanLocalizationExpert = { GroupId = 4265449, GroupRank = 252 }
}

if game.CreatorType == Enum.CreatorType.Group then
    tbl2.PlaceCreator = {
        GroupId = game.CreatorId,
        GroupRank = 255
    }
end

local tbl3 = ({})

local tbl4 = ({})

local tbl5 = ({})
local tbl6 = ({})
local tbl7 = ({})

game:DefineFastInt("MaxBlockListSize", 500)

local CanChatWith = Instance.new("RemoteEvent")
CanChatWith.Name = "CanChatWith"
CanChatWith.Parent = RobloxReplicatedStorage

local SetPlayerBlockList = Instance.new("RemoteEvent")
SetPlayerBlockList.Name = "SetPlayerBlockList"
SetPlayerBlockList.Parent = RobloxReplicatedStorage

local UpdatePlayerBlockList = Instance.new("RemoteEvent")
UpdatePlayerBlockList.Name = "UpdatePlayerBlockList"
UpdatePlayerBlockList.Parent = RobloxReplicatedStorage

local NewPlayerGroupDetails = Instance.new("RemoteEvent")
NewPlayerGroupDetails.Name = "NewPlayerGroupDetails"
NewPlayerGroupDetails.Parent = RobloxReplicatedStorage

local NewPlayerCanManageDetails = Instance.new("RemoteEvent")
NewPlayerCanManageDetails.Name = "NewPlayerCanManageDetails"
NewPlayerCanManageDetails.Parent = RobloxReplicatedStorage

local SendPlayerBlockList = Instance.new("RemoteEvent")
SendPlayerBlockList.Name = "SendPlayerBlockList"
SendPlayerBlockList.Parent = RobloxReplicatedStorage

local UpdateLocalPlayerBlockList = Instance.new("RemoteEvent")
UpdateLocalPlayerBlockList.Name = "UpdateLocalPlayerBlockList"
UpdateLocalPlayerBlockList.Parent = RobloxReplicatedStorage

local SendPlayerProfileSettings = Instance.new("RemoteEvent")
SendPlayerProfileSettings.Name = "SendPlayerProfileSettings"
SendPlayerProfileSettings.Parent = RobloxReplicatedStorage
local remoteEvent

if FFlagInExperienceRequestProfileSettings then
    remoteEvent = Instance.new("RemoteEvent")
    remoteEvent.Name = "RequestPlayerProfileSettings"
    remoteEvent.Parent = RobloxReplicatedStorage
else
    remoteEvent = nil
end

local remoteEvent2

if FFlagBadgeVisibilitySettingEnabled then
    remoteEvent2 = Instance.new("RemoteEvent")
    remoteEvent2.Name = "UpdatePlayerProfileSettings"
    remoteEvent2.Parent = RobloxReplicatedStorage
else
    remoteEvent2 = nil
end

local remoteEvent3 = nil
local remoteEvent4 = nil
if FFlagEnablePartyNudgeAfterJoin then
    remoteEvent4 = Instance.new("RemoteEvent")
    remoteEvent4.Name = "ShowPlayerJoinedFriendsToast"
    remoteEvent4.Parent = RobloxReplicatedStorage
end

if FFlagEnablePartyNudgeAfterJoin or FFlagShowFriendJoinedYouToastForNonReferredJoins then
    remoteEvent3 = Instance.new("RemoteEvent")
    remoteEvent3.Name = "ShowFriendJoinedPlayerToast"
    remoteEvent3.Parent = RobloxReplicatedStorage
end

local CreateOrJoinParty = Instance.new("RemoteEvent")
CreateOrJoinParty.Name = "CreateOrJoinParty"
CreateOrJoinParty.Parent = RobloxReplicatedStorage

local remoteEvent5 = nil
if FFlagEnableModerateChatRemoteEvent then
    remoteEvent5 = Instance.new("RemoteEvent")
    remoteEvent5.Name = "ModerateChatSettingUpdated"
    remoteEvent5.Parent = RobloxReplicatedStorage
end

local remoteEvent6 = nil
if FFlagEnableSummarySystemMessageOnLua or FFlagAIRephraseSettingEnabled or FFlagChatSummariesSettingEnabled then
    remoteEvent6 = Instance.new("RemoteEvent")
    remoteEvent6.Name = "ExpChatFeatureValueChanged"
    remoteEvent6.Parent = RobloxReplicatedStorage
end

local tbl8 = ({})

local function verifyUserId(arg1): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return type(arg1) == "number"
end

local function verifyBlockList(arguments)
    if #arguments == 0 or #arguments > game:GetFastInt("MaxBlockListSize") then
        return false
    end

    for _, argument in pairs(arguments) do
        if not verifyUserId(argument) then
            return false
        end
    end
    return true
end

local function sendPlayerAllGroupDetails(player: Player) -- Luacid: Inlined by compiler; 1 call site recovered
    NewPlayerGroupDetails:FireClient(player, tbl3)
end

local function getPlayerGroupDetails(player)
    local tbl9 = ({})
    for k, value in pairs(tbl2) do
        if value.GroupRank ~= nil then
            local success, result = pcall(function(): boolean
                return player:GetRankInGroupAsync(value.GroupId) >= value.GroupRank
            end)

            tbl9[k] = success and result
        else
            local success, result = pcall(function()
                return player:IsInGroupAsync(value.GroupId)
            end)

            tbl9[k] = success and result
        end
    end
    if not player.Parent then
        return
    end

    local str1 = tostring(player.UserId)
    tbl3[str1] = tbl9

    NewPlayerGroupDetails:FireAllClients({ [str1] = tbl9 })
end

local function sendCanChatWith(player: Player)
    local tbl9 = {}

    for _, player2 in ipairs(Players:GetPlayers()) do
        if bool1 then
            local success, result = pcall(function()
                return TextChatService:CanUsersDirectChatAsync(player.UserId, { player2.UserId })
            end)

            tbl9[player2.UserId] = success and #result > 0
            CanChatWith:FireClient(player2, { [player.UserId] = success and #result > 0 })
        else
            local success, result = pcall(function(): boolean
                return Chat:CanUsersChatAsync(player.UserId, player2.UserId)
            end)

            tbl9[player2.userId] = success and result
            CanChatWith:FireClient(player2, { [player.userId] = success and result })
        end
    end

    CanChatWith:FireClient(player, tbl9)
end

local function sendPlayerAllCanManage(player: Player)
    for k, value in pairs(tbl4) do
        NewPlayerCanManageDetails:FireClient(player, k, value)
    end
end

local function getPlayerCanManage(arg1)
    if arg1.UserId <= 0 or not arg1.Parent then
        return
    end

    local success, result = pcall(arg1.GetCanManageAsync, arg1)

    local bool7 = not not (success and result)

    local str1 = tostring(arg1.UserId)
    tbl4[str1] = bool7
    NewPlayerCanManageDetails:FireAllClients(str1, bool7)
end

local function sendPlayerBlockList(player: Player)
    if player.UserId <= 0 then
        return
    end

    local function scanAndSendBlockList(bool7: boolean)
        if not player.Parent then
            return
        end

        local tbl9 = {}
        for _, player2 in Players:GetPlayers() do
            if player2 == player then
                continue
            end

            if player:HasBlockedPlayer(player2.UserId) then
                tbl9[player2.UserId] = true
            end

            if bool7 and player2:HasBlockedPlayer(player.UserId) then
                UpdateLocalPlayerBlockList:FireClient(player2, player.UserId, true)
            end
        end

        SendPlayerBlockList:FireClient(player, tbl9)
    end

    local bool7 = false

    player.BlockListChanged:Connect(function()
        if not bool7 then
            scanAndSendBlockList(true)
            bool7 = true
            return
        end
        scanAndSendBlockList(false)
    end)

    if player:GetBlockListInitialized() then
        scanAndSendBlockList(true)
        bool7 = true
    end
end

local function sendPlayerAllInExperienceNameEnabled(player: Player)
    for k, isInExperienceNameEnabled in pairs(tbl5) do
        SendPlayerProfileSettings:FireClient(player, k, { isInExperienceNameEnabled = isInExperienceNameEnabled })
    end
end

local function func1(arg1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return pcall(function()
        local str1 = `user-profile-api/v1/user/profiles/rcc/settings?userId={arg1.UserId}`
        local apiUrl = Url.APIS_URL .. str1

        local asyncFullUrl = HttpRbxApiService:GetAsyncFullUrl(apiUrl, Enum.ThrottlingPriority.Default, Enum.HttpRequestType.Players)
        return HttpService:JSONDecode(asyncFullUrl)
    end)
end

local function func2(arg1)
    if arg1.UserId <= 0 then
        return
    end

    local bool7 = false

    if FStringRccInExperienceNameEnabledAllowList.isAllowListedUserId(arg1.UserId) or bool5 then
        local success, var1 = func1(arg1)

        if success and var1 then
            bool7 = var1.isSettingsEnabled and var1.userProfileSettings and var1.userProfileSettings.isInExperienceNameEnabled
        end
    end

    local str1 = tostring(arg1.UserId)
    tbl5[str1] = bool7
    SendPlayerProfileSettings:FireAllClients(str1, { isInExperienceNameEnabled = bool7 })
end

if FFlagInExperienceRequestProfileSettings then
    remoteEvent.OnServerEvent:Connect(function(player: Player)
        local str1 = tostring(player.UserId)
        local isInExperienceNameEnabled = tbl5[str1]
        if isInExperienceNameEnabled ~= nil then
            SendPlayerProfileSettings:FireClient(player, str1, { isInExperienceNameEnabled = isInExperienceNameEnabled })
            return
        end

        coroutine.wrap(func2)(player)
    end)
end

local function func3(inviterId, inviteeId, nudgeType: string): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return pcall(function()
        local apiUrl = string.format(Url.APIS_URL .. "group-up/v1/create-party-nudge")

        local str1 = HttpService:JSONEncode({
            inviterId = inviterId,
            inviteeId = inviteeId,
            nudgeType = nudgeType,
            placeId = game.PlaceId,
            gameInstanceId = game.JobId,
            universeId = game.GameId,
            version = if bool3 then 1 else nil,
            privateServerId = if bool6 then game.PrivateServerId else nil,
            privateServerOwnerId = if bool6 then game.PrivateServerOwnerId else nil
        })

        local input = HttpRbxApiService:PostAsyncFullUrl(apiUrl, str1)
        return HttpService:JSONDecode(input)
    end)
end

local function canCreatePartyNudge(arg1): boolean
    if not arg1 then
        return false
    end

    local tbl9 = {
        Windows = true,
        iOS = true,
        Android = true,
        OSX = true,
        Win32 = true,
        Windows_Universal = true
    }

    return arg1.PartyId == "" and arg1.VRDevice == "" and typeof(arg1.OsPlatform) == "string" and tbl9[arg1.OsPlatform]
end

local function func4(player: Player)
    local var1 = nil
    local players = Players:GetPlayers()
    for _, player2 in players do
        if player2.UserId == player.FollowUserId then
            var1 = player2
            break
        end
    end

    local success

    if FFlagEnablePartyNudgeAfterJoin and bool2 and canCreatePartyNudge(var1) and canCreatePartyNudge(player) then
        local var2
        success, var2 = func3(player.UserId, var1.UserId, "OneToOneNudgeInExperience")
        if success and var2 and var2.shouldAutoCreateOrJoinGroupUp then
            CreateOrJoinParty:FireClient(player, "PartyNudge", var2.nudge)
        end
    else
        success = false
    end

    if success or not (#players > 0) then
        return
    end
    if var1 and (not FFlagShowFriendJoinedYouToastForNonReferredJoins or shouldShowFriendJoinedPlayerToast(player)) then
        remoteEvent3:FireClient(var1, player)
    end

    if FFlagEnablePartyNudgeAfterJoin then
        remoteEvent4:FireClient(player)
    end
end

local function onPlayerAdded(player: Player)
    coroutine.wrap(sendPlayerBlockList)(player)
    sendPlayerAllGroupDetails(player)

    if player.UserId > 0 then
        coroutine.wrap(getPlayerGroupDetails)(player)
    end
    if FFlagInExperienceUserProfileSettingsEnabled then
        sendPlayerAllInExperienceNameEnabled(player)
        coroutine.wrap(func2)(player)
    end

    sendPlayerAllCanManage(player)
    coroutine.wrap(getPlayerCanManage)(player)

    sendCanChatWith(player)

    if FFlagEnablePartyNudgeAfterJoin or FFlagShowFriendJoinedYouToastForNonReferredJoins then
        coroutine.wrap(func4)(player)
    end
end

SetPlayerBlockList.OnServerEvent:Connect(function(player: Player, arguments)
    if game:GetFastFlag("EnableSetUserBlocklistInitialized") then
        player:SetBlockListInitialized()
    end
    if type(arguments) == "table" and verifyBlockList(arguments) then
        player:AddToBlockList(arguments)
    end
end)

UpdatePlayerBlockList.OnServerEvent:Connect(function(player: Player, arguments: number, arg1)
    if type(arg1) == "boolean" and verifyUserId(arguments) then
        player:UpdatePlayerBlocked(arguments, arg1)
    end
end)

if FFlagBadgeVisibilitySettingEnabled then
    remoteEvent2.OnServerEvent:Connect(function(player: Player, arg1)
        if type(arg1) ~= "table" then
            return
        end

        local tbl9 = {}
        if type(arg1.isInExperienceNameEnabled) ~= "boolean" then
            return
        end

        tbl9.isInExperienceNameEnabled = arg1.isInExperienceNameEnabled

        local str1 = tostring(player.UserId)
        local now = tick()

        if bool4 then
            if not tbl7[str1] then
                tbl7[str1] = {}
            end

            local var1 = tbl7[str1]
            local var2 = now - num3
            for i = #var1, 1, -1 do
                if var1[i] < var2 then
                    table.remove(var1, i)
                end
            end

            if #var1 >= num2 then
                return
            end

            table.insert(var1, now)
        else
            local var1 = tbl6[str1]
            if var1 and now - var1 < num1 then
                return
            end

            tbl6[str1] = now
        end
        tbl5[str1] = tbl9.isInExperienceNameEnabled

        SendPlayerProfileSettings:FireAllClients(str1, tbl9)
    end)
end

if FFlagEnableModerateChatRemoteEvent then
    remoteEvent5.OnServerEvent:Connect(function(player: Player, arg1)
        if typeof(arg1) == "boolean" and TextChatService:setModerationModeEnabled(player.UserId, arg1) then
            remoteEvent5:FireClient(player, arg1)
        end
    end)
end

if FFlagEnableSummarySystemMessageOnLua or FFlagAIRephraseSettingEnabled or FFlagChatSummariesSettingEnabled then
    TextChatService.ExpChatFeatureValueChanged:Connect(function(userId: number, featureName: string, featureValue: string)
        local player = Players:GetPlayerByUserId(userId)
        if player then
            remoteEvent6:FireClient(player, userId, featureName, featureValue)
        end
    end)
end

Players.PlayerAdded:connect(onPlayerAdded)
for _, player in pairs(Players:GetPlayers()) do
    onPlayerAdded(player)
end

Players.PlayerRemoving:connect(function(player: Player)
    local str1 = tostring(player.UserId)
    if tbl1[str1] then
        tbl1[str1] = nil
        tbl8[str1] = nil
    end
    if tbl3[str1] then
        tbl3[str1] = nil
    end
    if tbl4[str1] ~= nil then
        tbl4[str1] = nil
    end
    if tbl5[str1] ~= nil then
        tbl5[str1] = nil
    end
    if not FFlagBadgeVisibilitySettingEnabled then
        return
    end

    if bool4 then
        if tbl7[str1] ~= nil then
            tbl7[str1] = nil
        end
    elseif tbl6[str1] ~= nil then
        tbl6[str1] = nil
    end
end)

local function func5() end
for _, child in ipairs(RobloxReplicatedStorage:GetChildren()) do
    if child:IsA("RemoteEvent") then
        child.OnServerEvent:Connect(func5)
    end
end

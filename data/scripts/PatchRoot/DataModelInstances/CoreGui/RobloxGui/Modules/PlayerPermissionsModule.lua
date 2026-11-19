-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:01:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}

local Players = game:GetService("Players")
local RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")
local _Modules = RobloxGui:WaitForChild("Modules")
local CorePackages = game:GetService("CorePackages")
local HttpRbxApiService = game:GetService("HttpRbxApiService")
local HttpService = game:GetService("HttpService")
local _GameSettings = UserSettings().GameSettings

local Url = require(CorePackages.Workspace.Packages.CoreScriptsCommon).Url
local FFlagInExperienceUserProfileSettingsEnabled = require(RobloxGui.Modules.Common.Flags.FFlagInExperienceUserProfileSettingsEnabled)
local FFlagBadgeVisibilitySettingEnabled = require(CorePackages.Workspace.Packages.SharedFlags).FFlagBadgeVisibilitySettingEnabled
local FFlagInExperienceRequestProfileSettings = require(RobloxGui.Modules.Common.Flags.FFlagInExperienceRequestProfileSettings)

local VerifiedBadgeDisplayStore = require(CorePackages.Workspace.Packages.UserProfiles).Stores.VerifiedBadgeDisplayStore
local FFlagEnableVerifiedBadgeStore = require(CorePackages.Workspace.Packages.SharedFlags).FFlagEnableVerifiedBadgeStore

local tbl1 = {}
tbl1.__index = tbl1

function tbl1.new(player)
    local self = setmetatable({}, tbl1)
    self.player = player
    self.pendingGroupData = {}
    self.pendingCanManage = {}
    self.pendingProfileSettings = {}
    self.groupData = nil
    self.canManage = nil
    self.profileSettings = nil
    return self
end

function tbl1:getGroupDataAsync()
    if self.groupData then
        return self.groupData
    end

    local thread = coroutine.running()
    table.insert(self.pendingGroupData, thread)
    coroutine.yield()
    return self.groupData
end

function tbl1:getCanManageAsync()
    if self.canManage ~= nil then
        return self.canManage
    end

    local thread = coroutine.running()
    table.insert(self.pendingCanManage, thread)
    coroutine.yield()
    return self.canManage
end

function tbl1:getProfileSettingsAsync()
    if self.profileSettings ~= nil then
        return self.profileSettings
    end

    local thread = coroutine.running()
    table.insert(self.pendingProfileSettings, thread)
    coroutine.yield()
    return self.profileSettings
end

function tbl1:setGroupData(groupData)
    self.groupData = groupData
    local pendingGroupData = self.pendingGroupData
    self.pendingGroupData = {}
    for _, value in pairs(pendingGroupData) do
        coroutine.resume(value)
    end
end

function tbl1:setCanManage(arg1)
    self.canManage = not not arg1
    local pendingCanManage = self.pendingCanManage
    self.pendingCanManage = {}
    for _, value in pairs(pendingCanManage) do
        coroutine.resume(value)
    end
end

function tbl1:setProfileSettings(profileSettings)
    self.profileSettings = profileSettings
    local pendingProfileSettings = self.pendingProfileSettings
    self.pendingProfileSettings = {}
    for _, pendingProfileSetting in pairs(pendingProfileSettings) do
        coroutine.resume(pendingProfileSetting)
    end
end

function tbl1:destroy()
    for _, value in pairs(self.pendingGroupData) do
        coroutine.resume(value)
    end
    for _, value in pairs(self.pendingCanManage) do
        coroutine.resume(value)
    end
    if not FFlagInExperienceUserProfileSettingsEnabled then
        return
    end

    for _, pendingProfileSetting in pairs(self.pendingProfileSettings) do
        coroutine.resume(pendingProfileSetting)
    end
end

local tbl2 = ({})

local function getPlayerInfo(arg1) -- Luacid: Inlined by compiler; 16 call sites recovered
    local var1 = tbl2[arg1]
    if not var1 and arg1.Parent ~= nil then
        var1 = tbl1.new(arg1)
        tbl2[arg1] = var1
    end
    return var1
end

spawn(function()
    game:GetService("RobloxReplicatedStorage"):WaitForChild("NewPlayerGroupDetails", math.huge).OnClientEvent:Connect(
        function(...)
            local tbl3 = { ... }

            if #tbl3 == 1 then
                for k, value in pairs(tbl3[1]) do
                    local playerByUserId = Players:GetPlayerByUserId(tonumber(k))
                    if not playerByUserId then
                        continue
                    end

                    local playerInfo = getPlayerInfo(playerByUserId)

                    if playerInfo then
                        playerInfo:setGroupData(value)
                    end
                end

                return
            end

            local var1 = tbl3[2]
            local playerByUserId = Players:GetPlayerByUserId(tonumber(tbl3[1]))
            if not playerByUserId then
                return
            end

            local playerInfo = getPlayerInfo(playerByUserId)

            if playerInfo then
                playerInfo:setGroupData(var1)
            end
        end
    )
end)

coroutine.wrap(function()
    game:GetService("RobloxReplicatedStorage"):WaitForChild("NewPlayerCanManageDetails", math.huge).OnClientEvent:Connect(
        function(arg1, arg2)
            local playerByUserId = Players:GetPlayerByUserId(tonumber(arg1))
            if not playerByUserId then
                return
            end

            local playerInfo = getPlayerInfo(playerByUserId)

            if playerInfo then
                playerInfo:setCanManage(arg2)
            end
        end
    )
end)()

if FFlagInExperienceUserProfileSettingsEnabled then
    coroutine.wrap(function()
        local RobloxReplicatedStorage = game:GetService("RobloxReplicatedStorage")
        RobloxReplicatedStorage:WaitForChild("SendPlayerProfileSettings", math.huge).OnClientEvent:Connect(function(arg1, arg2)
            local playerByUserId = Players:GetPlayerByUserId(tonumber(arg1))
            if not playerByUserId then
                return
            end

            local playerInfo = getPlayerInfo(playerByUserId)

            if playerInfo then
                playerInfo:setProfileSettings(arg2)
            end

            if FFlagEnableVerifiedBadgeStore and arg2.isInExperienceNameEnabled ~= nil then
                VerifiedBadgeDisplayStore.get().setBadgeVisibility(playerByUserId.UserId, not arg2.isInExperienceNameEnabled)
            end
        end)

        if FFlagInExperienceRequestProfileSettings then
            RobloxReplicatedStorage:WaitForChild("RequestPlayerProfileSettings", math.huge):FireServer()
        end
    end)()
end

Players.PlayerRemoving:Connect(function(player: Player)
    if tbl2[player] then
        local var1 = tbl2[player]
        tbl2[player] = nil
        var1:destroy()
    end
end)

local function NewInGroupFunctionFactory(str1: string) -- Luacid: Inlined by compiler; 9 call sites recovered
    return function(arg1)
        local playerInfo = getPlayerInfo(arg1)

        if playerInfo then
            local groupDataAsync = playerInfo:getGroupDataAsync()
            if groupDataAsync and groupDataAsync[str1] then
                return true
            end
        end
        return false
    end
end

local tbl3 = {
    NewInGroupFunctionFactory("SpanishLocalizationExpert"),
    NewInGroupFunctionFactory("BrazilianLocalizationExpert"),
    NewInGroupFunctionFactory("FrenchLocalizationExpert"),
    (NewInGroupFunctionFactory("GermanLocalizationExpert"))
}

local function NewIsLocalizationExpertFunctionFactory() -- Luacid: Inlined by compiler; 1 call site recovered
    return function(arg1)
        for i = 1, #tbl3 do
            if tbl3[i](arg1) then
                return true
            end
        end
        return false
    end
end

local function IsPlaceOwnerFunctionFactory() -- Luacid: unused: defined but never referenced
    if game.CreatorType == Enum.CreatorType.Group then
        return (NewInGroupFunctionFactory("PlaceCreator"))
    end

    return function(arg1): boolean
        return arg1.UserId == game.CreatorId
    end
end

local function IsPlayerInExperienceNameEnabled(arg1)
    local playerInfo = getPlayerInfo(arg1)

    if playerInfo then
        local profileSettingsAsync = playerInfo:getProfileSettingsAsync()
        if profileSettingsAsync then
            return profileSettingsAsync.isInExperienceNameEnabled
        end
    end
    return false
end

local function SetPlayerInExperienceNameEnabled(_, isInExperienceNameEnabled)
    pcall(function()
        local updatePlayerProfileSettings = game:GetService("RobloxReplicatedStorage"):WaitForChild("UpdatePlayerProfileSettings", math.huge)

        local apiUrl = Url.APIS_URL .. "user-profile-api/v1/user/profiles/settings"
        local str1 = HttpService:JSONEncode({ userProfileSettings = { isInExperienceNameEnabled = isInExperienceNameEnabled } })

        HttpRbxApiService:PostAsyncFullUrl(
            apiUrl,
            str1,
            Enum.ThrottlingPriority.Default,
            Enum.HttpContentType.ApplicationJson,
            Enum.HttpRequestType.Players
        )
        updatePlayerProfileSettings:FireServer({ isInExperienceNameEnabled = isInExperienceNameEnabled })
    end)
end

module.IsPlayerAdminAsync = NewInGroupFunctionFactory("Admin")
module.IsPlayerInternAsync = NewInGroupFunctionFactory("Intern")
module.IsPlayerStarAsync = NewInGroupFunctionFactory("Star")
module.IsPlayerLocalizationExpertAsync = NewIsLocalizationExpertFunctionFactory()

module.IsPlayerPlaceOwnerAsync = game.CreatorType ~= Enum.CreatorType.Group and function(arg1): boolean
    return arg1.UserId == game.CreatorId
end or NewInGroupFunctionFactory("PlaceCreator")

function module.CanPlayerManagePlaceAsync(arg1)
    local playerInfo = getPlayerInfo(arg1)
    return if playerInfo then playerInfo:getCanManageAsync() or false else false
end

if FFlagInExperienceUserProfileSettingsEnabled then
    module.IsPlayerInExperienceNameEnabledAsync = IsPlayerInExperienceNameEnabled
end
if FFlagBadgeVisibilitySettingEnabled then
    module.SetPlayerInExperienceNameEnabled = SetPlayerInExperienceNameEnabled
end

return module

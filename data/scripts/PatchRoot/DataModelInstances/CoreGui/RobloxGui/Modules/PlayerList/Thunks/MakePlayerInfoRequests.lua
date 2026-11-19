-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:01:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local CorePackages = game:GetService("CorePackages")

local RobloxGui = CoreGui:WaitForChild("RobloxGui")

local PlayerPermissionsModule = require(RobloxGui.Modules.PlayerPermissionsModule)
local TenFootInterface = require(RobloxGui.Modules.TenFootInterface)

local PlayerList = require(CorePackages.Workspace.Packages.PlayerList)

local BlockingUtility = require(CorePackages.Workspace.Packages.BlockingUtility)

local FFlagInExperienceUserProfileSettingsEnabled = require(RobloxGui.Modules.Common.Flags.FFlagInExperienceUserProfileSettingsEnabled)
local SharedFlags = require(CorePackages.Workspace.Packages.SharedFlags)
local FFlagBadgeVisibilitySettingEnabled = SharedFlags.FFlagBadgeVisibilitySettingEnabled
local FFlagReplacePlayerIconRoduxWithSignal = SharedFlags.FFlagReplacePlayerIconRoduxWithSignal
local FFlagEnableMobilePlayerListOnConsole = PlayerList.Flags.FFlagEnableMobilePlayerListOnConsole
local bool1 = game:DefineFastFlag("EnableBadgeCheckForUserCreator", false)

local PlayerIconInfoStore = require(CorePackages.Workspace.Packages.PlayerIconInfoStore).PlayerIconInfoStore

local Images = require(CorePackages.Packages.UIBlox).App.ImageSet.Images

local scriptParentParent = script.Parent.Parent

local tbl1 = {
    Admin = Images["icons/status/player/admin"],
    Intern = Images["icons/status/player/intern"],
    Star = Images["icons/status/player/videostar"]
}

local SetPlayerSpecialGroupIcon = require(scriptParentParent.Actions.SetPlayerSpecialGroupIcon)
local SetPlayerIsCreator = require(scriptParentParent.Actions.SetPlayerIsCreator)
local SetPlayerAvatarIcon = require(scriptParentParent.Actions.SetPlayerAvatarIcon)
local SetPlayerIsBlocked = require(scriptParentParent.Actions.SetPlayerIsBlocked)
local SetPlayerFriendStatus = require(scriptParentParent.Actions.SetPlayerFriendStatus)

local function dispatchIfPlayerExists(arg1, arg2, arg3)
    local players = arg1:getState().players
    local bool2 = false
    for _, player in ipairs(players) do
        if arg2 == player then
            bool2 = true
            break
        end
    end

    if bool2 then
        arg1:dispatch(arg3)
    end
end

local function isInExperienceNameEnabled(arg1): boolean -- Luacid: Inlined by compiler; 6 call sites recovered
    return not not (FFlagInExperienceUserProfileSettingsEnabled and PlayerPermissionsModule.IsPlayerInExperienceNameEnabledAsync(arg1))
end

local function getGroupsPermissionsInfo(arg1, arg2)
    if FFlagBadgeVisibilitySettingEnabled then
        local var1 = nil
        if PlayerPermissionsModule.IsPlayerAdminAsync(arg2) then
            var1 = tbl1.Admin
        elseif PlayerPermissionsModule.IsPlayerStarAsync(arg2) then
            var1 = tbl1.Star
        elseif PlayerPermissionsModule.IsPlayerInternAsync(arg2) then
            var1 = tbl1.Intern
        end

        if var1 then
            if FFlagReplacePlayerIconRoduxWithSignal then
                local var2 = PlayerIconInfoStore.getPlayerIconInfoReactive(arg2.UserId)(false)
                PlayerIconInfoStore.setPlayerIconInfo(
                    arg2.UserId,
                    {
                        isPlaceOwner = var2.isPlaceOwner,
                        avatarIcon = var2.avatarIcon,
                        specialGroupIcon = var1
                    }
                )
                return
            end

            local var2 = if isInExperienceNameEnabled(arg2) then nil else var1 or nil
            dispatchIfPlayerExists(arg1, arg2, SetPlayerSpecialGroupIcon(arg2, var2))
        end

        return
    end

    if PlayerPermissionsModule.IsPlayerAdminAsync(arg2) then
        if FFlagReplacePlayerIconRoduxWithSignal then
            local var1 = PlayerIconInfoStore.getPlayerIconInfoReactive(arg2.UserId)(false)
            PlayerIconInfoStore.setPlayerIconInfo(
                arg2.UserId,
                {
                    isPlaceOwner = var1.isPlaceOwner,
                    avatarIcon = var1.avatarIcon,
                    specialGroupIcon = tbl1.Admin
                }
            )
            return
        end

        if not isInExperienceNameEnabled(arg2) then
            dispatchIfPlayerExists(arg1, arg2, SetPlayerSpecialGroupIcon(arg2, tbl1.Admin))
        end

        return
    end

    if PlayerPermissionsModule.IsPlayerStarAsync(arg2) then
        if FFlagReplacePlayerIconRoduxWithSignal then
            local var1 = PlayerIconInfoStore.getPlayerIconInfoReactive(arg2.UserId)(false)
            PlayerIconInfoStore.setPlayerIconInfo(
                arg2.UserId,
                {
                    isPlaceOwner = var1.isPlaceOwner,
                    avatarIcon = var1.avatarIcon,
                    specialGroupIcon = tbl1.Star
                }
            )
            return
        end

        if not isInExperienceNameEnabled(arg2) then
            dispatchIfPlayerExists(arg1, arg2, SetPlayerSpecialGroupIcon(arg2, tbl1.Star))
        end
    elseif PlayerPermissionsModule.IsPlayerInternAsync(arg2) then
        if FFlagReplacePlayerIconRoduxWithSignal then
            local var1 = PlayerIconInfoStore.getPlayerIconInfoReactive(arg2.UserId)(false)
            PlayerIconInfoStore.setPlayerIconInfo(
                arg2.UserId,
                {
                    isPlaceOwner = var1.isPlaceOwner,
                    avatarIcon = var1.avatarIcon,
                    specialGroupIcon = tbl1.Intern
                }
            )
            return
        end

        if not isInExperienceNameEnabled(arg2) then
            dispatchIfPlayerExists(arg1, arg2, SetPlayerSpecialGroupIcon(arg2, tbl1.Intern))
        end
    end
end

local function getGameCreator(arg1, arg2)
    if not bool1 and game.CreatorType ~= Enum.CreatorType.Group then
        return
    end

    if not PlayerPermissionsModule.CanPlayerManagePlaceAsync(arg2) then
        return
    end

    if not FFlagReplacePlayerIconRoduxWithSignal then
        if not isInExperienceNameEnabled(arg2) then
            dispatchIfPlayerExists(arg1, arg2, SetPlayerIsCreator(arg2, true))
        end

        return
    end

    local var1 = PlayerIconInfoStore.getPlayerIconInfoReactive(arg2.UserId)(false)
    PlayerIconInfoStore.setPlayerIconInfo(
        arg2.UserId,
        {
            isPlaceOwner = true,
            avatarIcon = var1.avatarIcon,
            specialGroupIcon = var1.specialGroupIcon
        }
    )
end

local function getPlayerAvatarIcon(arg1, arg2)
    if FFlagEnableMobilePlayerListOnConsole or not TenFootInterface:IsEnabled() then
        return
    end

    local avatarIcon = "rbxthumb://type=Avatar&id=" .. arg2.UserId .. "&w=100&h=100"
    if not FFlagReplacePlayerIconRoduxWithSignal then
        dispatchIfPlayerExists(arg1, arg2, SetPlayerAvatarIcon(arg2, avatarIcon))

        return
    end

    local var2 = PlayerIconInfoStore.getPlayerIconInfoReactive(arg2.UserId)(false)
    PlayerIconInfoStore.setPlayerIconInfo(
        arg2.UserId,
        {
            isPlaceOwner = var2.isPlaceOwner,
            avatarIcon = avatarIcon,
            specialGroupIcon = var2.specialGroupIcon
        }
    )
end

local function getPlayerIsBlocked(arg1, arg2)
    if BlockingUtility:IsPlayerBlockedByUserId(arg2.UserId) then
        dispatchIfPlayerExists(arg1, arg2, SetPlayerIsBlocked(arg2, true))
    end
end

local function getPlayerFriendStatus(arg1, player: Player)
    if player ~= Players.LocalPlayer and player.Parent == Players and Players.LocalPlayer.Parent == Players then
        dispatchIfPlayerExists(arg1, player, SetPlayerFriendStatus(player, Players.LocalPlayer:GetFriendStatus(player)))
    end
end

local function MakePlayerInfoRequests(arg1)
    return function(arg2)
        if FFlagReplacePlayerIconRoduxWithSignal then
            coroutine.wrap(function()
                if isInExperienceNameEnabled(arg1) then
                    PlayerIconInfoStore.setPlayerIconInfo(arg1.UserId, { isPlaceOwner = false, avatarIcon = nil, specialGroupIcon = nil })
                    return
                end

                coroutine.wrap(getGroupsPermissionsInfo)(arg2, arg1)
                coroutine.wrap(getGameCreator)(arg2, arg1)
                coroutine.wrap(getPlayerAvatarIcon)(arg2, arg1)
            end)()
        else
            coroutine.wrap(getGroupsPermissionsInfo)(arg2, arg1)
            coroutine.wrap(getGameCreator)(arg2, arg1)
            coroutine.wrap(getPlayerAvatarIcon)(arg2, arg1)
        end
        coroutine.wrap(getPlayerIsBlocked)(arg2, arg1)
        coroutine.wrap(getPlayerFriendStatus)(arg2, arg1)
    end
end

return MakePlayerInfoRequests

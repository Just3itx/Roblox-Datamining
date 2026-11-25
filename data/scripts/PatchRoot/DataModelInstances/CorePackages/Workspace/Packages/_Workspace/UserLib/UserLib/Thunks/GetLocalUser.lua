-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T20:21:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")
local UserLib = script:FindFirstAncestor("UserLib")
local UserLibParent = UserLib.Parent

local mutedError = require(UserLibParent.Loggers).mutedError
local isPlayerVerified = require(UserLib.Utils.isPlayerVerified)
local Actions = require(UserLib.Actions)
local AddUser = Actions.AddUser
local SetLocalUserId = Actions.SetLocalUserId
local SetUserMembershipType = Actions.SetUserMembershipType
local SetUserHasRobloxSubscription = Actions.SetUserHasRobloxSubscription
local SetLocalUserUnder13 = Actions.SetLocalUserUnder13
local UserModel = require(UserLib.Models).UserModel

local SharedFlags = require(UserLibParent.SharedFlags)
local FFlagEnableBlackbirdCheck = SharedFlags.FFlagEnableBlackbirdCheck
local FFlagUseSignalsForIsLocalUserUnder13 = SharedFlags.FFlagUseSignalsForIsLocalUserUnder13
local GetIsLocalUserUnder13Store = if FFlagUseSignalsForIsLocalUserUnder13 then require(UserLib.Stores.GetIsLocalUserUnder13Store) else nil

local function getHasRobloxSubscription(player: Player): boolean
    if not FFlagEnableBlackbirdCheck then
        return false
    end
    if not game:GetEngineFeature("ReadHasRobloxSubscriptionLua") then
        return false
    end
    local success, result = pcall(function(): boolean
        return player.HasRobloxSubscription
    end)
    if not success then
        mutedError("[GetLocalUser] Failed to read HasRobloxSubscription: " .. tostring(result))
    end
    return success and result == true
end

return function()
    return function(arg1)
        local localPlayer = Players.LocalPlayer
        local id = tostring(localPlayer.UserId)
        local dataTable = UserModel.fromDataTable({
            id = id,
            name = localPlayer.Name,
            displayName = localPlayer.displayName,
            isFriend = false,
            hasVerifiedBadge = isPlayerVerified(localPlayer)
        })

        arg1:dispatch(AddUser(dataTable))
        arg1:dispatch(SetLocalUserId(id))
        arg1:dispatch(SetUserMembershipType(id, localPlayer.MembershipType))
        if FFlagEnableBlackbirdCheck then
            arg1:dispatch(SetUserHasRobloxSubscription(id, (getHasRobloxSubscription(localPlayer))))
        end
        if FFlagUseSignalsForIsLocalUserUnder13 then
            GetIsLocalUserUnder13Store(false).setIsLocalUserUnder13(localPlayer:GetUnder13())
            return
        end
        arg1:dispatch(SetLocalUserUnder13(localPlayer:GetUnder13()))
    end
end

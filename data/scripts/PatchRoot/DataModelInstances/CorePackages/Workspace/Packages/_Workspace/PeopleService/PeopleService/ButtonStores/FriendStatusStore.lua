-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T01:50:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")

local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local Signals = require(scriptParentParentParent.Signals)
local PeopleUtility = require(scriptParentParent.PeopleUtility)
local ButtonVariant = require(scriptParentParentParent.Foundation).Enums.ButtonVariant

local PeopleBlockStatusStore = require(script.Parent.PeopleBlockStatusStore)

local function createFriendStatusStore()
    local localPlayer = Players.LocalPlayer

    local tbl1 = ({})

    local connection = nil

    local function getCurrentFriendStatus(userId: number) -- Luacid: Inlined by compiler; 3 call sites recovered
        if not (userId and localPlayer) then
            return Enum.FriendStatus.Unknown
        end

        local success, result = pcall(function()
            local player = Players:GetPlayerByUserId(userId)
            if player then
                return localPlayer:GetFriendStatus(player)
            end
            return Enum.FriendStatus.Unknown
        end)

        return success and result or Enum.FriendStatus.Unknown
    end

    local function getFriendStatusSignal(userId: number)
        if not userId then
            return Signals.createSignal(Enum.FriendStatus.Unknown)
        end

        if tbl1[userId] then
            return tbl1[userId].getter
        end

        local currentFriendStatus

        if not (userId and localPlayer) then
            currentFriendStatus = getCurrentFriendStatus(false)
        else
            local success, result = pcall(function()
                local player = Players:GetPlayerByUserId(userId)
                if player then
                    return localPlayer:GetFriendStatus(player)
                end
                return (getCurrentFriendStatus(false))
            end)

            currentFriendStatus = success and result or getCurrentFriendStatus(false)
        end

        local getter, setter = Signals.createSignal(currentFriendStatus)

        tbl1[userId] = { getter = getter, setter = setter }

        return getter
    end

    local function onFriendStatusChanged(player: Player, friendStatus: Enum.FriendStatus)
        if tbl1[player.UserId] then
            tbl1[player.UserId].setter(friendStatus)
        end
    end

    local function getShouldShowFriendButton(num1: number?, arg1)
        return Signals.createComputed(function(arg2): boolean
            return if PeopleUtility.showPersonButtons(arg1, num1) and num1 then not PeopleBlockStatusStore.getPlayerBlockStatus(num1)(arg2) else false
        end)
    end

    local function getFriendButtonText(userId: number?, tbl2)
        if not userId then
            return Signals.createSignal(tbl2.addPerson)
        end

        return Signals.createComputed(function(arg1)
            local var1 = getFriendStatusSignal(userId)(arg1)

            if var1 == Enum.FriendStatus.Friend then
                return tbl2.isFriend
            end

            if var1 == Enum.FriendStatus.FriendRequestSent then
                return tbl2.requestSent
            end

            return tbl2.addPerson
        end)
    end

    local function getFriendButtonVariant(userId: number?)
        if not userId then
            return Signals.createSignal(ButtonVariant.Subtle)
        end

        return Signals.createComputed(function(arg1)
            local var1 = getFriendStatusSignal(userId)(arg1)

            return if var1 == Enum.FriendStatus.Friend or var1 == Enum.FriendStatus.FriendRequestSent then ButtonVariant.Text else ButtonVariant.Subtle
        end)
    end

    local function getFriendStatus(userId: number?)
        if not userId then
            return Signals.createSignal(false)
        end

        return Signals.createComputed(function(arg1): boolean
            return getFriendStatusSignal(userId)(arg1) == Enum.FriendStatus.Friend
        end)
    end

    local function getIsFriendButtonDisabled(userId: number?)
        if not userId then
            return Signals.createSignal(false)
        end

        return Signals.createComputed(function(arg1): boolean
            local var1 = getFriendStatusSignal(userId)(arg1)
            return var1 == Enum.FriendStatus.Friend or var1 == Enum.FriendStatus.FriendRequestSent
        end)
    end

    local function getIsFriendButtonGrayedOut(userId: number?)
        if not userId then
            return Signals.createSignal(false)
        end

        return Signals.createComputed(function(arg1): boolean
            return getFriendStatusSignal(userId)(arg1) == Enum.FriendStatus.FriendRequestSent
        end)
    end

    local function cleanup()
        if connection then
            connection:Disconnect()
            connection = nil
        end

        tbl1 = {}
    end

    local function initializeFriendStatusListener()
        if localPlayer then
            connection = localPlayer.FriendStatusChanged:Connect(onFriendStatusChanged)
        end
    end

    initializeFriendStatusListener()

    return {
        getShouldShowFriendButton = getShouldShowFriendButton,
        getFriendButtonText = getFriendButtonText,
        getFriendButtonVariant = getFriendButtonVariant,
        getFriendStatus = getFriendStatus,
        getIsFriendButtonDisabled = getIsFriendButtonDisabled,
        getIsFriendButtonGrayedOut = getIsFriendButtonGrayedOut,
        sendFriendRequest = function(player: Player)
            if not (player and localPlayer) then
                return
            end

            localPlayer:RequestFriendship(player)
        end,
        cleanup = cleanup
    }
end

return (createFriendStatusStore())

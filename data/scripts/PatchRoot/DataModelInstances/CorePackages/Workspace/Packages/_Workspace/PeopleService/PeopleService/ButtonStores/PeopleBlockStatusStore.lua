-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T01:50:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PeopleService = script:FindFirstAncestor("PeopleService")
local PeopleServiceParent = PeopleService.Parent

local Players = game:GetService("Players")

local Signals = require(PeopleServiceParent.Signals)
local BlockingUtility = require(PeopleServiceParent.BlockingUtility)

local Constants = require(PeopleService.Constants)

local PeopleBlockingModalManager = require(PeopleService.Integration.PeopleBlockingModalManager)
local PeopleAnalyticsManager = require(PeopleService.Analytics.PeopleAnalyticsManager)

local GetFFlagAddPeoplePageCardLayout = require(PeopleService.Flags).GetFFlagAddPeoplePageCardLayout

local function createPeopleBlockStatusStore()
    local tbl1 = ({})

    local connection = nil

    local function getPlayerBlockStatus(num1: number)
        if not num1 then
            return Signals.createSignal(false)
        end

        if tbl1[num1] then
            return tbl1[num1].getter
        end

        local isPlayerBlockedByUserId = BlockingUtility:IsPlayerBlockedByUserId(num1)

        local getter, setter = Signals.createSignal(isPlayerBlockedByUserId)

        tbl1[num1] = { getter = getter, setter = setter }

        return getter
    end

    local function onBlockStatusChanged(num1: number, bool1: boolean)
        if tbl1[num1] then
            tbl1[num1].setter(bool1)
        end
    end

    local function blockPlayer(arg1, str1: string?)
        local tbl2 = {
            onBlockingSuccess = function()
                if tbl1[arg1.UserId] then
                    tbl1[arg1.UserId].setter(true)
                end
            end
        }

        local openModal = PeopleBlockingModalManager.openModal

        if not GetFFlagAddPeoplePageCardLayout() then
            str1 = Constants.ANALYTICS.IN_GAME_MENU_NAME
        end

        local var1 = openModal(arg1, str1, tbl2)

        if var1 then
            var1:catch(function(arg2)
                warn("Block modal promise error:", arg2)
            end)
        end
    end

    local function unblockPlayer(arg1, str1: string?)
        if not arg1 then
            return
        end

        if not BlockingUtility:UnblockPlayerAsync(arg1) then
            return
        end

        local localPlayer = Players.LocalPlayer
        if localPlayer then
            local var1 = PeopleAnalyticsManager
            local userId = arg1.UserId
            local userId2 = localPlayer.UserId
            if not GetFFlagAddPeoplePageCardLayout() then
                str1 = nil
            end

            var1:trackUnblockUser(userId, userId2, str1)
        end

        if tbl1[arg1.UserId] then
            tbl1[arg1.UserId].setter(false)
        end
    end

    local function cleanup()
        if connection then
            connection:Disconnect()
            connection = nil
        end

        tbl1 = {}
    end

    local function initializeBlockStatusListener()
        connection = BlockingUtility:GetBlockedStatusChangedEvent():Connect(onBlockStatusChanged)
    end

    initializeBlockStatusListener()

    return {
        getPlayerBlockStatus = getPlayerBlockStatus,
        unblockPlayer = unblockPlayer,
        blockPlayer = blockPlayer,
        cleanup = cleanup
    }
end

return (createPeopleBlockStatusStore())

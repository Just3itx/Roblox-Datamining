-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T14:41:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")
local SocialService = game:GetService("SocialService")
local ContextActionService = game:GetService("ContextActionService")

local GameInvite = script:FindFirstAncestor("GameInvite")
local GameInviteParent = GameInvite.Parent
local utils = GameInvite.utils

local _gameInviteModalType = require(GameInvite.gameInviteModalType)
local Cryo = require(GameInviteParent.Cryo)

local GameInviteAnalyticsManager = require(GameInvite.analytics.GameInviteAnalyticsManager)
local getCustomizedInvitePromptParams = require(utils.getCustomizedInvitePromptParams)
local getCanSendAndCanCustomizeInvites = require(utils.getCanSendAndCanCustomizeInvites)
local isTriggerDDI = require(utils.gameInviteModalHelper).isTriggerDDI
local isTriggerGameMenu = require(utils.gameInviteModalHelper).isTriggerGameMenu
local IXPServiceWrapper = require(GameInviteParent.IxpServiceWrapper).IXPServiceWrapper
local FFlagGameInviteInExpUserListExposure = require(GameInvite.Flags.FFlagGameInviteInExpUserListExposure)
local FStringGameInviteInExpIxpLayer = require(GameInvite.Flags.FStringGameInviteInExpIxpLayer)

game:DefineFastFlag("GameInviteModalAnalyticsEmptyEventContextFix", false)

local FFlagGameInviteOpenModalWithoutBlockingOnCanPrompt = require(GameInviteParent.SharedFlags).FFlagGameInviteOpenModalWithoutBlockingOnCanPrompt

local tbl1 = ({})
tbl1.__index = tbl1

function tbl1.new()
    return (setmetatable({}, tbl1))
end

tbl1.ToggleGameInviteModalEvent = Instance.new("BindableEvent")
tbl1.isModalOpen = false
tbl1.openTrigger = nil
tbl1.customParams = nil
tbl1.placeId = nil
tbl1.openSession = 0

local function openDeveloperInviteModalNonBlocking(arg1, arg2, arg3)
    local openSession = arg1.openSession
    arg1.customParams = nil
    arg1.ToggleGameInviteModalEvent:Fire(true, false, arg2)

    ContextActionService:BindCoreAction("hideGameInviteModal", function(_, userInputState)
        if userInputState == Enum.UserInputState.Begin then
            arg1:closeModal()
        end
    end, false, Enum.KeyCode.ButtonB, Enum.KeyCode.Backspace)

    task.spawn(function()
        local customParams = getCustomizedInvitePromptParams(arg3, arg2.trigger, getCanSendAndCanCustomizeInvites)

        if not arg1.isModalOpen or arg1.openSession ~= openSession then
            return
        end

        arg1.customParams = customParams

        if not customParams then
            arg1:closeModal()
            return
        end

        local isLaunchDataProvided = not (customParams.launchData == nil) and customParams.launchData ~= ""
        local isPromptCustomized = not (customParams.promptMessage == nil) and customParams.promptMessage ~= ""
        local isInviteMessageIdProvided = not (customParams.inviteMessageId == nil) and customParams.inviteMessageId ~= ""

        if isLaunchDataProvided or isPromptCustomized or isInviteMessageIdProvided then
            arg1.ToggleGameInviteModalEvent:Fire(true, false, Cryo.Dictionary.join(arg2, customParams))
        end

        GameInviteAnalyticsManager:sendGameInviteModalEvent(arg2.trigger, {
            action_type = GameInviteAnalyticsManager.ActionType.ModalOpen,
            is_launch_data_provided = isLaunchDataProvided,
            is_prompt_customized = isPromptCustomized,
            is_invite_message_id_provided = isInviteMessageIdProvided,
            place_id = arg2.rootPlaceId
        })
    end)
end

function tbl1.openModal(arg1, arg2, arg3)
    if arg1.isModalOpen then
        if isTriggerDDI(arg2.trigger) then
            arg1:invokeGameInvitePromptClosed()
        end
        return
    end

    arg1.isModalOpen = true
    if FFlagGameInviteOpenModalWithoutBlockingOnCanPrompt then
        arg1.openSession += 1
    end
    arg1.openTrigger = arg2.trigger

    local rootPlaceId = arg2.rootPlaceId or tostring(game.PlaceId)
    arg1.placeId = rootPlaceId

    if isTriggerDDI(arg2.trigger) and FFlagGameInviteOpenModalWithoutBlockingOnCanPrompt then
        openDeveloperInviteModalNonBlocking(arg1, arg2, arg3)
        return
    end

    local bool1 = false
    local bool2 = false
    local bool3 = false

    if isTriggerDDI(arg2.trigger) then
        arg1.ToggleGameInviteModalEvent:Fire(true, true, arg2)

        local customParams = getCustomizedInvitePromptParams(arg3, arg2.trigger, getCanSendAndCanCustomizeInvites)
        arg1.customParams = customParams
        if customParams then
            if customParams.launchData == nil then
                bool1 = false
            else
                bool1 = customParams.launchData ~= ""
            end

            if customParams.promptMessage == nil then
                bool2 = false
            else
                bool2 = customParams.promptMessage ~= ""
            end

            if customParams.inviteMessageId == nil then
                bool3 = false
            else
                bool3 = customParams.inviteMessageId ~= ""
            end
            arg1.ToggleGameInviteModalEvent:Fire(true, false, Cryo.Dictionary.join(arg2, customParams))
            if game:GetFastFlag("GameInviteModalAnalyticsEmptyEventContextFix") then
                GameInviteAnalyticsManager:sendGameInviteModalEvent(arg2.trigger, {
                    action_type = GameInviteAnalyticsManager.ActionType.ModalOpen,
                    is_launch_data_provided = bool1,
                    is_prompt_customized = bool2,
                    is_invite_message_id_provided = bool3,
                    place_id = arg2.rootPlaceId,
                    hideCloseButton = arg2.hideCloseButton
                })
            end
        else
            arg1:closeModal()
        end
    else
        arg1.ToggleGameInviteModalEvent:Fire(true, false, arg2)

        if FFlagGameInviteInExpUserListExposure and isTriggerGameMenu(arg2.trigger) then
            IXPServiceWrapper:LogFlagLinkedUserLayerExposure(FStringGameInviteInExpIxpLayer)
        end
        if game:GetFastFlag("GameInviteModalAnalyticsEmptyEventContextFix") then
            GameInviteAnalyticsManager:sendGameInviteModalEvent(arg2.trigger, {
                action_type = GameInviteAnalyticsManager.ActionType.ModalOpen,
                is_launch_data_provided = bool1,
                is_prompt_customized = bool2,
                is_invite_message_id_provided = bool3,
                place_id = arg2.rootPlaceId
            })
        end
    end

    if not game:GetFastFlag("GameInviteModalAnalyticsEmptyEventContextFix") then
        GameInviteAnalyticsManager:sendGameInviteModalEvent(arg2.trigger, {
            action_type = GameInviteAnalyticsManager.ActionType.ModalOpen,
            is_launch_data_provided = bool1,
            is_prompt_customized = bool2,
            is_invite_message_id_provided = bool3,
            place_id = arg2.rootPlaceId
        })
    end

    ContextActionService:BindCoreAction("hideGameInviteModal", function(_, userInputState)
        if userInputState == Enum.UserInputState.Begin then
            arg1:closeModal()
        end
    end, false, Enum.KeyCode.ButtonB, Enum.KeyCode.Backspace)
end

function tbl1.closeModal(tbl2, maxRecipientRowNumber: number?)
    if tbl2.isModalOpen then
        local bool1 = false
        local bool2 = false
        local bool3 = false

        if isTriggerDDI(tbl2.openTrigger) then
            if tbl2.customParams then
                if tbl2.customParams.launchData == nil then
                    bool1 = false
                else
                    bool1 = tbl2.customParams.launchData ~= ""
                end

                if tbl2.customParams.promptMessage == nil then
                    bool2 = false
                else
                    bool2 = tbl2.customParams.promptMessage ~= ""
                end

                if tbl2.customParams.inviteMessageId == nil then
                    bool3 = false
                else
                    bool3 = tbl2.customParams.inviteMessageId ~= ""
                end
            end
            tbl2:invokeGameInvitePromptClosed()
        end

        GameInviteAnalyticsManager:sendGameInviteModalEvent(tbl2.openTrigger, {
            action_type = GameInviteAnalyticsManager.ActionType.ModalClose,
            is_launch_data_provided = bool1,
            is_prompt_customized = bool2,
            is_invite_message_id_provided = bool3,
            max_recipient_row_number = maxRecipientRowNumber,
            place_id = tbl2.placeId
        })

        ContextActionService:UnbindCoreAction("hideGameInviteModal")
        tbl2.isModalOpen = false
        if FFlagGameInviteOpenModalWithoutBlockingOnCanPrompt then
            tbl2.openSession += 1
        end
        tbl2.openTrigger = nil
        tbl2.placeId = nil
    end
    tbl2.ToggleGameInviteModalEvent:Fire(false)
end

function tbl1.isGameModalOpen(arg1)
    return arg1.isModalOpen
end

function tbl1.invokeGameInvitePromptClosed(_)
    if SocialService and Players.LocalPlayer then
        SocialService:InvokeGameInvitePromptClosed(Players.LocalPlayer, {})
    end
end

return tbl1.new()

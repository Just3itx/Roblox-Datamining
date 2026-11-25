-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T00:40:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local NotificationModalsManager = require(scriptParentParent.NotificationModalsManager)
local NotificationsUpsellModal = require(script.Parent.Components.NotificationsUpsellModal)
local GetGameNameAndDescription = require(scriptParentParent.GameDetailRodux).GetGameNameAndDescription

local FFlagLuaAppDefaultHttpRetry = require(scriptParentParent.SharedFlags).FFlagLuaAppDefaultHttpRetry
local sendEventDeferred = require(scriptParentParent.NotificationsCommon).sendEventDeferred
local ModalEventConstants = require(script.Parent.Analytics.ModalEventConstants)

local HttpRequest = require(scriptParentParent.HttpRequest)
local var1 = HttpRequest.config({
    requestFunction = HttpRequest.requestFunctions.HttpRbxApi,
    maxRetryCount = if FFlagLuaAppDefaultHttpRetry then game:DefineFastInt("SetupNotificationsUpsellHttpRetryCount", 4) else nil
})

local bool1 = game:DefineFastFlag("NotificationsUpsellDisableBackgroundDismiss", false)

local function openModal(experienceId: string)
    local function closeCallback()
        game:GetService("ExperienceNotificationService"):InvokeOptInPromptClosed()
        sendEventDeferred(
            ModalEventConstants.ModalContext,
            ModalEventConstants.OptInEventName,
            {
                [ModalEventConstants.ActionType] = ModalEventConstants.Closed,
                [ModalEventConstants.UniverseId] = experienceId
            }
        )
    end

    local function closeModal()
        NotificationModalsManager.CloseModal("UENUpsell")
    end

    local var2, var3

    if experienceId == "0" or experienceId == "" then
        var2 = false
        var3 = nil
    else
        var2, var3 = GetGameNameAndDescription(var1, experienceId):andThen(function(arg1)
            return arg1 and arg1.Name
        end, function()
            return nil
        end):await()
    end

    sendEventDeferred(
        ModalEventConstants.ModalContext,
        ModalEventConstants.OptInEventName,
        {
            [ModalEventConstants.ActionType] = ModalEventConstants.Opened,
            [ModalEventConstants.UniverseId] = experienceId
        }
    )
    local openModal2 = NotificationModalsManager.OpenModal
    local str2 = "UENUpsell"
    local var4 = NotificationsUpsellModal
    local tbl1 = { CloseCallback = closeCallback, Props = 0, DisableBackgroundDismiss = 0 }
    local props = { CloseModal = closeModal, ExperienceId = experienceId, ExperienceName = 0 }
    if not var2 then
        var3 = nil
    end

    props.ExperienceName = var3
    tbl1.Props = props

    tbl1.DisableBackgroundDismiss = if bool1 then true else nil
    openModal2(str2, var4, tbl1)
end

return function()
    game:GetService("ExperienceNotificationService").PromptOptInRequested:Connect(function()
        openModal(tostring(game.GameId))
    end)
end

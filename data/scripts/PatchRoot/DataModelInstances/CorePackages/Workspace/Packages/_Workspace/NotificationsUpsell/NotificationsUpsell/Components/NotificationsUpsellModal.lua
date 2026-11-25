-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T00:31:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GuiService = game:GetService("GuiService")
local UserInputService = game:GetService("UserInputService")
local scriptParentParentParent = script.Parent.Parent.Parent
local Players = game:GetService("Players")

local FFlagLuaAppDefaultHttpRetry = require(scriptParentParentParent.SharedFlags).FFlagLuaAppDefaultHttpRetry
local React = require(scriptParentParentParent.React)
local ReactRoblox = require(scriptParentParentParent.ReactRoblox)
local UIBlox = require(scriptParentParentParent.UIBlox)
local Images = UIBlox.App.ImageSet.Images

local NotificationModalsManager = require(scriptParentParentParent.NotificationModalsManager)

local useState = React.useState
local useCallback = React.useCallback
local useEffect = React.useEffect
local useRef = React.useRef
local useLocalization = require(scriptParentParentParent.Localization).Hooks.useLocalization

local bool1 = game:DefineFastFlag("EnableConsoleAutoFocusForUEN1", false)

local InteractiveAlert = UIBlox.App.Dialog.Alert.InteractiveAlert
local ButtonType = UIBlox.App.Button.Enum.ButtonType

local HttpRequest = require(scriptParentParentParent.HttpRequest)
local var1 = HttpRequest.config({
    requestFunction = HttpRequest.requestFunctions.HttpRbxApi,
    maxRetryCount = if FFlagLuaAppDefaultHttpRetry then game:DefineFastInt("NotificationsUpsellModalHttpRetryCount", 4) else nil
})

local FollowingsPostFollow = require(script.Parent.Parent.Requests.FollowingsPostFollow)

local sendEventDeferred = require(scriptParentParentParent.NotificationsCommon).sendEventDeferred
local ModalEventConstants = require(script.Parent.Parent.Analytics.ModalEventConstants)

local RichTextEscape = require(script.Parent.Parent.Util.RichTextEscape)

return function(arg1)
    local var2 = useLocalization({
        Cancel = "CommonUI.Controls.Action.Cancel",
        Yes = "CommonUI.Controls.Action.Yes",
        Heading = "Feature.Notifications.Heading.TurnOnNotifications",
        ReceiveUpdates = "Feature.Notifications.Label.ReceiveActivityUpdates",
        ReceiveUpdatesForExperience = "Feature.Notifications.Label.GetUpdatesFromExperience",
        NotificationsEnabledForExperience = "Feature.Notifications.Response.NotificationsEnabledForExperience",
        NotificationsEnabled = "Feature.Notifications.Response.NotificationsEnabled",
        SomethingWentWrong = "Feature.Call.Error.Description.Generic"
    })

    local onActivated = useCallback(function()
        sendEventDeferred(ModalEventConstants.ModalContext, ModalEventConstants.OptInEventName, {
            [ModalEventConstants.ActionType] = ModalEventConstants.Clicked,
            [ModalEventConstants.Button] = ModalEventConstants.Cancel,
            [ModalEventConstants.UniverseId] = arg1.ExperienceId
        })
        arg1.CloseModal()
    end, { arg1.CloseModal, arg1.ExperienceId })
    local var3 = useCallback(function()
        sendEventDeferred(ModalEventConstants.ModalContext, ModalEventConstants.OptInEventName, {
            [ModalEventConstants.ActionType] = ModalEventConstants.Clicked,
            [ModalEventConstants.Button] = ModalEventConstants.Confirm,
            [ModalEventConstants.UniverseId] = arg1.ExperienceId
        })
        local localPlayer = Players and Players.LocalPlayer
        if arg1.ExperienceId ~= "0" and localPlayer then
            sendEventDeferred(ModalEventConstants.ModalContext, ModalEventConstants.OptInEventName, {
                [ModalEventConstants.ActionType] = ModalEventConstants.BackendRequested,
                [ModalEventConstants.UniverseId] = arg1.ExperienceId
            })
            local var4 = FollowingsPostFollow
            local var5 = var1
            local str1 = tostring(localPlayer.UserId)
            local experienceId = arg1.ExperienceId

            var4(var5, str1, tostring(experienceId)):andThen(function()
                sendEventDeferred(ModalEventConstants.ModalContext, ModalEventConstants.OptInEventName, {
                    [ModalEventConstants.ActionType] = ModalEventConstants.BackendSuccess,
                    [ModalEventConstants.UniverseId] = arg1.ExperienceId
                })
                NotificationModalsManager.SetUIBloxToast({
                    iconImage = Images["icons/common/notificationOn"],
                    toastTitle = if arg1.ExperienceName then var2.NotificationsEnabledForExperience:gsub("{experienceName}", arg1.ExperienceName) else var2.NotificationsEnabled
                })
            end, function()
                sendEventDeferred(ModalEventConstants.ModalContext, ModalEventConstants.OptInEventName, {
                    [ModalEventConstants.ActionType] = ModalEventConstants.BackendFailed,
                    [ModalEventConstants.UniverseId] = arg1.ExperienceId
                })
                NotificationModalsManager.SetUIBloxToast(
                    {
                        iconImage = Images["icons/status/alert"],
                        toastTitle = var2.SomethingWentWrong
                    }
                )
            end)
        end
        arg1.CloseModal()
    end, { arg1.CloseModal, arg1.ExperienceId, var2 })

    local screenSize, var6 = useState(Vector2.new(800, 600))
    local var7 = useCallback(function(arg2)
        var6(arg2.AbsoluteSize)
    end, { var6 })

    local ref = useRef(nil)
    if bool1 then
        useEffect(function()
            if not UserInputService.GamepadEnabled then
                return
            end

            task.delay(0.3, function()
                local buttons = ref.current and ref.current:FindFirstChild("Buttons", true)
                local __2 = buttons and buttons:FindFirstChild("2")
                if __2 then
                    GuiService.SelectedCoreObject = __2
                end
            end)

            return function()
                GuiService.SelectedCoreObject = nil
            end
        end, {})
    else
        useEffect(function()
            if not UserInputService.GamepadEnabled then
                return
            end

            task.delay(0.3, function()
                local buttons = ref.current and ref.current:FindFirstChild("Buttons", true)
                local __2 = buttons and buttons:FindFirstChild("2")
                if __2 then
                    GuiService.SelectedCoreObject = __2
                end
            end)
        end, {})
    end

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl1 = {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        ref = ref,
        [ReactRoblox.Change.AbsoluteSize] = var7
    }
    local tbl2 = {
        ConfirmationPrompt = React.createElement(InteractiveAlert, {
            screenSize = screenSize,
            title = var2.Heading,
            bodyText = if arg1.ExperienceName then string.gsub(
                var2.ReceiveUpdatesForExperience,
                "{experienceName}",
                "\n<b>" .. RichTextEscape(arg1.ExperienceName) .. "</b>"
            ) else var2.ReceiveUpdates,
            richText = true,
            buttonStackInfo = {
                buttons = {
                    {
                        props = {
                            onActivated = onActivated,
                            text = var2.Cancel
                        },
                        isDefaultChild = true
                    },
                    {
                        buttonType = ButtonType.PrimarySystem,
                        props = {
                            onActivated = var3,
                            text = var2.Yes
                        },
                        isDefaultChild = false
                    }
                }
            }
        })
    }
    return createElement(str1, tbl1, tbl2)
end

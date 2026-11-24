-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:51:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ContextActionService = game:GetService("ContextActionService")
local GuiService = game:GetService("GuiService")
local VRService = game:GetService("VRService")

local CoreGuiCommonParent = script:FindFirstAncestor("CoreGuiCommon").Parent

local Foundation = require(CoreGuiCommonParent.Foundation)
local Localization = require(CoreGuiCommonParent.Localization)
local React = require(CoreGuiCommonParent.React)

local Dialog = Foundation.Dialog
local useLocalization = Localization.Hooks.useLocalization

function HeadsetDisconnectDialog(tbl1)
    local var1 = tbl1.mockGuiService or GuiService
    local var2 = tbl1.mockVRService or VRService

    local var3 = useLocalization({
        titleText = "InGame.ConnectionError.Heading.VRDisconnected",
        bodyText = "InGame.ConnectionError.Message.RestartApp",
        buttonText = "InGame.ConnectionError.Action.Restart"
    })

    local var4, var5 = React.useState(false)

    React.useEffect(function()
        local connection = var2:GetPropertyChangedSignal("VRDeviceAvailable"):Connect(function(arg1)
            var5(not arg1)
        end)

        return function()
            connection:Disconnect()
        end
    end, {})

    local onActivated = React.useCallback(function()
        local notificationTypeList = var1:GetNotificationTypeList()

        if game:GetEngineFeature("EnableLuaControlsRestartApp") then
            var1:BroadcastNotification("", notificationTypeList.RESTART_APP)
            return
        end
        var1:BroadcastNotification("", notificationTypeList.NATIVE_EXIT)
    end, {})

    React.useEffect(function()
        if var4 then
            var1:SetMenuIsOpen(true, "HeadsetDisconnectedDialog")

            ContextActionService:BindCoreAction("TopBarGamepadDisableMenuShortcut", function(): Enum.ContextActionResult
                return Enum.ContextActionResult.Sink
            end, false, Enum.KeyCode.ButtonStart, Enum.KeyCode.Escape)

            ContextActionService:BindCoreAction("TopBarDialogConfirm", function(_, userInputState, _)
                if userInputState ~= Enum.UserInputState.Begin then
                    return Enum.ContextActionResult.Pass
                end

                onActivated()
                return Enum.ContextActionResult.Sink
            end, false, Enum.KeyCode.Return, Enum.KeyCode.ButtonA)
        else
            var1:SetMenuIsOpen(false, "HeadsetDisconnectedDialog")
            ContextActionService:UnbindCoreAction("TopBarGamepadDisableMenuShortcut")
            ContextActionService:UnbindCoreAction("TopBarDialogConfirm")
        end

        return function()
            var1:SetMenuIsOpen(false, "HeadsetDisconnectedDialog")
            ContextActionService:UnbindCoreAction("TopBarGamepadDisableMenuShortcut")
            ContextActionService:UnbindCoreAction("TopBarDialogConfirm")
        end
    end, { var4 })

    if not var4 then
        return nil
    end

    return (React.createElement(Dialog.Root, {
        size = Foundation.Enums.DialogSize.Small,
        hasBackdrop = tbl1.hasBackdrop == nil or tbl1.hasBackdrop,
        disablePortal = tbl1.disablePortal,
        testId = "headset-disconnect-dialog"
    }, {
        DialogTitle = React.createElement(Dialog.Title, { text = var3.titleText }),
        DialogContent = React.createElement(Dialog.Content, nil, { DialogText = React.createElement(Dialog.Text, { Text = var3.bodyText }) }),
        DialogActions = React.createElement(Dialog.Actions, {
            actions = {{
                text = var3.buttonText,
                variant = Foundation.Enums.ButtonVariant.Emphasis,
                onActivated = onActivated,
                testId = "restart-button"
            }}
        })
    }))
end

return React.memo(HeadsetDisconnectDialog)

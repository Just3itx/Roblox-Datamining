-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T23:40:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local Foundation = require(scriptParentParentParentParent.Foundation)
local Localization = require(scriptParentParentParentParent.Localization)
local React = require(scriptParentParentParentParent.React)
local RoactUtils = require(scriptParentParentParentParent.RoactUtils)

local Button = Foundation.Button
local ButtonVariant = Foundation.Enums.ButtonVariant
local Dialog = Foundation.Dialog
local DialogSize = Foundation.Enums.DialogSize
local InputSize = Foundation.Enums.InputSize
local FoundationText = Foundation.Text
local View = Foundation.View

local useAnalytics = require(scriptParentParentParent.Analytics.useAnalytics)
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local useLocalization = Localization.Hooks.useLocalization
local usePinInputStateWhileOpen = require(scriptParentParentParent.Hooks.usePinInputStateWhileOpen)

local EventNames = require(scriptParentParentParent.Analytics.EventNames)
local PermissionPromptFinished = require(scriptParentParentParent.Thunks.PermissionPromptFinished)

local FFlagCapturePermissionsPromptFreeMouse = require(scriptParentParentParent.Flags.FFlagCapturePermissionsPromptFreeMouse)

return function(tbl1)
    local var1 = useAnalytics()
    local var2 = useDispatch()
    local var3 = useLocalization({
        allow = "Feature.Captures.Action.Allow",
        allowAccessToCapturesBody = "Feature.Captures.Body.AllowAccessToCaptures",
        allowAccessToCapturesTitle = "Feature.Captures.Title.AllowAccessToCaptures",
        dontAllow = "Feature.Captures.Action.DontAllow"
    })

    usePinInputStateWhileOpen(FFlagCapturePermissionsPromptFreeMouse)

    React.useEffect(function()
        var1.fireEvent(EventNames.CapturePermissionsPromptViewed)
    end, {})

    local onActivated = React.useCallback(function()
        var1.fireEvent(EventNames.CapturePermissionsPromptAccepted)

        var2(PermissionPromptFinished(tbl1.promptId, true))
    end, { tbl1.promptId })

    local var4 = React.useCallback(function()
        var1.fireEvent(EventNames.CapturePermissionsPromptRejected)

        var2(PermissionPromptFinished(tbl1.promptId, false))
    end, { tbl1.promptId })

    return React.createElement(Dialog.Root, {
        size = DialogSize.Small
    }, {
        ModalFix = if FFlagCapturePermissionsPromptFreeMouse then React.createElement("ImageButton", { BackgroundTransparency = 1, Modal = true, Size = UDim2.new(0, 0, 0, 0) }) else nil,
        DialogTitle = React.createElement(
            View,
            {
                LayoutOrder = 1,
                tag = "col align-x-center align-y-center auto-y gap-small size-full-0 margin-top-small"
            },
            {
                DialogTitleText = React.createElement(
                    FoundationText,
                    {
                        Text = var3.allowAccessToCapturesTitle,
                        tag = "auto-xy text-heading-small text-wrap"
                    }
                )
            }
        ),
        DialogContent = React.createElement(
            View,
            {
                LayoutOrder = 2,
                tag = "col align-x-center align-y-center auto-y gap-small size-full-0 margin-none"
            },
            {
                DialogContentText = React.createElement(FoundationText, {
                    LayoutOrder = 1,
                    Text = var3.allowAccessToCapturesBody,
                    tag = "auto-xy text-body-small text-wrap padding-bottom-xsmall"
                }),
                Buttons = React.createElement(
                    View,
                    {
                        LayoutOrder = 2,
                        tag = "row align-x-center align-y-center auto-xy gap-medium"
                    },
                    {
                        AcceptButton = React.createElement(Button, {
                            text = var3.allow,
                            variant = ButtonVariant.Emphasis,
                            onActivated = onActivated,
                            size = InputSize.Small,
                            width = UDim.new(0.45, 0)
                        }),
                        RejectButton = React.createElement(Button, {
                            text = var3.dontAllow,
                            variant = ButtonVariant.Standard,
                            onActivated = var4,
                            size = InputSize.Small,
                            width = UDim.new(0.45, 0)
                        })
                    }
                )
            }
        )
    })
end

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:20:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthSignupParent = script:FindFirstAncestor("AuthSignup").Parent

local React = require(AuthSignupParent.React)
local Foundation = require(AuthSignupParent.Foundation)
local ReactFocusNavigation = require(AuthSignupParent.ReactFocusNavigation)
local AuthAnalytics = require(AuthSignupParent.AuthAnalytics)

local authModalShown = AuthAnalytics.Events.authModalShown
local authButtonClick = AuthAnalytics.Events.authButtonClick
local EventStreamConstants = AuthAnalytics.EventStreamConstants
local InputSize = Foundation.Enums.InputSize
local Dialog = Foundation.Dialog
local DialogSize = Foundation.Enums.DialogSize
local ButtonVariant = Foundation.Enums.ButtonVariant
local useLocalization = require(AuthSignupParent.Localization).Hooks.useLocalization
local useFocusGuiObject = ReactFocusNavigation.useFocusGuiObject

local FocusNavigationEventNameEnum = require(AuthSignupParent.FocusNavigationUtils).FocusNavigationEventNameEnum
local InputHandlers = require(AuthSignupParent.InputHandlers)

local tbl1 = {
    [Enum.KeyCode.ButtonA] = FocusNavigationEventNameEnum.Confirm,
    [Enum.KeyCode.Return] = FocusNavigationEventNameEnum.Confirm
}

local function useFocusNavigationBindings(arg1)
    local var1 = ReactFocusNavigation.useEventMap(tbl1, arg1)
    local var2 = React.useMemo(function()
        return {
            [FocusNavigationEventNameEnum.Confirm] = {
                handler = InputHandlers.onRelease(function() end)
            }
        }
    end, {})
    return ReactFocusNavigation.useEventHandlerMap(var2, var1)
end

local function SignUpExitModal(tbl2)
    local var1 = useLocalization({
        cancel = "Authentication.SignUp.Action.Cancel",
        confirm = "Authentication.SignUp.Action.ExitModalLeave",
        title = "Authentication.SignUp.Label.ExitModalTitle",
        subtitle = "Authentication.SignUp.Label.ExitModalSubtitle"
    })

    local var2 = useFocusGuiObject()
    local ref = React.useRef(nil)
    local var3 = useFocusNavigationBindings(nil)

    React.useEffect(function()
        var2(ref.current)
        authModalShown(EventStreamConstants.Context.SignUpExitModal, EventStreamConstants.State.Success)
    end, {})

    local onActivated = React.useCallback(function()
        authButtonClick(EventStreamConstants.Context.SignUpExitModal, EventStreamConstants.Button.SignUpExitModalLeave)

        tbl2.onConfirm()
    end, { tbl2.onConfirm })

    local var4 = React.useCallback(function()
        authButtonClick(EventStreamConstants.Context.SignUpExitModal, EventStreamConstants.Button.SignUpExitModalCancel)

        tbl2.onClose()
    end, { tbl2.onClose })

    return React.createElement(Dialog.Root, {
        size = DialogSize.Small,
        hasBackdrop = true,
        ref = var3
    }, {
        DialogTitle = React.createElement(Dialog.Title, { text = var1.title }),
        DialogContent = React.createElement(Dialog.Content, {}, {
            DialogView = React.createElement(Foundation.View, {
                tag = "col fill auto-xy items-start gap-medium"
            }, {
                DialogText = React.createElement(Dialog.Text, { Text = var1.subtitle, LayoutOrder = 1 }),
                PrimaryButton = React.createElement(Foundation.Button, {
                    text = var1.confirm,
                    variant = ButtonVariant.Alert,
                    size = InputSize.Small,
                    width = UDim.new(1, 0),
                    TextTruncate = Enum.TextTruncate.None,
                    onActivated = onActivated,
                    LayoutOrder = 2
                }),
                SecondaryButton = React.createElement(Foundation.Button, {
                    text = var1.cancel,
                    variant = ButtonVariant.Standard,
                    size = InputSize.Small,
                    width = UDim.new(1, 0),
                    TextTruncate = Enum.TextTruncate.None,
                    onActivated = var4,
                    LayoutOrder = 3,
                    ref = ref
                })
            })
        })
    })
end

return SignUpExitModal

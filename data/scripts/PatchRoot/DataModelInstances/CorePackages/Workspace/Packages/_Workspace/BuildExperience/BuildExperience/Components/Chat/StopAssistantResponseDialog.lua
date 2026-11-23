-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:40:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local FocusNavigationUtils = require(BuildExperienceParent.FocusNavigationUtils)
local Foundation = require(BuildExperienceParent.Foundation)
local InputHandlers = require(BuildExperienceParent.InputHandlers)
local React = require(BuildExperienceParent.React)
local ReactFocusNavigation = require(BuildExperienceParent.ReactFocusNavigation)
local useLocalization = require(BuildExperienceParent.Localization).Hooks.useLocalization
local LocalizationStrings = require(BuildExperience.LocalizationStrings)

local Dialog = Foundation.Dialog
local ButtonVariant = Foundation.Enums.ButtonVariant
local DialogSize = Foundation.Enums.DialogSize
local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum
local FocusNavigationEventNameEnum = FocusNavigationUtils.FocusNavigationEventNameEnum
local useFocusRoot = FocusNavigationUtils.useFocusRoot
local useDefaultFocusBehavior = ReactFocusNavigation.useDefaultFocusBehavior

local eventMap = {
    [Enum.KeyCode.ButtonB] = FocusNavigationEventNameEnum.NavigateBack,
    [Enum.KeyCode.Escape] = FocusNavigationEventNameEnum.NavigateBack
}

local function StopAssistantResponseDialog(tbl2)
    local var1 = useLocalization({
        cancel = LocalizationStrings.CHAT_STOP_CONFIRMATION_CANCEL,
        description = LocalizationStrings.CHAT_STOP_CONFIRMATION_DESCRIPTION,
        stop = LocalizationStrings.CHAT_STOP_CONFIRMATION_ACTION,
        title = LocalizationStrings.CHAT_STOP_CONFIRMATION_TITLE
    })
    local onCancel = tbl2.onCancel
    local eventHandlers = React.useMemo(function()
        return {
            [FocusNavigationEventNameEnum.NavigateBack] = {
                handler = InputHandlers.onRelease(function(arg1)
                    onCancel()
                    arg1:cancel()
                end)
            }
        }
    end, { onCancel })
    local var3 = useFocusRoot({
        surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.PopUp,
        isAutoFocusRoot = true,
        shouldRestoreFocus = false,
        eventMap = eventMap,
        eventHandlers = eventHandlers
    })

    local ref, var2 = useDefaultFocusBehavior(var3)

    local var6 = React.useMemo(function()
        return {
            LayoutOrder = 3,
            actions = {
                {
                    text = var1.stop,
                    variant = ButtonVariant.Alert,
                    onActivated = tbl2.onConfirm
                },
                {
                    text = var1.cancel,
                    variant = ButtonVariant.Standard,
                    onActivated = onCancel,
                    ref = ref
                }
            }
        }
    end, {
        var1.cancel,
        var1.stop,
        onCancel,
        tbl2.onConfirm,
        ref
    })
    return React.createElement(Dialog.Root, {
        ref = var2,
        disablePortal = false,
        hasBackdrop = true,
        size = DialogSize.Small,
        testId = "stop-assistant-response-dialog"
    }, {
        Title = React.createElement(Dialog.Title, { LayoutOrder = 1, text = var1.title }),
        Content = React.createElement(
            Dialog.Content,
            { LayoutOrder = 2 },
            {
                Description = React.createElement(Dialog.Text, { Text = var1.description })
            }
        ),
        Actions = React.createElement(Dialog.Actions, var6)
    })
end

return StopAssistantResponseDialog

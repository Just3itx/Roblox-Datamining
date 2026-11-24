-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T17:41:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GroupsParent = script:FindFirstAncestor("Groups").Parent

local React = require(GroupsParent.React)
local useLocalization = require(GroupsParent.Localization).Hooks.useLocalization
local FocusNavigationUtils = require(GroupsParent.FocusNavigationUtils)
local ReactFocusNavigation = require(GroupsParent.ReactFocusNavigation)
local InputHandlers = require(GroupsParent.InputHandlers)
local Responsive = require(GroupsParent.Responsive)

local _SettingsTextInputFieldView = require(script.Parent.SettingsTextInputFieldView)

local NavigateBack = FocusNavigationUtils.FocusNavigationEventNameEnum.NavigateBack
local eventMap = {
    [Enum.KeyCode.ButtonB] = NavigateBack,
    [Enum.KeyCode.Escape] = NavigateBack
}

local function useSettingsTextInputFieldViewModel(tbl2)
    local var1, var2 = React.useState(false)
    local var3, var4 = React.useState(tbl2.value)
    local draft, var6 = React.useBinding(tbl2.value)
    local var7 = React.useCallback(function(str1: string)
        var4(str1)

        var6(str1)
    end, { var6 })
    local var8 = utf8.len(var3)
    local hasError = var8 == nil or var8 == 0 or tbl2.maxLength < var8
    local canSave = not hasError and var3 ~= tbl2.value

    local var9 = useLocalization({ save = "CommonUI.Controls.Action.Confirm", cancel = "CommonUI.Controls.Action.Cancel" })

    local onOpen = React.useCallback(function()
        var7(tbl2.value)
        var2(true)
    end, { tbl2.value, var7 })

    local onDraftChanged = React.useCallback(function(str1: string)
        local var11 = utf8.len(str1)
        if var11 and tbl2.maxLength < var11 then
            str1 = string.sub(str1, 1, utf8.offset(str1, tbl2.maxLength + 1) - 1)
        end
        var7(str1)
    end, { tbl2.maxLength, var7 })

    local onCancel = React.useCallback(function()
        var2(false)
    end, {})

    local onSave = React.useCallback(function()
        if not (var1 and canSave) then
            return
        end
        tbl2.onChange(var3)
        var2(false)
    end, {
        var1,
        canSave,
        var3,
        tbl2.onChange
    })
    local eventHandlers = React.useMemo(function()
        return {
            [NavigateBack] = {
                handler = InputHandlers.onRelease(function(arg1)
                    onCancel()
                    arg1:cancel()
                end)
            }
        }
    end, { onCancel })

    local var15 = FocusNavigationUtils.useFocusRoot({
        surfaceIdentifier = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum.CentralOverlay,
        isFocusable = var1,
        isAutoFocusRoot = true,
        shouldRestoreFocus = false,
        eventMap = eventMap,
        eventHandlers = eventHandlers
    })
    local inputRef, dialogRef = ReactFocusNavigation.useDefaultFocusBehavior(var15)
    local hideCloseButton = Responsive.usePreferredInput() == Responsive.Input.Directional

    return {
        title = tbl2.title,
        value = tbl2.value,
        description = tbl2.description,
        isEditing = var1,
        draft = draft,
        hasError = hasError,
        canSave = canSave,
        saveText = var9.save,
        cancelText = var9.cancel,
        remainingCharacters = tbl2.maxLength - (var8 or 0),
        hideCloseButton = hideCloseButton,
        dialogRef = dialogRef,
        inputRef = inputRef,
        onOpen = onOpen,
        onCancel = onCancel,
        onDraftChanged = onDraftChanged,
        onSave = onSave,
        LayoutOrder = tbl2.LayoutOrder,
        testId = tbl2.testId or "--settings-text-input-field"
    }
end

return useSettingsTextInputFieldViewModel

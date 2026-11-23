-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:11:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local React = require(AppChatParent.React)
local FocusNavigationUtils = require(AppChatParent.FocusNavigationUtils)
local InputHandlers = require(AppChatParent.InputHandlers)
local _ReactFocusNavigation = require(AppChatParent.ReactFocusNavigation)

local countChars = require(AppChat.Utils.countChars)
local isOverLength = require(AppChat.Utils.isOverLength)
local _InputDialogView = require(script.Parent.InputDialogView)

local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum
local FocusNavigationEventNameEnum = FocusNavigationUtils.FocusNavigationEventNameEnum
local useFocusRoot = FocusNavigationUtils.useFocusRoot

local eventMap = {
    [Enum.KeyCode.ButtonB] = FocusNavigationEventNameEnum.NavigateBack,
    [Enum.KeyCode.Escape] = FocusNavigationEventNameEnum.NavigateBack
}

local function useInputDialogViewModel(tbl2)
    local var1, onTextChanged = React.useState(tbl2.inputText or "")
    local maxCharacters = tbl2.maxCharacters
    local var3 = countChars(var1)
    local isOverLimit = isOverLength(var1, maxCharacters, tbl2.maxUtf16Units)
    local isLoading = tbl2.isLoading

    local onModalClose = tbl2.onModalClose
    local onActivated = tbl2.onActivated

    local onCancel = React.useCallback(function()
        if not isLoading and onModalClose then
            onModalClose()
        end
    end, { onModalClose, isLoading })

    local onConfirm = React.useCallback(function()
        if isOverLimit or isLoading then
            return
        end
        if not (onActivated and onActivated({ InputBox = var1 })) and onModalClose then
            onModalClose()
        end
    end, {
        onActivated,
        onModalClose,
        var1,
        isOverLimit,
        isLoading
    })
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

    local dialogRef = useFocusRoot({
        surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.PopUp,
        isAutoFocusRoot = true,
        eventMap = eventMap,
        eventHandlers = eventHandlers
    })

    return {
        titleText = tbl2.titleText,
        cancelText = tbl2.cancelText,
        confirmText = tbl2.confirmText,
        placeholderText = tbl2.placeholderText,
        warningText = tbl2.warningText,
        text = var1,
        counterText = `{var3}/{maxCharacters}`,
        isOverLimit = isOverLimit,
        isLoading = isLoading,
        onTextChanged = onTextChanged,
        onConfirm = onConfirm,
        onCancel = onCancel,
        dialogRef = dialogRef
    }
end

return useInputDialogViewModel

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T07:50:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChatParent = script:FindFirstAncestor("ExpChat").Parent

local Foundation = require(ExpChatParent.Foundation)

local module = {}

function module.deriveMicSendButton(arg1, tbl1)
    local idleSendIcon = tbl1.idleSendIcon
    local idleSendVariant = tbl1.idleSendVariant
    local idleSendActivated = tbl1.idleSendActivated
    local idleSendDisabled = tbl1.idleSendDisabled or false
    local bool1 = false

    if arg1.isRecording then
        idleSendActivated = arg1.onMicTap
        idleSendDisabled = false
    elseif arg1.isTranscribing then
        idleSendDisabled = true
    elseif arg1.isListening then
        idleSendIcon = Foundation.Enums.IconName.X
        idleSendVariant = Foundation.Enums.ButtonVariant.Standard
        idleSendActivated = arg1.dictation.cancel
        idleSendDisabled = false
    elseif tbl1.hasEmptyInputText and arg1.isDictationEligible then
        if tbl1.isTextBoxFocused then
            idleSendDisabled = true
        else
            idleSendIcon = Foundation.Enums.IconName.Microphone
            idleSendVariant = Foundation.Enums.ButtonVariant.Utility
            idleSendActivated = arg1.onMicTap
            idleSendDisabled = false
            bool1 = true
        end
    end

    return {
        icon = idleSendIcon,
        variant = idleSendVariant,
        isDisabled = idleSendDisabled,
        onActivated = idleSendActivated,
        useLongPressOverlay = bool1 and arg1.micGestureHandlers ~= nil
    }
end

function module.deriveBackgroundColors(arg1, tbl1)
    return if arg1.isListening then {
        color3 = tbl1.listeningColor3,
        baseTransparency = tbl1.listeningTransparency
    } else {
        color3 = tbl1.defaultColor3,
        baseTransparency = tbl1.defaultTransparency
    }
end

function module.shouldPreventFade(arg1, bool1: boolean)
    return arg1.isRecording or arg1.isTranscribing or arg1.isListening and not bool1
end

return module

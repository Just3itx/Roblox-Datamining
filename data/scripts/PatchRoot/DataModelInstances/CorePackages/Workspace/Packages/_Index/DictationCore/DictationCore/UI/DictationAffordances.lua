-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T10:01:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DictationCoreParent = script:FindFirstAncestor("DictationCore").Parent

local Foundation = require(DictationCoreParent.Foundation)

local _useLongPress = require(script.Parent.useLongPress)

local module = {}

function module.deriveMicSendButton(tbl1, tbl2)
    local idleSendIcon = tbl2.idleSendIcon
    local idleSendVariant = tbl2.idleSendVariant
    local idleSendActivated = tbl2.idleSendActivated
    local idleSendDisabled = tbl2.idleSendDisabled or false
    local bool1 = false

    if tbl1.isRecording then
        idleSendActivated = tbl1.onMicTap
        idleSendDisabled = false
    elseif tbl1.isTranscribing then
        idleSendDisabled = true
    elseif tbl1.isListening then
        idleSendIcon = Foundation.Enums.IconName.X
        idleSendVariant = Foundation.Enums.ButtonVariant.Standard
        idleSendActivated = tbl1.dictation.cancel
        idleSendDisabled = false
    elseif tbl2.hasEmptyInputText and tbl1.isDictationEligible then
        if tbl2.isTextBoxFocused then
            idleSendDisabled = true
        else
            if tbl1.isMicInUseElsewhere then
                idleSendIcon = Foundation.Enums.IconName.MicrophoneSlash
            else
                idleSendIcon = Foundation.Enums.IconName.Microphone
            end

            idleSendVariant = Foundation.Enums.ButtonVariant.Utility
            idleSendActivated = tbl1.onMicTap
            idleSendDisabled = tbl1.isMicInUseElsewhere == true
            bool1 = true
        end
    end

    return {
        icon = idleSendIcon,
        variant = idleSendVariant,
        isDisabled = idleSendDisabled,
        onActivated = idleSendActivated,
        useLongPressOverlay = bool1 and not idleSendDisabled and tbl1.micGestureHandlers ~= nil
    }
end

function module.deriveBackgroundColors(tbl1, tbl2)
    return if tbl1.isListening then {
        color3 = tbl2.listeningColor3,
        baseTransparency = tbl2.listeningTransparency
    } else {
        color3 = tbl2.defaultColor3,
        baseTransparency = tbl2.defaultTransparency
    }
end

function module.shouldPreventFade(tbl1)
    return tbl1.isRecording or tbl1.isTranscribing or tbl1.isListening
end

return module

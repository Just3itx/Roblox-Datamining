-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:41:03Z
-- Luau bytecode version: 14 | Luau type version: 3
local AppChatParent = script:FindFirstAncestor("AppChat").Parent
local _InteractionFeedback = require(AppChatParent.InteractionFeedback)

return {
    HapticFeedbackContext = { Default = "Default" },
    HapticFeedbackType = { Press = "Press", Hover = "Hover", Release = "Release" },
    HapticFeedbackConfig = {
        Default = {
            Press = {
                Haptic = Enum.HapticEffectType.UIClick
            },
            Hover = {
                Haptic = Enum.HapticEffectType.UIHover
            },
            Release = {
                Haptic = Enum.HapticEffectType.UIClick
            }
        }
    }
}

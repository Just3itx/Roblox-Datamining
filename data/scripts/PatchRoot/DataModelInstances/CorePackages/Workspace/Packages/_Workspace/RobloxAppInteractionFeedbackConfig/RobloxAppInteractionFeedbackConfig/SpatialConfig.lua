-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T09:01:24Z
-- Luau bytecode version: 14 | Luau type version: 3
local RobloxAppInteractionFeedbackConfigParent = script:FindFirstAncestor("RobloxAppInteractionFeedbackConfig").Parent
local _InteractionFeedback = require(RobloxAppInteractionFeedbackConfigParent.InteractionFeedback)
local Sounds = require(RobloxAppInteractionFeedbackConfigParent.SoundManager).Sounds

return {
    Default = {
        Press = {
            Sound = Sounds.AppSelect.Name,
            Haptic = Enum.HapticEffectType.UIClick
        },
        Hover = {
            Sound = Sounds.AppHover1.Name,
            Haptic = Enum.HapticEffectType.UIHover
        }
    },
    PlayExperienceButton = {
        Press = {
            Sound = Sounds.NotificationHigh.Name,
            Haptic = Enum.HapticEffectType.UIClick
        },
        Hover = {
            Sound = Sounds.AppHover1.Name,
            Haptic = Enum.HapticEffectType.UIHover
        }
    },
    MakePurchase = {
        Press = {
            Sound = Sounds.Purchase.Name,
            Haptic = Enum.HapticEffectType.UIClick
        },
        Hover = {
            Sound = Sounds.AppHover1.Name,
            Haptic = Enum.HapticEffectType.UIHover
        }
    }
}

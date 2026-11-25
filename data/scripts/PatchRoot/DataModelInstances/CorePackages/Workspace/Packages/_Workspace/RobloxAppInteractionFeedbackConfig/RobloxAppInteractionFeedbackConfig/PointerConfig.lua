-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T09:01:23Z
-- Luau bytecode version: 14 | Luau type version: 3
local RobloxAppInteractionFeedbackConfigParent = script:FindFirstAncestor("RobloxAppInteractionFeedbackConfig").Parent
local _InteractionFeedback = require(RobloxAppInteractionFeedbackConfigParent.InteractionFeedback)
local Sounds = require(RobloxAppInteractionFeedbackConfigParent.SoundManager).Sounds

return {
    Default = {
        Release = {
            Sound = Sounds.AppSelect.Name
        }
    },
    PlayExperienceButton = {
        Release = {
            Sound = Sounds.NotificationHigh.Name
        }
    },
    MakePurchase = {
        Press = {
            Sound = Sounds.Purchase.Name,
            Haptic = Enum.HapticEffectType.UIClick
        }
    }
}

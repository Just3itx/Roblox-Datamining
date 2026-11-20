-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T10:41:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local _Types = require(scriptParentParent.Types)
local TransitionPreset = require(scriptParentParent.Enums.TransitionPreset)
local module = {
    presets = {
        [TransitionPreset.Default] = {
            duration = 0.3,
            easingStyle = {
                0.2,
                0,
                0,
                1
            },
            delay = 0
        },
        [TransitionPreset.Quick] = {
            duration = 0.05,
            easingStyle = {
                0.2,
                0,
                0,
                1
            },
            delay = 0
        },
        [TransitionPreset.Slow] = {
            duration = 1,
            easingStyle = {
                0.2,
                0,
                0,
                1
            },
            delay = 0
        }
    }
}

function module.getDefaultTransition()
    local preset = module.presets[TransitionPreset.Default]

    return {
        duration = preset.duration,
        easingStyle = preset.easingStyle,
        delay = preset.delay
    }
end

function module.createDefaultTransitionState()
    return {
        default = module.getDefaultTransition()
    }
end

return module

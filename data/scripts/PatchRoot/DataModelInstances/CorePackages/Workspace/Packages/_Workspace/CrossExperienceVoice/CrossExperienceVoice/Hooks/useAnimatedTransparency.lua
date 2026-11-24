-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:01:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CrossExperienceVoice = script:FindFirstAncestor("CrossExperienceVoice")

local useSequentialAnimation = require(CrossExperienceVoice.Hooks.useSequentialAnimation)

return function(num1: number, durationInMs: number, easingStyle)
    local var1, var2 = useSequentialAnimation(num1)

    local function animate(value: number)
        var2({{ value = value, durationInMs = durationInMs, easingStyle = easingStyle }}, nil)
    end

    return var1, animate
end
